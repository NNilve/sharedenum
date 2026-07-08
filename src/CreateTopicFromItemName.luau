--!strict
-- Module Requirements
const Topic = require("./Topic")
const Types = require("./Types")
-- Types
type TopicData<T> = Types.TopicData<T>
type Topic<T> = Topic.Topic<T>
-- Export function
const function Create<T>(topicName: string, ...: T): Topic<T>
	return require("./CreateTopicFromItemNameWithSize")(topicName, "u8", ...)
end

return Create
