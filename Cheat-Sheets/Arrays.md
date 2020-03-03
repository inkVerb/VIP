# Arrays

## Arrays only work in BASH, not Shell

### I. The Array: A "Quantum Multiverse" Variable

An array is a variable with multiple values, as if each value belongs to a different quantum multiverse.

Shell variable:
```sh
Var=Something

echo $Var

# Output: "Something"

```

BASH "multiverse" variable (AKA 'array'):
```bash
Array=(Something Otherthing)

echo ${Array[0]}
# Output: "Something"

echo ${Array[1]}
# Output: "Otherthing"

# Note: If you don't define an alternate multiverse, it will use the base, 0
echo $Array
# Output: "Something"

```

### II. Normal Keys

In a normal array, each value has an index "key" number, the first is `0`.

```bash
# Set the values of the array all at once:
# key: [0] [1] [2]   [3]  [4]  (alternative multiverse numbers, 0 is the base multiverse)
Array=(one two three four five)

# Above is the same as...
Array[0]=one
Array[1]=two
Array[2]=three
Array[3]=four
Array[4]=five

# echo the array values like this...
echo ${Array[0]}
echo ${Array[1]}
echo ${Array[2]}
echo ${Array[3]}
echo ${Array[4]}
```

___

### III. Associative Arrays

In an associative array, the index key can become an alpha-numeric value, such as a word.

*(It is easier to find your way around different multiverses if they have names rather than numbers.)*

```bash
# First "declare" an empty "associative" array: "AsocArr"
declare -A AsocArr

# Set the values of the array all at once:
# key:      [a]     [b]     [c]       [d]      [e]  (multiverse names)
AsocArr=([a]=one [b]=two [c]=three [d]=four [e]=five)

# Above is the same as...
AsocArr[a]=one
AsocArr[b]=two
AsocArr[c]=three
AsocArr[d]=four
AsocArr[e]=five

# echo the array values like this...
echo ${AsocArr[a]}
echo ${AsocArr[b]}
echo ${AsocArr[c]}
echo ${AsocArr[d]}
echo ${AsocArr[e]}
```

### IV. Special Characters: `@` `*` `!` `#`
- `$array[@]` returns all array values *as separate values*
- `$array[*]` returns all array values *as a single, long value*
- `$array[!]` returns all index keys *as separate values*
- `$array[#]` returns the total number of values
