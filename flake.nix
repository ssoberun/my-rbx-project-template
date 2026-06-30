{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        wally-package-types-pkg = pkgs.rustPlatform.buildRustPackage rec {
          pname = "wally-package-types";
          version = "1.6.2";

          src = pkgs.fetchFromGitHub {
            owner = "JohnnyMorganz";
            repo = "wally-package-types";
            rev = "v${version}";
            hash = "sha256-ynd5z2pbhGnPTKuJQG4EJL/Zy/X9lTCjSi8Cd6nRSsA=";
          };

          cargoHash = "sha256-LjtnArnv46GzbHnpT3wFNrjCv78stfFc6Kx9RefK+U8=";

          meta = with pkgs.lib; {
            description = "A small tool which fixes the issue of wally thunks not including exported types, necessary for proper Luau type checking support.";
            homepage = "https://github.com/JohnnyMorganz/wally-package-types";
            license = licenses.mit;
            maintainers = [ ssoberun ];
            mainProgram = "wally-package-types";
          };
        };

        # sh scripts
        install-packages-sh = pkgs.writeShellApplication {
          name = "install-packages";
          runtimeInputs = [
            pkgs.argon
            pkgs.wally
            wally-package-types-pkg
          ];
          text =
            let
              lib = pkgs.lib;
              argon = lib.getExe pkgs.argon;
              wally = lib.getExe pkgs.wally;
              wally-package-types = lib.getExe wally-package-types-pkg;
            in
            ''
              set -e
              ${wally} install
              # Patch the Wally package link modules to also export Luau type definitions.
              ${argon} sourcemap default.project.json -o sourcemap.json
              ${wally-package-types} --sourcemap sourcemap.json Packages/
              ${wally-package-types} --sourcemap sourcemap.json ServerPackages/
            '';
        };

        analyze-sh = pkgs.writeShellApplication {
          name = "analyze";
          runtimeInputs = [
            pkgs.argon
            pkgs.luau-lsp
            pkgs.curl
          ];
          text =

            # sh
            ''
              # If Packages aren't installed, install them.
              if [ ! -d "Packages" ]; then
                ${pkgs.lib.getExe install-packages-sh}
              fi

              ${pkgs.lib.getExe pkgs.argon} sourcemap default.project.json -o sourcemap.json
              ${pkgs.lib.getExe pkgs.curl} -O https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.lua

              ${pkgs.lib.getExe pkgs.luau-lsp} analyze --definitions=globalTypes.d.lua --base-luaurc=.luaurc \
                --sourcemap=sourcemap.json --settings=.vscode/settings.json \
                --no-strict-dm-types --ignore Packages/**/*.lua --ignore Packages/**/*.luau \
                src/
            '';
        };

        dev-sh = pkgs.writeShellApplication {
          name = "dev";
          runtimeInputs = [
            pkgs.argon
            pkgs.darklua
          ];
          text =
            # sh
            ''
              #!/bin/sh

              set -e

              # If Packages aren't installed, install them.
              if [ ! -d "Packages" ]; then
                ${pkgs.lib.getExe install-packages-sh}
              fi

              ${pkgs.lib.getExe pkgs.argon} serve build.project.json \
                &
              ${pkgs.lib.getExe pkgs.argon} sourcemap default.project.json -o sourcemap.json --watch \
                &
              ROBLOX_DEV=true ${pkgs.lib.getExe pkgs.darklua} process --config .darklua.json --watch src/ dist/
            '';
        };

      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            # default pkgs
            pkgs.argon
            pkgs.rojo
            pkgs.wally
            pkgs.tarmac
            pkgs.darklua
            pkgs.luau-lsp
            wally-package-types-pkg

            # scripts
            install-packages-sh
            dev-sh
            # analyze-sh
          ];
        };
      }
    );
}
