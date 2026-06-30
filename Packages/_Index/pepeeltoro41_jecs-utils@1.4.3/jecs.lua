local REQUIRED_MODULE = require(script.Parent.Parent["ukendio_jecs@0.11.0"]["jecs"])
export type Archetype = REQUIRED_MODULE.Archetype 
export type QueryInner = REQUIRED_MODULE.QueryInner 
export type Entity<T > = REQUIRED_MODULE.Entity<T >
export type Id<T = any> = REQUIRED_MODULE.Id<T >
export type Pair<First=any, Second=any> = REQUIRED_MODULE.Pair<First, Second>
export type Component<T=any> = REQUIRED_MODULE.Component<T>
export type Id2<First, Second> = REQUIRED_MODULE.Id2<First, Second>
export type Item<T...> = REQUIRED_MODULE.Item<T...>
export type Iter<T...> = REQUIRED_MODULE.Iter<T...>
export type Cached_Query_Iter<T...> = REQUIRED_MODULE.Cached_Query_Iter<T...>
export type Cached_Query<T...> = REQUIRED_MODULE.Cached_Query<T...>
export type Query<T...> = REQUIRED_MODULE.Query<T...>
export type Observer = REQUIRED_MODULE.Observer 
export type observer = REQUIRED_MODULE.observer 
export type World = REQUIRED_MODULE.World 
export type Record = REQUIRED_MODULE.Record 
export type ComponentRecord = REQUIRED_MODULE.ComponentRecord 
export type ComponentIndex = REQUIRED_MODULE.ComponentIndex 
export type Archetypes = REQUIRED_MODULE.Archetypes 
export type EntityIndex = REQUIRED_MODULE.EntityIndex 
return REQUIRED_MODULE
