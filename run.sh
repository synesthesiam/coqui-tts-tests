#!/usr/bin/env bash
set -e

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
output_dir="${this_dir}/wavs"
url='http://localhost:5002/api/tts'

mkdir -p "${output_dir}"

while IFS='|' read -r id text;
do
    curl -X GET -G "${url}" \
         --data-urlencode "text=${text}" \
         --output "${output_dir}/${id}.wav"
done < "${this_dir}/test_sentences.csv"

