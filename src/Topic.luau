--!strict
const LogService = game:GetService("LogService")
-- Module requirements
const Types = require("./Types")
-- Types
export type TopicData<T> = Types.TopicData<T>
-- Class
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

--[[
	Try Get Name from topic
	Returns nil if not exists
]]
@native
function Topic.TryGetNameFromValue<T>(self: Topic<T>, value: number): T?
	return self.EnumNames[value]
end
@native
function Topic.TryGetValueFromName<T>(self: Topic<T>, name: T): number?
	return self.EnumValues[name]
end
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
@native
function Topic.GetValueFromName<T>(self: Topic<T>, name: T): number
	const value = self.EnumValues[name]
	if not name then
		task.synchronize()
		LogService:Error("Enum '{EnumName}' not found in SharedEnum topic {TopicName}", {
			EnumName = name,
			TopicName = tostring(self.TopicName),
		})
	end

	return value
end
return Topic
