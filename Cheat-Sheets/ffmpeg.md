# `ffmpeg` tools

`ffmpeg` works to process video files very efficiently

## Cut to specific time (can't start at 00:00:00 or won't have video)
```console
ffmpeg -ss 00:00:01 -t 01:02:00 -i source.mp4 -c copy output.mp4
```

## Subtitle Burning
### Dual language burned subs
```console
ffmpeg -i "1 Rocky.mp4" -i "1 Rocky 1976 EN.srt" -i "1 Rocky 1976 ZH.srt" \
  -c:v copy -c:a copy -c:s mov_text \
  -map 0:v -map 0:a -map 1 -map 2 \
  -metadata:s:s:0 language=eng -metadata:s:s:1 language=zho \
  "1 Rocky (subs).mp4"
```

### Single language burned subs
```console
ffmpeg -i "4 Rocky IV.mp4" -filter:v subtitles="4 Rocky IV EN.srt" "4 Rocky IV (subs).mp4"
```

