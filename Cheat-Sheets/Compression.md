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
- **`tar -c -x`**: `tar -cvf FILE.tar DIR1 DIR2 FILE1 FILE2, tar -xvf FILE.tar` (no compression tarball)
- **`gzip -c -d`**: `gzip -cvf FILE.tar > FILE.tar.gz , gzip -dvf FILE.tar.gz` (small)
- **`bzip2 -c -d`**: `bzip2 -cvf FILE > FILE.tar, bzip2 -dvf FILE.tar.bz2` (smaller)
- **`xz -c -d`**: `xz -c FILE.tar > FILE.tar.xz, xz -d FILE.tar.xz` (smallest)

## `.tar.xz` in a single command:
- `tar -cf - DIR | xz > FILE.tar.xz`

## Decompress tar.? files in one command:
- `tar xf FILE.tar`
- `tar xf FILE.tar.gz`
- `tar xf FILE.tar.bz2`
- `tar xf FILE.tar.xz`

## No tar
- `zip`: `zip -r FILE.zip DIR, unzip FILE.zip`

Combo instructions:
https://github.com/jrcharney/rigel/wiki/Download-using-curl-and-tar
