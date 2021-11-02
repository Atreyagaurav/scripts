#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  printf "Search query: "; 
  query=$( echo | dmenu -p "Search YT Video:" )
else
	query="$1"
fi

if [[ "${query}" ]]; then
	query="${query// /+}"
else
	echo "No query given. Exiting."; exit 1
fi

# YT_API_KEY location
YT_API_KEY="$( cat "${HOME}"/.api_keys/YT_API_KEY )"
urlstring="https://www.googleapis.com/youtube/v3/search?part=snippet&q=${query}&type=video&maxResults=20&key=${YT_API_KEY}"

res=$( curl -s "${urlstring}" \
	| jq -r '.items[] | "\(.snippet.channelTitle) => \(.snippet.title) => youtu.be/\(.id.videoId)"' \
	| dmenu -i -p 'Select Video -' -l 20 \
	| awk '{print $NF}' \
   )
if [[ -n "$res" ]]; then
    mpv  --geometry=300-0-0 --on-all-workspaces "https://$res" --fs
fi

