const SharedEnum = {}
-- Module requirements
const Topic = require("@self/Topic")
const Types = require("@self/Types")
-- Types
export type Topic<T> = Topic.Topic<T>
export type TopicData<T> = Topic.TopicData<T>
export type TopicSharedTable<T> = Types.TopicSharedTable<T>
-- Public API Implementation
function SharedEnum.fromItemName<T>(name: string, ...: T & string): Topic<T>
	const fn = require("@self/CreateTopicFromItemName")
	return fn(name, ...)
end
function SharedEnum.ToSharedTable<T>(topic: Topic<T>): TopicSharedTable<T>
	const fn = require("@self/ConvertTopicToSharedTable")
	return fn(topic)
end
function SharedEnum.FromSharedTable<T>(sharedTable: TopicSharedTable<T>): Topic<T>
	const fn = require("@self/CreateTopicFromSharedTable")
	return fn(sharedTable)
end
return SharedEnum
