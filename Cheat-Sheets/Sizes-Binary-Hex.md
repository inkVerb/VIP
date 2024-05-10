# File Size, Binary, Hexadecimal

## Video: [RGB-bin-hex](https://www.youtube.com/watch?v=HX46ILgwTNk)

*This video demonstrates binary, decimal, and hexadecimal values while creating colors for RGB and HTML-hex notation*

- Top row: Binary (0–1)
- Mid Row: Decimal (0–9)
- Bottom Row: Hexadecimal (0–F)

___

## Binary & Hexadecimal Bases
- Computers think only `on` and `off`, `true` or `false`, `1` or `0`
- `1` and `0` are used in Binary numbering, which computers use
- Each `1` or `0` is a `bit`
- `Bits` come in two pairs of `4`, making `8 bits`, AKA `1 Byte`, AKA `1` "oclet"

### Binary Groups of `4` (`1`-`15`; `A`-`F`)

| Binary | Hexadecimal | Decimal |
| :----- | :---------- | :------ |
| 0000   | 0           | 0       |
| 0001   | 1           | 1       |
| 0010   | 2           | 2       |
| 0011   | 3           | 3       |
| 0100   | 4           | 4       |
| 0101   | 5           | 5       |
| 0110   | 6           | 6       |
| 0111   | 7           | 7       |
| 1000   | 8           | 8       |
| 1001   | 9           | 9       |
| 1010   | A           | 10      |
| 1011   | B           | 11      |
| 1100   | C           | 12      |
| 1101   | D           | 13      |
| 1110   | E           | 14      |
| 1111   | F           | 15      |

- *Notice with Binary and Hexadecimal, the group of `4` binaries create the same letter*
  - *This is one reason why Hexadecimal is convenient*

### Examples of Oclets

| Binary    | Hexadecimal | Decimal |
| :-------- | :---------- | :------ |
| 0001 0001 | 11          | 17      |
| 0010 0010 | 22          | 34      |
| 0011 1001 | 39          | 57      |
| 0100 0010 | 42          | 66      |
| 0101 0111 | 57          | 87      |
| 0110 0001 | 61          | 97      |
| 0111 0000 | 70          | 112     |
| 1000 0000 | 80          | 128     |
| 1001 0000 | 90          | 144     |
| 1010 1010 | AA          | 170     |
| 1011 1000 | B8          | 184     |
| 1100 0100 | C4          | 196     |
| 1101 0001 | D1          | 209     |
| 1110 0110 | E5          | 229     |
| 1111 0000 | F0          | 240     |
| 1111 1111 | FF          | 255     |


### Oclet Charts
- Binary numbers work in powers of `2` because they only have two possible digits

| Binary    | Exponents of 2 | Hexadecimal | Decimal |
| :-------- | :------------- | :---------- | :------ |
| 0000 0000 | 0<sup>0</sup>  | 00          | 0       |
| 0000 0001 | 2<sup>0</sup>  | 01          | 1       |
| 0000 0010 | 2<sup>1</sup>  | 02          | 2       |
| 0000 0100 | 2<sup>2</sup>  | 08          | 4       |
| 0000 1000 | 2<sup>3</sup>  | 08          | 8       |
| 0001 0000 | 2<sup>4</sup>  | 10          | 16      |
| 0010 0000 | 2<sup>5</sup>  | 20          | 32      |
| 0100 0000 | 2<sup>6</sup>  | 40          | 64      |
| 1000 0000 | 2<sup>7</sup>  | 80          | 128     |

- Decimal values per place:

### `1    1    1    1    1    1    1    1` (Binary)
### `128  64   32   16   8    4    2    1` (Decimal)
### `80   40   20   10   8    4    2    1` (Hexadecimal)

- *Use the `1` place to add numbers to convert between decimal and binary*
- `00100001` = `21` = `33` = `32` + `1`
- `10000010` = `82` = `130` = `128` + `2`
- `10100000` = `A0` = `160` = `128` + `32`
- `10101000` = `A8` = `168` = `128` + `32` + `8`
- `10110000` = `B0` = `176` = `128` + `32` + `16`
- `11000000` = `C0` = `192` = `128` + `64`
- `11010000` = `D0` = `208` = `128` + `64` + `16`
- `11100000` = `E0` = `224` = `128` + `64` + `32`
- `11110000` = `F0` = `240` = `128` + `64` + `32` + `16`
- `11111111` = `FF` = `255` = `128` + `64` + `32` + `16` + `8` + `4` + `2` + `1`
- *Or use `0` to subtract from `255*
- `11111110` = `FE` = `254` = `255` - `1`
- `11110001` = `F1` = `241` = `255` - `8` - `4` - `2`
- `11101111` = `EF` = `239` = `255` - `16`
- `01110111` = `77` = `119` = `255` - `128` - `8`
- `00000000` = `00` = `0` = `128` - `64` - `32` - `16` - `8` - `4` - `2` - `1`

### Converting Binary in Your Head
*To get fast at converting bin-hex in your head:*

- Remembering key values like:
  - `1 1 1 1` matches `8 4 2 1`
  - `0011` = `3`
  - `0111` = `7`
  - `1010` = `A` = `10`
  - `1100` = `C` = `12`
  - `1111` = `F` = `15`

*To get fast at converting bin-dec in your head:*

- Review:
  - `1 1 1 1 0 0 0 0` matches `128 + 64 + 32 + 16`
  - Adding and subtracting `128`, `64`, `32`, `16`, `8`, and `4`

*Converting between binary and hexadecimal is easier because the places cycle every `4` bits, while decimal cycle places don't even match up*

## File Size Relations
*From [201 Lesson 9](https://github.com/inkVerb/vip/blob/master/201/Lesson-09.md)*

- **`1 bit`** = A single binary digit (`0` or `1`)
- **`1 Byte`** = 8 bits
- **`1 Kilobyte (KB)`** = 1,024 Bytes
- **`1 Megabyte (MB)`** = 1,024 Kilobytes
- **`1 Gigabyte (GB)`** = 1,024 Megabytes
- **`1 Terabyte (TB)`** = 1,024 Gigabytes
- **`1 Petabyte (PB)`** = 1,024 Terabytes
- **`1 Exabyte  (EB)`** = 1,024 Petabytes

### Approximate examples:
- `10MB` = 1 minute of audio (128 bit)
- `1MB` = 1 picture  (1920x1080px `.png`; 2560x1600px, `.jpg`)
  - Learn more about image [pictypes](https://github.com/inkVerb/pictypes/blob/master/README.md)
- `1GB` = 1 hour video (1920x1080)
