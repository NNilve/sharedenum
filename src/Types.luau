export type TopicData<T> = { -- T means item names
	read EnumNames: { T }, -- key: item numeric value, value: item name
	read EnumValues: { [T]: number }, -- key: item name, value: item numeric value
	read TopicName: string,
}
export type TopicSharedTable<T> = SharedTable & { T } & { TopicName: string }
return nil
