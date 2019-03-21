# `find`

## Options

### Name
#### exact name: `-name`
#### ignore case: `-iname`

### Type
#### files and directoryes: (nothing)
#### files: `-type f`
#### directories: `-type d`

### Permissions
#### 664 permissions: `-perm 0664`
#### 777 permissions: `-perm 0777`

### Size
#### Over 100kb: `-size +100k`
#### Exactly 1MB: `-size 1M`
#### Under 1MB: `-size -1M`

### NOT
#### Not *.php any case: `-not -iname "*.php"`
#### Not *.PNG: `-not -name "*.PNG"`

### Recursive directory depth
#### Only this directory: `-maxdepth 1`
#### Into two lower directories: `-maxdepth 3`


## Examples
```sh
find /dir/path -type f -name "filename.ext"
find /dir/path -type f -iname "filename.ext"
```

# `grep`

## Format
`grep findthis file file2 file3`

## Options
### ignore case: `-i`
### show line number: `-n`
### only output the name of a file: `-l`
### recursive: `-r`
### Recursive and symlinks: `-R`
### sHow filename (default, but if it is hidden): `-H`
### Fixed string (ignore special characters): `-F 'YOUR FIXED STRING WITH ^&%*!@'`

## Examples
```sh
# Find 'foo' recursively
grep foo * -R

# Find complex string with spaces, etc
grep 'complex string' * -R

## OR
grep "complex string" * -R

# Test with grep if "foo" is in a file
if grep -Fq "foo" /path/to/file; then
echo "foo is true"
fi

# Test with grep if "foo" is NOT in a file
if ! grep -Fq "foo" /path/to/file; then
echo "foo is true"
fi
```

# `sed`

## Examples
```sh
# Find 'foo' and replace with 'bar'
sed -i "s/foo/bar/g" /path/to/file

# Find 'foo' anywhere on a line and delete the line
sed -i "/foo/d" /path/to/file

# Find 'foo' at the beginning of a line and delete the line
sed -i "s/foo.*//g" /path/to/file

# Find 'foo' at the beginning of a line and add 'bar' at the end of the line
sed -i "/^foo/ s/$/bar/" /path/to/file

# Find 'foo' and replace with '[tab] bar' ( \t = tab )
sed -i "s/foo/\tbar/g" /path/to/file

# Find 'foo' and replace with 'bar' on two lines (\n = new line)
sed -i "s/foo/bar1\nbar2/g" /path/to/file

# Find everything on the same line between 'foo1' and 'foo2' and replace with 'bar' on two lines
sed -i "s/foo1.*.foo2/bar/g" /path/to/file

# Cancel dots and slashes with \ finding '/path/foo.md' replacing with '/dir/bar.md'
sed -i "s/\/path\/foo\.md/\/dir\/bar\.md/g" /path/to/file
```

# `rename`

## Examples
```sh
# Simple
rename 's/foo.old.name/barnewname/' /path/to/files/*

# Use quotes with variables
rename "s/foo.old.name/${barnewname}/" /path/to/files/*


# sed characters to cancel with \

# unless inside a character set wtih brackets like this: [ ... ]
$ ^ * [ ] / \

# sed characters to never cancel
? + { } ( ) |

# $ in variables are not canceled
$i_am_variable
${also_variable}

# The rest of the time, sed can be crazy, so try and search
```

## Links
### grep https://www.computerhope.com/unix/ugrep.htm
