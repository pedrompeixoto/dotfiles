dotfiles_folder=$HOME"/projects/dotfiles"
config_folder=$dotfiles_folder"/configs"

programs=()

programs+=(zprofile)
source_zprofile=$dotfiles_folder/macos/zsh/zprofile
target_zprofile=$HOME/.zprofile

programs+=(git)
source_git=$config_folder/git/gitconfig
target_git=$HOME/.gitconfig

programs+=(nvim)
source_nvim=$config_folder/nvimV2
target_nvim=$HOME/.config/nvim

programs+=(wezterm)
source_wezterm=$config_folder/wezterm
target_wezterm=$HOME/.config/wezterm

for program in ${programs[@]}
do
	source=source_${program}
	target=target_${program}
	ln -sfhF ${!source} ${!target}
	echo "Symlinked " $program " " ${!source} " -> " ${!target}
done
