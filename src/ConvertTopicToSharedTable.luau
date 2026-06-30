--!strict
-- Module Requirements
const Topic = require("./Topic")
const Types = require("./Types")
-- Types
type TopicData<T> = Types.TopicData<T>
type Topic<T> = Topic.Topic<T>
-- Export function
const function Convert<T>(topic: Topic<T>): Types.TopicSharedTable<T>
	const st = SharedTable.new(topic.EnumNames)
	st.TopicName = topic.TopicName
	return SharedTable.cloneAndFreeze(st)
end

return Convert
