--!strict
local LogService = game:GetService("LogService")
-- Module Requirements
const Topic = require("./Topic")
const Types = require("./Types")
-- Types
type TopicData<T> = Topic.TopicData<T>
type Topic<T> = Topic.Topic<T>
type TopicSharedTable<T> = Types.TopicSharedTable<T>
-- Export function
const function Create<T>(sharedTable: TopicSharedTable<T>): Topic<T>
	if not SharedTable.isFrozen(sharedTable) then
		LogService:Error("Expected Frozen SharedTable, got not frozen")
	end

	const topicName = sharedTable.TopicName
	if typeof(topicName) ~= "string" then
		LogService:Error("SharedEnum topic name expected string, got {TopicNameType}, tostring: {TopicNameTostring}", {
			TopicNameType = typeof(topicName),
			TopicNameTostring = tostring(topicName),
		})
	end

	const enumCount = SharedTable.size(sharedTable) - 1
	if enumCount <= 0 then
		LogService:Error("SharedEnum topic {TopicName} has no enums", {
			TopicName = tostring(topicName),
		})
	end
	if enumCount > 255 then
		LogService:Error("SharedEnum topic {TopicName} enum count of {EnumCount} exceeded max count of {MaxCount}", {
			TopicName = tostring(topicName),
			EnumCount = enumCount,
			MaxCount = 255,
		})
	end

	const namesTable = table.create(enumCount) :: { T & string }
	const valuesTable: { [T & string]: number } = {}

	for enumValue, enumName in sharedTable :: any do
		if typeof(enumValue) == "number" then
			if typeof(enumName) ~= "string" then
				LogService:Error(
					"Enum name at value {EnumValue} in SharedEnum topic {TopicName}"
						.. "expected string, got {EnumNameType}, tostring: {EnumNameTostring}",
					{
						EnumNameType = typeof(enumName),
						EnumValue = enumValue,
						TopicName = tostring(topicName),
						EnumNameTostring = tostring(enumName),
					}
				)
			end

			namesTable[enumValue] = enumName
			valuesTable[enumName] = enumValue
		end
	end

	const data: TopicData<T> = {
		EnumNames = namesTable,
		EnumValues = valuesTable,
		TopicName = topicName,
		SizeKind = sharedTable.SizeKind,
	}

	table.freeze(namesTable)
	table.freeze(valuesTable)

	setmetatable(data, Topic)
	return data
end

return Create
