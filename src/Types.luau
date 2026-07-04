export type TopicData<T> = { -- T means item names
	read EnumNames: { T }, -- key: item numeric value, value: item name
	read EnumValues: { [T]: number }, -- key: item name, value: item numeric value
	read TopicName: string,
}
export type TopicSharedTable<T> = SharedTable & { T } & { TopicName: string }

export type OldTypeSolver_Topic<T> = {
	TryGetNameFromValue: (OldTypeSolver_Topic<T>, value: number) -> T?,
	TryGetValueFromName: (OldTypeSolver_Topic<T>, name: string) -> number?,
	GetNameFromValue: (OldTypeSolver_Topic<T>, value: number) -> T,
	GetValueFromName: (OldTypeSolver_Topic<T>, name: T) -> number,
}

return nil
