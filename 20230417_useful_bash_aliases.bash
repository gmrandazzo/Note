

video2gif() {
    ffmpeg -y -i "${1}" -vf fps=${3:-10},scale=${2:-320}:-1:flags=lanczos,palettegen "${1}.png"
    ffmpeg -i "${1}" -i "${1}.png" -filter_complex "fps=${3:-10},scale=${2:-320}:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1}".gif
    rm "${1}.png"
}

video2half_size() {
    ext="${1#*.}"
    ffmpeg -i "${1}" -vf "scale=trunc(iw/4)*2:trunc(ih/4)*2" -crf 28 "${1%%.*}.half_size.${ext}"
}

video2one_third() {
    ext="${1#*.}"
    ffmpeg -i "${1}" -vf "scale=trunc(iw/6)*2:trunc(ih/6)*2" -crf 28 "${1%%.*}.one_third.${ext}"
}


video2one_quarter() {
    ext="${1#*.}"
    ffmpeg -i "${1}" -vf "scale=trunc(iw/8)*2:trunc(ih/8)*2" -crf 28 "${1%%.*}.one_quarter.${ext}"
}


