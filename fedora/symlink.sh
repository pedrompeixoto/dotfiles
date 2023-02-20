dotfiles_folder=$HOME"/projects/dotfiles"

programs=()

programs+=(git)
source_git=$dotfiles_folder/common/git/gitconfig
target_git=$HOME/.gitconfig

for program in ${programs[@]}
do
	source=source_${program}
	target=target_${program}
	ln -sfTF ${!source} ${!target}
	echo "Symlinked " $program " " ${!source} " -> " ${!target}
done
