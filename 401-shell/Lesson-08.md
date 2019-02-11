# Shell 401
## Lesson 8: `$IFS` (Internal Field Separator)

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

The `$IFS` variable is a character that separates "fields". You could say it separates words (fields). It's related to looping, but not directly.

"Fields" are important because a `for` loop will loop once per field.

...The question is: ***What constitutes a field?***

If we define the `$IFS` variable as "a new line", that's like saying, "Each '*'word' (field)* is separated by a *'new line'*."

Let's run a `for` loop that separates each field as a "new line"...
___

### I. Simple loop

*Edit a new file*

`gedit looplines`

*Put this code in the new file and save it:*

```sh
#!/bin/sh

IFS=$'\n' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EachLine in $(cat countfile); do

echo "IFS looped this once: $EachLine"

done
```

*Make it executable*

`chmod ug+x looplines`

`ls`

*Run it and watch carefully*

`./looplines`

### II. Complex loop

Integrate `pwgen` with `sed` in a `for` loop...

*Edit a new file*

`gedit looprandom`

*Put this code in the new file and save it:*

```sh
#!/bin/sh

IFS=$'\n' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EveryLine in $(cat countfile); do

RANDOM_string="$(pwgen -s -1 8)" # Each $RANDOM_string will be different in each loop

echo "$EveryLine" | sed "s/add2end/$RANDOM_string/" >> randomlooped

done

unset IFS # We don't want our strange settings messing with other things.
```

*Make it executable*

`chmod ug+x looprandom`

`ls`

*Run it*

`./looprandom`

`ls`

*Note the file created:* `randomlooped`

`gedit randomlooped`

### III. `$IFS` = TAB

*Remember those tabs in the file? Find the double tabs and expand them...*

*Remember:* `\t` *= tab*

sed -i "s/\t\t/\tword1\tword2\tword3\t/" randomlooped

*gedit: Reload randomlooped*

Set `$IFS` to a "tab"

*Edit a new file*

`gedit looptab`

*Put this code in the new file and save it:*

```sh
#!/bin/sh

IFS=$'\t' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EveryTAB in $(cat randomlooped); do

echo "IFS set as \"\t\" will loop this once: $EveryTAB"

done

unset IFS # We don't want our strange settings messing with other things.
```

*Make it executable*

`chmod ug+x looptab`

`ls`

*Run it and watch carefully*

`./looptab`

#### [Lesson 9: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-09.md)
