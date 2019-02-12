# Shell 401
## Lesson 9: Simple Tests & heredoc `cat <<EOF`

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

## Under Construction

### I. Simple tests

VAR=true
$VAR && echo "Is true."
VAR=false
$VAR || echo "Is false."
VAR="true"
echo "Is $VAR."
VAR="false"
echo "Is $VAR"

-z & unset "the proper way" (VAR=$1; $VAR # Is $VAR set? # Use some arithmetic to see.) [top three answers here](https://serverfault.com/questions/7503/how-to-determine-if-a-bash-variable-is-empty)


### II. heredoc `cat <<EOF`

cat <<EOF (https://stackoverflow.com/questions/2500436/how-does-cat-eof-work-in-bash)


#### [Lesson 10: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-10.md)
