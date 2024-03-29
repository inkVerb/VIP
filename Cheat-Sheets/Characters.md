# Characters for Classes & RegEx
**RegEx** meas "Regular Expression", which is what we call a way to express characters like this

*Refer to this lesson for an introduction to escaping special characters:* [Linux 101 Lesson 11](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-11.md)

*Refer to this lesson for an introduction to character classes:* [Linux 401 Lesson 11](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-11.md)

*Much of this information was taken from the GNU sed manual:* [5.5 Character Classes and Bracket Expressions](https://www.gnu.org/software/sed/manual/html_node/Character-Classes-and-Bracket-Expressions.html)
___

## Class key
### Custom character class ranges

Ranges of most alphanumeric characters can be listed intuitively
- `[^]` "not" (inside `[`brackets`]`)
- `|` "or"
- `-` indicates range
- `^` start of line
- `$` end of line
- `.` wildcard: any character except `\n` (new line)

A `[`range`]` represents only one character, unless there is a `{`string length`}` statement
- `{}` string length (if more than one character)
  - `{4}` four characters
  - `{5,}` minimum five characters
  - `{,7}` maximum seven characters
  - `{1,10}` 1 to 10 characters
- Use with ranges and classes:
  - `[a-j]{5,17}` letters `a` through `j`, 5 to 17 characters long
  - `.{16,}` any character except new line, at least 16 characters long
  - `^[.{1,}$` 

**Range Examples:**
- `[abc]` any characters of `a`, `b`, and `c`
- `[^abc]` 'negative character set': all lowercase characters other than `a`, `b`, and `c`
- `[^a-m]` 'negative character set': all lowercase characters outside the range of `a`-`m`
- `[a-h]` lowercase letters `a`-`h`
- `[2-8]` numbers `2`-`8`
- `[A-Z]` all uppercase letters `A`- `Z`
- `[A-Za-z]` all uppercase or lowercase letters
- `[y|Y]` one lowercase or uppercase `y`
- `[a|b|c]` one character: `a` or `b` or `c`
- `[dog|fish|cat]` one word of: `dog` or `fish` or `cat`
- `^[A-Z]` line starts with any capital letter
- `[a-z]$` line ends with any lowercase letter
- `Ye[st]` matches `Yes` or `Yet`
- `^The` line starts with `The`
- `^N[a-z][^w]$` line starts with `N`, any lowercase letters, line does ***not*** end with `w`

`grep` and other commands like `sed` need some characters cancelled to work in the regex
- `[` must be `\[`
  - `^[.....]$` --> `grep '^\[.....]$' file` matches `[range]`
- `{}` must be `\{\}`
  - `^[.{5}]$` --> `grep '^\[.\{5\}]$' file` matches `[range]`

### Classes
Note these must go inside brackets, like this: `[[:upper:]]` or `[a-Z[:lower:]]` or `[[:upper:][:punct:]]`

- `[:upper:]`
Upper-case letters: `[A-Z]`, containing `A B C D E F G H I J K L M N O P Q R S T U V W X Y Z`

- `[:lower:]`
Lower-case letters: `[a-z]`, containing `a b c d e f g h i j k l m n o p q r s t u v w x y z`

- `[:digit:]`
Digits: `[0-9]`, containing `0 1 2 3 4 5 6 7 8 9`

- `[:xdigit:]`
Hexadecimal digits, containing `0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f`

- `[:punct:]`
Punctuation characters: ``! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~. ``

### Grouped classes
- `[:graph:]`
Graphical characters: `[:alnum:]` and `[:punct:]`

- `[:alnum:]`
Alphanumeric characters: same as `[0-9A-Za-z]` AKA `[:alpha:]` & `[:digit:]`

- `[:alpha:]`
Alphabetic characters: same as `[A-Za-z]` AKA `[:lower:]` & `[:upper:]`

- `[:print:]`
Printable characters: `[:alnum:]`, `[:punct:]`, 'space' (not 'tab')

- `[:space:]`
Space characters, containing 'tab', 'newline', 'vertical tab', 'form feed', 'carriage return', 'space'

- `[:blank:]`
"Blank" characters: 'space' & 'tab'

- `[:cntrl:]`
Control characters: In ASCII, these characters have octal codes 000 through 037, and 177 (DEL). In other character sets, these are the equivalent characters, if any.

### Range characters with special meaning:
- `]`
  - `[]ets]` Works, matches `]`, `e`, `t` & `s`
  - `[e]ts]` Fail, only matches string `ets]`
  - `[e]]t]` matches `e]t]`
  - `[e]t]` matches `et]`

*ends the bracket expression - put first in `[list]` to use this character*

- `-`

*"range" - put first or last in `[list]` to use this character*

- `^`

*characters "not in the `[list]`" - put anywhere but first to use this character*

### Shell command examples that "transform" characters
- from upper to lower case
`tr "[A-Z]" "[a-z]"`

- from lower to upper case
`tr "[a-z]" "[A-Z]"`

- all to lower case
`sed -i 's/\(.*\)/\L\1/' file`

## RegEx Metacharacters
(NOT character class ranges in `[`brackets`]`)

- `\` Quote/cancel special characters
- `^` Beginning of line/string
- `$` End of line/string
- `*` Wildcard
- `g` Global (all instances on each line, not only the first instance on a line)
- `\f` Form-feed character
- `\n` New line
- `\r` Carriage return character
- `\s` Any whitespace (space, empty line, tab, vertical tab, carriage return, form-feed)
- `\S` Any non-whitespace
- `\t` Tab
- `\v` Vertical tab
