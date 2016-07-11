#!/usr/bin/zsh
# Links the files into the correct places

# Set options for linking
default_ln_opts="-fnsv"
echo -n "Enter ln flags (default $default_ln_opts): "
read ln_opts
[[ -z $ln_opts ]] && ln_opts=$default_ln_opts
echo $ln_opts

# Make directories if needed
echo -n "Enter directory into which the dotfiles should be symlinked (default $HOME): "
read homd_dir
[[ -z $home_dir ]] && home_dir=$HOME

dot_dir="$(cd "$(dirname "$0")" && pwd)"
mkdir -p $home_dir/bin
mkdir -p $home_dir/.config

# Link dotfiles
link() {
	ln $ln_opts $dot_dir/$1 $2
}

for file in bin/*; do
	link $file $home_dir/$file
done

for dir in config/*; do
	for file in $dir/*; do
		echo $file
		link $file "$home_dir/.$file"
	done
done

for file in dircolors vimrc xinitrc Xresources zlogin zsh_prompt zshrc; do
	link $file $home_dir/.$file
done
