gource --key -1920x1080 --seconds-per-day .05 --auto-skip-seconds .01 --date-format "%F" --font-colour FFFFFF --hide bloom,filenames --hash-seed 128 --file-idle-time 0 -o gource.ppm
ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i gource.ppm -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 gource.mp4
