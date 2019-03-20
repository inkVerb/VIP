# Arrays

## Arrays only work in BASH, not Shell

### I. The Array: A "Quantum Multiverse" Variable

An array is a variable with multiple values, as if each value belongs to a different quantum multiverse.

Shell variable:
```sh
VAR=Something

echo $VAR

# Output: "Something"

```

BASH "multiverse" variable (AKA 'array'):
```bash
ARRAY=(Something Otherthing)

echo ${ARRAY[0]}
# Output: "Something"

echo ${ARRAY[1]}
# Output: "Otherthing"

# Note: If you don't define an alternate multiverse, it will use the base, 0
echo $ARRAY
# Output: "Something"

```

### II. Normal Keys

In a normal array, each value has an index "key" number, the first is `0`.

```bash
# Set the values of the array all at once:
# key: [0] [1] [2]   [3]  [4]  (alternative multiverse numbers, 0 is the base multiverse)
ARRAY=(one two three four five)

# Above is the same as...
ARRAY[0]=one
ARRAY[1]=two
ARRAY[2]=three
ARRAY[3]=four
ARRAY[4]=five

# echo the array values like this...
echo ${ARRAY[0]}
echo ${ARRAY[1]}
echo ${ARRAY[2]}
echo ${ARRAY[3]}
echo ${ARRAY[4]}
```

___

### III. Associative Arrays

In an associative array, the index key can become an alpha-numeric value, such as a word.

*(It is easier to find your way around different multiverses if they have names rather than numbers.)*

```bash
# First "declare" an empty "associative" array: "ASCRAY"
declare -A ASCRAY

# Set the values of the array all at once:
# key:      [a]     [b]     [c]       [d]      [e]  (multiverse names)
ASCRAY=([a]=one [b]=two [c]=three [d]=four [e]=five)

# Above is the same as...
ASCRAY[a]=one
ASCRAY[b]=two
ASCRAY[c]=three
ASCRAY[d]=four
ASCRAY[e]=five

# echo the array values like this...
echo ${ASCRAY[a]}
echo ${ASCRAY[b]}
echo ${ASCRAY[c]}
echo ${ASCRAY[d]}
echo ${ASCRAY[e]}
```

### IV. Special Characters: `@` `*` `!` `#`
- `$array[@]` returns all array values *as separate values*
- `$array[*]` returns all array values *as a single, long value*
- `$array[!]` returns all index keys *as separate values*
- `$array[#]` returns the total number of values
