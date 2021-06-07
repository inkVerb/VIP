# Permissions

`chmod 754 some-file`

`chmod ug+x some-file`

| Numeric  | Readable    | Explanation                    |
|:--------:|:-----------:| :----------------------------- |
| 0        | ---         | No access                      |
| 1        | --x         | Execute access                 |
| 2        | -w-         | Write access                   |
| 3        | -wx         | Write and execute access       |
| 4        | r--         | Read access                    |
| 5        | r-x         | Read and execute access        |
| 6        | rw-         | Read and write access          |
| 7        | rwx         | Read, write and execute access |

| Label | Stands for |
|:-----:|:---------- | 
| r     | read       |
| w     | write      |
| x     | execute    |

| Flag | Stands for            |
|:----:|:--------------------- | 
| u    | user (owner)          |
| g    | group (owner's group) |
| o    | others (public)       |

| Oper | Stands for |
|:----:|:---------- | 
| +    | add        |
| -    | remove     |
| =    | only       |

Example:

`ls -l` returns:

```console
-rwxrwxrwx vip vip SIZE MOD-DATE FileName
drwxrwxrwx vip vip SIZE MOD-DATE DirectoryName
lrwxrwxrwx vip vip SIZE MOD-DATE SymlinkName
srwxrwxrwx vip vip SIZE MOD-DATE SocketName
```

Legend:

```console
ugo = 777, 000
uuugggooo = rwxrwxrwx, ---------
```


# Examples

```shell
chmod +x filename
# makes the file executable

chmod 700 foo
# 7 for owner, 0 for group, 0 for public; replaces all other settings

chmod u+x foo
# add executable to user

chmod ug+x foo
# add executable to user and group

chmod ug+rx,o-rwx foo
# add read & executable to user and group; remove read, write, & execute from public

chmod u=x foo
# make the file only executable for the user and allow no other permissions
```

# Fixing directories

Generally, directories need `755` permissions

Without some special reason, never do `chmod -R ...`

If you do and obviously mess up the permissions for all subdirectories, this might help fix it:

`find /path/to/dir -type d -exec chmod 755 {} +`
