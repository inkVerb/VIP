# Shell 401
## Lesson 8: `$IFS` (Internal Field Separator)

`cd ~/School/VIP/shell/401`

___

The `$IFS` variable is a character that separates "fields". You could say it separates words (fields). It's related to looping, but not directly.

"Fields" are important because a `for` loop will loop once per field.

...The question is: ***What constitutes a field?***

If we define the `$IFS` variable as "a new line", that's like saying, "Each '*'word' (field)* is separated by a *'new line'*."

Let's run a `for` loop that separates each field as a "new line"...
___

### I. Simple loop

*Edit this script*

| **1** : `gedit looplines`

*It should look like this:*

```sh
#!/bin/sh

IFS=$'\n' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EachLine in $(cat countfile); do

echo "IFS looped this once: $EachLine"

done
```

*Make sure it's executable*

| **2** : `chmod ug+x looplines && ls`

*Run it and watch carefully*

| **3** : `./looplines`

### II. Complex loop

Integrate `pwgen` with `sed` in a `for` loop...

*Edit this script*

| **4** : `gedit looprandom`

*It should look like this:*

```sh
#!/bin/sh

IFS=$'\n' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EveryLine in $(cat countfile); do

RANDOM_string="$(pwgen -s -1 8)" # Each $RANDOM_string will be different in each loop

echo "$EveryLine" | sed "s/add2end/$RANDOM_string/" >> randomlooped

done

unset IFS # We don't want our strange settings messing with other things.
```

*Make sure it's executable*

| **5** : `chmod ug+x looprandom && ls`

*Run it*

| **6** : `./looprandom`

| **7** : `ls`

*Note the file created:* `randomlooped`

| **8** : `gedit randomlooped`

### III. `$IFS` = TAB

*Remember those tabs in the file? Find the double tabs and expand them...*

*Remember:* `\t` *= tab*

sed -i "s/\t\t/\tword1\tword2\tword3\t/" randomlooped

*gedit: Reload randomlooped*

Set `$IFS` to a "tab"

*Edit this script*

| **9** : `gedit looptab`

*It should look like this:*

```sh
#!/bin/sh

IFS=$'\t' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EveryTAB in $(cat randomlooped); do

echo "IFS set as \"\t\" will loop this once: $EveryTAB"

done

unset IFS # We don't want our strange settings messing with other things.
```

*Make sure it's executable*

| **10** : `chmod ug+x looptab && ls`

*Run it and watch carefully*

| **11** : `./looptab`

___

# The Take

-

___

#### [Lesson 9: Interpreters, errors, logic, and empty testing](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-09.md)
