# Compression

## Common flags
- view: `-t`
- compress: `-c`
- decompress: `-d`
- extract: `-x`
- verboze: `-v`
- sent to tape drive: `-z`
- file: `-f` (must be last)

## Different utilities
- **`tar -c -x`**: `tar -cvf File.tar DIR1 DIR2 File1 File2, tar -xvf File.tar` (no compression tarball)
- **`gzip -c -d`**: `gzip -cvf File.tar > File.tar.gz , gzip -dvf File.tar.gz` (small)
- **`bzip2 -c -d`**: `bzip2 -cvf File > File.tar, bzip2 -dvf File.tar.bz2` (smaller)
- **`xz -c -d`**: `xz -c File.tar > File.tar.xz, xz -d File.tar.xz` (smallest)

## `.tar.xz` in a single command:
- `tar -cf - DIR | xz > File.tar.xz`

## Decompress tar.? files in one command:
- `tar xf File.tar`
- `tar xf File.tar.gz`
- `tar xf File.tar.bz2`
- `tar xf File.tar.xz`

## No tar
- `zip`: `zip -r File.zip DIR, unzip File.zip`

Combo instructions:
https://github.com/jrcharney/rigel/wiki/Download-using-curl-and-tar
