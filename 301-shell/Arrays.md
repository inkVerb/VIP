# Arrays

## Arrays only work in BASH, not Shell

### I. The Array: A "Quantum Multiverse" Variable

An array is a variable with multiple values, as if each value belongs to a different quantum multiverse.

Shell variable:
```sh
VAR=Something

echo $VAR

# Output is: "Something"

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

In a normal array, each value has a "key" number, the first is `0`.

```bash
# Set the values of the array all at once:
# key: [0] [1] [2]   [3]  [4]
ARRAY=(one two three four five)

# Above is the same as...
ARRAY[0]=one
ARRAY[1]=two
ARRAY[2]=three
ARRAY[3]=four
ARRAY[4]=five

# echo the array value like this...
echo ${ARRAY[0]}
echo ${ARRAY[1]}
echo ${ARRAY[2]}
echo ${ARRAY[3]}
echo ${ARRAY[4]}
```


___

### III. Associative Arrays

In an associative array, the key can become an alpha-numeric value, such as a word.

*(It is easier to find your way around different multiverses if they have names rather than numbers.)*

```bash
# First "declare" an empty "associative" array: "ASCRAY"
declare -A ASCRAY

# Set the values of the array all at once:
# key:      [a]     [b]     [c]       [d]      [e]
ASCRAY=([a]=one [b]=two [c]=three [d]=four [e]=five)

# Above is the same as...
ASCRAY[a]=one
ASCRAY[b]=two
ASCRAY[c]=three
ASCRAY[d]=four
ASCRAY[e]=five

# echo the array value like this...
echo ${ASCRAY[a]}
echo ${ASCRAY[b]}
echo ${ASCRAY[c]}
echo ${ASCRAY[d]}
echo ${ASCRAY[e]}
```

