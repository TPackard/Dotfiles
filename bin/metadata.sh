#!/usr/bin/zsh

# Get and set metadata values
# Params: FILE KEY [VALUE]

mkdir -p ~/.metadata
if [[ -z "$3" ]]; then
	# Get the value
	echo "$(cat ~/.metadata/$1 | grep $2 | cut -d= -f2)"
else
	# Set the value
	sed -ie "s/$2=.*/$2=$3/g" ~/.metadata/$1
fi
