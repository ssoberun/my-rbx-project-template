local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)


export type side = "up" | "right" | "left" | "down"
export type flip_axis = "horizontal" | "vertical"

export type slot_data = {
	amount: number;
};

export type context_slots = "";

export type context_data = {
	project_on_part: BasePart;
	projection_offset: vector?;
	part_label: string?;
	slots: {[string]: slot_data};
}

export type context = {
	[string]: context_data;
}

export type ModifyHealthContext = {
	from: Jecs.Entity;
	to: Jecs.Entity;
	timestamp: number;
	damageType: string;
	amount: number;
	position: Vector3;
	isCritical: boolean?;
}

export type DamageEvent = {
	target: Jecs.Entity;
	from: Jecs.Entity;
	type: string;
	amount: number;
}

export type HealEvent = {
	target: Jecs.Entity,
	from: Jecs.Entity,
	type: string;
	amount: number;
}

return nil

