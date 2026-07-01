--!strict
-- Module Requirements
const Topic = require("./Topic")
const Types = require("./Types")
-- Types
type TopicData<T> = Types.TopicData<T>
type Topic<T> = Topic.Topic<T>
type TopicSharedTable<T> = Types.TopicSharedTable<T>
-- Export function
const function Convert<T>(topic: Topic<T>): TopicSharedTable<T>
	const st = SharedTable.new(topic.EnumNames) :: TopicSharedTable<T>
	st.TopicName = topic.TopicName
	const clone = SharedTable.cloneAndFreeze(st) :: TopicSharedTable<T>
	return clone
end

return Convert
