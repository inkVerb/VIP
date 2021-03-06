# `if` `then` `else`
```sh

# Perform a test with response
if [ THIS IS THE TEST ]
then
DO THIS IN RESPONSE
fi

# Perform a test with else otherwise response
if [ THIS IS THE TEST ]
then
DO THIS IN RESPONSE
else
DO THIS OTHERWISE
fi

# Perform an OR test with response (either test answers 'true')
if [ THIS IS TEST ONE ] || [ THIS IS TEST TWO ]
then
DO THIS IN RESPONSE
fi

# Perform an AND test with response (BOTH tests must answer 'true')
if [ THIS IS TEST ONE ] && [ THIS IS TEST TWO ]
then
DO THIS IN RESPONSE
fi

# Put if-then on one line
if [ THIS IS THE TEST ]; then
DO THIS IN RESPONSE
fi

# Put everything on one line
if [ THIS IS THE TEST ]; then; DO THIS IN RESPONSE; fi

# Put if-then OR test on one line
if [ THIS IS TEST ONE ] || [ THIS IS TEST TWO ] ; then
DO THIS IN RESPONSE
fi

# Test if a file exists
if [ -f /path/to/file ]; then
echo "It's alive!"
fi

# Test if a directory exists
if [ -d /path/to/directory ]; then
echo "It's alive!"
fi

# Test if a symlink exists
if [ -L /path/to/symlink ]; then
echo "It's a link!"
fi

# Test if anything exists or a symlink is not broken
if [ -e /path/to/mountain ]; then
echo "Because it's there!"
fi

# Test if anything DOES NOT exist or a symlink IS broken
if [ ! -e /path/to/mountain ]; then
echo "Because it's there!"
fi

# Test if a file DOES NOT exist
if [ ! -f /path/to/file ]; then
echo "It's alive!"
fi

# Test if a variable is the same as something (quotes are optional, but safe)
if [ "$variable" = "I am blue" ]; then
echo "It's a blueberry!"
fi

# Test if a variable is NOT the same as something (quotes are optional, but safe)
if [ "$variable" != "I am blue." ]; then
echo "It's not a blueberry!"
fi
```

# More with math:
## http://www.thegeekstuff.com/2010/06/bash-conditional-expression/
## https://www.tutorialspoint.com/unix/unix-basic-operators.htm
