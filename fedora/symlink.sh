dotfiles_folder=$HOME"/projects/dotfiles"

programs=()

programs+=(git)
source_git=$dotfiles_folder/common/git/gitconfig
target_git=$HOME/.gitconfig

programs+=(i3)
source_i3=$dotfiles_folder/common/i3
target_i3=$HOME/.config/i3

programs+=(nvim)
source_nvim=$dotfiles_folder/common/nvim
target_nvim=$HOME/.config/nvim

programs+=(wezterm)
source_wezterm=$dotfiles_folder/common/wezterm
target_wezterm=$HOME/.config/wezterm

for program in ${programs[@]}
do
	source=source_${program}
	target=target_${program}
	ln -sfTF ${!source} ${!target}
	echo "Symlinked " $program " " ${!source} " -> " ${!target}
done
