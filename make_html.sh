#!/usr/bin/env bash
set -e

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

temp_file="$(mktemp)"
function cleanup {
    rm -f "${temp_file}"
}
trap cleanup EXIT

while IFS='|' read -r id text;
do
    echo "<p>${text}</p>" >> "${temp_file}"
    echo "<audio preload=\"none\" controls src=\"wavs/${id}.wav\"></audio>" >> "${temp_file}"
    echo "<br><br>" >> "${temp_file}"
done < "${this_dir}/test_sentences.csv"

sed -e "/@BODY@/{
    s/@BODY@//
    r ${temp_file}
}" < "${this_dir}/index.html.in" > "${this_dir}/index.html"
