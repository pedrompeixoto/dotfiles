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
source_nvim=$config_folder/nvim
target_nvim=$HOME/.config/nvim

programs+=(wezterm)
source_wezterm=$config_folder/wezterm
target_wezterm=$HOME/.config/wezterm

programs+=(tmux)
source_tmux=$config_folder/tmux
target_tmux=$HOME/.config/tmux

programs+=(ssh)
source_ssh=$config_folder/ssh/config
target_ssh=$HOME/.ssh/config

for program in ${programs[@]}
do
	source=source_${program}
	target=target_${program}
	ln -sfhF ${!source} ${!target}
	echo "Symlinked " $program " " ${!source} " -> " ${!target}
done
