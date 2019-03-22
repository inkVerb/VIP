# Characters

## Class key

### Custom ranges

Ranges of most alphanumeric characters can be listed intuitively, `!` means "not", `|` mans "or".

**Examples:**
- `[abc]`
- `[!abc]`
- `[a-h]`
- `[2-8]`
- `[A-Z]`
- `[y|Y]`
- `[a|b|c]`

### Classes

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
Graphical characters: `[:alnum:]` and `[:punct:]`.

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

### Meta characters with special meaning:

- `]`

*ends the bracket expression - put first in list to use this character*

- `-`

*"range" - put first or last in list to use this character*

- `^`
*characters "not in the list" - put anywhere but first to use this character*

*Much of this information was taken from the GNU sed manual:* [5.5 Character Classes and Bracket Expressions](https://www.gnu.org/software/sed/manual/html_node/Character-Classes-and-Bracket-Expressions.html)

## Shell command examples that "transform" characters

- from upper to lower case
`tr "[A-Z]" "[a-z]"`

- from lower to upper case
`tr "[a-z]" "[A-Z]"`

- all to lower case
`sed -i 's/\(.*\)/\L\1/' file`
