--!strict
const SharedEnum = {}
-- Module requirements
const Topic = require("@self/Topic")
const Types = require("@self/Types")
const Const = require("@self/Const")
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
	const fn = require("@self/CreateTopicFromItemNameWithSize")
	const enumCount = select("#", ...)
	if enumCount <= Const.SIZE_U8 then
		return fn(name, "u8", ...)
	elseif enumCount <= Const.SIZE_U16 then
		return fn(name, "u16", ...)
	else
		error("too many arguments")
	end
end
--[=[
	@function FromItemNameWithSize
	@within Topic

	@param name string
	@param sizeKind string
	@param ... ...string
	@return Topic
	@error "SharedEnum topic {TopicName} enum count of {EnumCount} exceeded max count of {MaxCount}" -- Too many possible enum variants is provided that cannot be fit in 1 byte.
]=]
function SharedEnum.FromItemNameWithSize<T>(
	name: string,
	sizeKind: "u8" | "u16",
	...: T & string
): Topic<T>
	const fn = require("@self/CreateTopicFromItemNameWithSize")
	return fn(name, sizeKind, ...)
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
const function GetOldTypeSolverVersion()
	return SharedEnum :: {
		FromItemName: <T>(name: string, ...(T & string)) -> OldTypeSolver_Topic<T>,
		ToSharedTable: <T>(topic: OldTypeSolver_Topic<T>) -> TopicSharedTable<T>,
		FromSharedTable: <T>(sharedTable: TopicSharedTable<T>) -> OldTypeSolver_Topic<T>,
	}
end

SharedEnum.GetOldTypeSolverVersion = GetOldTypeSolverVersion

return SharedEnum
