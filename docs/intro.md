---
sidebar_position: 1
---

# Getting started

SharedEnum assigns stable one-byte numeric values to repeated string literals. It is useful when strings cross boundaries where Roblox cannot reuse interned strings, including remote calls, attributes, and buffers.

## Installation

### For file-based project management tool (Rojo, etc..)

Add SharedEnum to your `wally.toml` dependencies:

```toml
[dependencies]
SharedEnum = '{!WALLY_PACKAGE_NAME}@{!PACKAGE_VERSION}'
```

Then install packages with `wally install`.

### Using Roblox Models
At right sidebar, click `Releases`.
Download the `SharedEnum.rbxm` file.

## Use the module

### For scripts using New Type Solver
This module is made using New Type Solver internally, so it is recommended to enable New Type Solver
```luau
const SharedEnum = require("Replace this with path to SharedEnum")
```
### For scripts NOT using New Type Solver
For users does not want to allow Luau Type Solver, call `.GetOldTypeSolverVersion()`.
```luau
const SharedEnum = require("Replace this with path to SharedEnum").GetOldTypeSolverVersion()
```
The module returns same table with New Type Solver version table, except types are casted to Old Type Solver Compatible version.

## Create definition of enums
In SharedEnum, we call named bundle of enum definitions **topic**
### What is topic?
Topic contains definition of topics. 
Provides methods to get name from numeric value or vice versa.
### Create a topic
Storing topics at `ModuleScript` under `ReplicatedStorage` is recommended.

Here's a basic function for creating topic:
```lua
SharedEnum.FromItemName(name, ...)
```

- `name`: this means the name for topic, currently used as debugging, but more usage will be added.
- `...`: replace this with strings you like to put in enum up to 255, seperated with `, `.

Example Topic:
```luau
type EnemyStates = "Idle" | "Chase" | "UseSkill" | "Dead" 


-- For New Type Solver
type Topic<T> = SharedEnum.Topic<T>
-- For Old Type Solver
type Topic<T> = SharedEnum.OldTypeSolver_Topic<T>

const EnemyStatesEnum: Topic<EnemyStates> = SharedEnum.FromItemName(
	-- Name the topic
	"EnemyStates", 
    -- Pass any number of variant string between 1 and 255
	"Idle",
	"Chase",
	"UseSkill",
	"Dead"
)
```
## Get numeric value of enums
Call `:GetValueFromName()` to get the numeric value of enum name
```luau
Enemy.StateChanged:Connect(function(state)
	RemoteEvent:FireAllClients(Enemy.Id, EnemyStatesEnum:GetValueFromName(state))
end)
```
## Get enum name from its numeric value
Call `:GetNameFromValue()` to get the name from its numeric value
```luau
RemoteEvent.OnClientEvent:Connect(function(enemyId, stateValue)
	const state = EnemyStatesEnum:GetNameFromValue(stateValue)
	print("Enemy ID", enemyId, "state changed to:", state)
end)
```

## Return as option when name or value may not be valid
TODO: Add Client RemoteEvent + User Input Enum Type + Another SharedEnum topic example
There may be situations that input type may not be valid for example:
- Client-fired remote event that may contain invalid values,
- User inputs
- Cloud API Corruption or Outdated Place

```luau
type Weapons = "Pistol"
| "Rifle"
| "Dagger"
| "Grenade"
const WeaponsEnum: Topic<EnemyStates> = SharedEnum.FromItemName(
	"Weapons", 
    ---
	"Pistol",
	"Rifle",
	"Dagger",
	"Grenade"
)
```
### Optional Value Return
This would be needed, for example, user-provided variant name
```luau
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	const weaponNameUserInput: string = TextBox.Text
	const weaponValue: number? = WeaponsEnum:TryGetValueFromName(weaponNameUserInput)
	if weaponValue then
		RemoteEvent:Fire(weaponValue)
	end

end)
```

### Optional Name Return
This is needed when decoding events from Client-fired remote events, Messaging Service, Data or Memory store entry
```luau
const ServerStorage = game:GetService("ServerStorage")

const Pistol = ServerStorage.Pistol
const Rifle	= ServerStorage.Rifle
const Dagger = ServerStorage.Dagger
const Grenade = ServerStorage.Grenade

RemoteEvent.OnServerEvent:Connect(function(player, weaponId)
	if not ValidatePlayer(player) then 
		return
	end

	const weaponName: EnemyStates? = WeaponsEnum:TryGetNameFromValue()
	if not weaponName then
		return
	end

	InventoryModule:GiveItem(player, weaponName)
end)
```
## Advanced
When looking for advanced features, see API Docs. Advanced features sections are coming soon!