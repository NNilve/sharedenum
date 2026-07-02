const SharedEnum = {}
-- Module requirements
const Topic = require("@self/Topic")
const Types = require("@self/Types")
-- Types
export type Topic<T> = Topic.Topic<T>
export type TopicData<T> = Topic.TopicData<T>
export type TopicSharedTable<T> = Types.TopicSharedTable<T>
export type OldTypeSolver_Topic<T> = Types.OldTypeSolver_Topic<T>
-- Public API Implementation

--[=[
	@function FromItemName
	@within Topic

	@param name string
	@param ... ...string
	@return Topic
	@error "SharedEnum topic {TopicName} enum count of {EnumCount} exceeded max count of {MaxCount}" -- Too many possible enum variants is provided that cannot be fit in 1 byte.
]=]
function SharedEnum.FromItemName<T>(name: string, ...: T & string): Topic<T>
	const fn = require("@self/CreateTopicFromItemName")
	return fn(name, ...)
end
function SharedEnum.ToSharedTable<T>(topic: Topic<T>): TopicSharedTable<T>
	const fn = require("@self/ConvertTopicToSharedTable")
	return fn(topic)
end
--[=[
	@function FromSharedTable
	@within Topic
	@param sharedTable SharedTable
	@return Topic
	@error "SharedEnum topic {TopicName} enum count of {EnumCount} exceeded max count of {MaxCount}" -- Too many possible enum variants is stored in SharedTable that cannot be fit in 1 byte.
]=]
function SharedEnum.FromSharedTable<T>(sharedTable: TopicSharedTable<T>): Topic<T>
	const fn = require("@self/CreateTopicFromSharedTable")
	return fn(sharedTable)
end

-- For old type solver:
const SharedEnum_OldTypeSolver = {}
SharedEnum.OldTypeSolver = SharedEnum_OldTypeSolver

function SharedEnum_OldTypeSolver.FromItemName<T>(name: string, ...: T & string): OldTypeSolver_Topic<T>
	return SharedEnum.FromItemName(name, ...) :: any
end

function SharedEnum_OldTypeSolver.ToSharedTable<T>(topic: OldTypeSolver_Topic<T>): TopicSharedTable<T>
	return SharedEnum.ToSharedTable(topic :: any)
end

function SharedEnum_OldTypeSolver.FromSharedTable<T>(sharedTable: TopicSharedTable<T>): OldTypeSolver_Topic<T>
	return SharedEnum.FromSharedTable(sharedTable) :: any
end

return SharedEnum
