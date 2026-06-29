# Luau Guides

## Namings
### Functions
- Use verbs for functions, or variables that are known to be function (will be referred as "Functions")
- For "Functions" known to be `boolean` or `boolean?`, start with `is`, `was`, `has`, `can`, or `should`, end with affirmative statement or noun
- `PascalCase` when creating "Functions" inside or outside function block, when in table key
- `camelCase` when getting function variable as parameter
### Variables
- Use nouns for variables or constants
- For variables known to be `boolean` or `boolean?`, start with `is`, `was`, `has`, `can`, or `should`, end with affirmative statement or noun
- `PascalCase` for variables, constants defined outside function block (between `function()` and its `end`)
- `camelCase` for variables, constants defined inside function block
- `UPPER_CASE` for constants defined outside function block with type of
  - `number`
  - `string`
  - `boolean`
  - table with key of static string, value of static `number`, `string`, `boolean`, or `table` with type of same as this line

## The `const` keyword
- "Constant" means data slots defined with `const` keyword.
- When the value shouldn't be mutated, use constants.
- For reference value to an object, such as table, userdata, buffer, thread, Even when the fields of the referent can change, use it if the `=` keyword will not be used to the reference value directly again.
- Example:
```luau
-- Module Requirements
const PlayerStats = require("@game/ReplicatedStorage/somewhere") -- Always require modules with `const`, as its reference will never change

-- Types
type ItemKey = "Sword" | "Shield"
type PlayerStats = PlayerStats.Stats

task.spawn(function()
	const stats: PlayerStats = PlayerStats:Get()
	stats.Kills += 1 -- OK to mutate the referenced object

	const bufferOfPlayerStats: buffer = p

	--stats = stats() -- Error: cannot reassign the stats reference
	const inventory: { [ItemKey]: number } = {
		Sword = 1,
	}
	inventory.Sword = 2 -- OK to modify inventory
	--inventory = {}        -- Error: inventory is const
end)

```

## Notes

### Variables known to be functions
Do not call variables without verb names, or pass as parameters with function requirement, regardless of whether this is known to be function or not, except with variables of "these names":
- `callback`
- Ending with `Callback`
- `fn`
- `handler`
- Ending with `Handler`
- Starting with `To`, `to`, `From`, and `from`
When a variable is known to be function and doesn't have names these, create a new variable 
with guides defined in Functions, or with "these names" and bind with that variable.
Example:
```luau
const function SomeFunction(optionalParam: () -> (any)?)
    if optionalParam then

        -- Good Examples
        const thread = coroutine.create(function(fn: () -> (any))
            fn()
        end)

        const optionalParamCallback: () -> (any) = optionalParam

        optionalParamCallback()

        -- BAD Examples
        optionalParam()

        task.defer(optionalParam)

        coroutine.resume(thread, optionalParam) -- thread expects to have function parameter, but passed noun variable
    end
end
```
### Strict Mode
- Always include `--!strict` when creating new files
## After rewriting codes
- Use skill `stylua` after writing code
- Use skill `sourcemap` after creating new files
