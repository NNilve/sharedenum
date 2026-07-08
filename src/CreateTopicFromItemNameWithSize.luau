--!strict
local LogService = game:GetService("LogService")
-- Module Requirements
const Topic = require("./Topic")
const Types = require("./Types")
const Const = require("./Const")
-- Types
type TopicData<T> = Types.TopicData<T>
type Topic<T> = Topic.Topic<T>
-- Export function
const function Create<T>(topicName: string, size: "u8" | "u16", ...: T): Topic<T>
	if typeof(topicName) ~= "string" then
		LogService:Error("SharedEnum topic name expected string, got {TopicNameType}, tostring: {TopicNameTostring}", {
			TopicNameType = typeof(topicName),
			TopicNameTostring = tostring(topicName),
		})
	end
	local maxEnumCount
	if size == "u8" then
		maxEnumCount = Const.SIZE_U8
	elseif size == "u16" then
		maxEnumCount = Const.SIZE_U16
	else
		LogService:Error(
			'Size "{SizeTostring}" is not valid argument,' .. "expected to be either u8 or u16",
			{ SizeTostring = tostring(size) }
		)
		error("never") -- actually unreachable, it's for linter
	end

	const enumCount = select("#", ...)
	if enumCount <= 0 then
		LogService:Error("SharedEnum topic {TopicName} has no enums", {
			TopicName = tostring(topicName),
		})
	end
	if enumCount > maxEnumCount then
		LogService:Error(
			"SharedEnum topic {TopicName} enum count of" .. "{EnumCount} exceeded max count of {MaxCount}",
			{
				TopicName = tostring(topicName),
				EnumCount = enumCount,
				MaxCount = maxEnumCount,
			}
		)
	end

	const namesTable = table.create(enumCount) :: { T }
	const valuesTable: { [T]: number } = {}

	for i = 1, enumCount do
		const enumName = select(i, ...)
		const enumValue = i

		if typeof(enumName) ~= "string" then
			LogService:Error(
				"Enum name at value {EnumValue} in SharedEnum topic {TopicName} "
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

	const data: TopicData<T> = {
		EnumNames = namesTable,
		EnumValues = valuesTable,
		TopicName = topicName,
		SizeKind = size,
	}

	table.freeze(namesTable)
	table.freeze(valuesTable)

	setmetatable(data, Topic)
	return data
end

return Create
