--!strict
const LogService = game:GetService("LogService")
-- Module requirements
const Types = require("./Types")
-- Types
export type TopicData<T> = Types.TopicData<T>
-- Class
--[=[
	@class Topic

	Represents the list of possible enum variant string.
]=]
const Topic = {}
Topic.__index = Topic
export type Topic<T> = setmetatable<TopicData<T>, typeof(Topic)>
-- Private Helper Functions
-- Public API Implementation
--[[
    NOTE: For Reducing Memory Overhead for parallel luau,
    topic creation is moved to seperate module:
    - `CreateTopicFromItemName`
    - `CreateTopicFromSharedTable`
]]

--[=[
	Returns the variant name from numeric value, or nil if the value is invalid.

	@method TryGetNameFromValue
	@within Topic
	@param value number
	@return string?
]=]
@native
function Topic.TryGetNameFromValue<T>(self: Topic<T>, value: number): T?
	return self.EnumNames[value]
end

--[=[
	Returns the numeric value of variant name, or nil if the variant name is invalid.

	@method TryGetValueFromName
	@within Topic
	@param name string
	@return number?
]=]
@native
function Topic.TryGetValueFromName<T>(self: Topic<T>, name: T): number?
	return self.EnumValues[name]
end

--[=[
	Returns the variant name from numeric value.

	@method GetNameFromValue
	@within Topic
	@param value number
	@return string
	@error "Enum of Value {EnumValue} not found in SharedEnum topic {TopicName}" -- The passed `value` parameter is invalid.
]=]
@native
function Topic.GetNameFromValue<T>(self: Topic<T>, value: number): T
	const name = self.EnumNames[value]
	if not name then
		task.synchronize()
		LogService:Error("Enum of Value {EnumValue} not found in SharedEnum topic {TopicName}", {
			EnumValue = value,
			TopicName = tostring(self.TopicName),
		})
	end
	return name
end
--[=[
	Returns the numeric value of variant name.
	
	@method GetValueFromName
	@within Topic
	@param value number
	@return string
	@error "Enum '{EnumName}' not found in SharedEnum topic {TopicName}" -- The passed `name` parameter is invalid.
]=]
@native
function Topic.GetValueFromName<T>(self: Topic<T>, name: T): number
	const value = self.EnumValues[name]
	if not value then
		task.synchronize()
		LogService:Error("Enum '{EnumName}' not found in SharedEnum topic {TopicName}", {
			EnumName = name,
			TopicName = tostring(self.TopicName),
		})
	end

	return value
end
return Topic
