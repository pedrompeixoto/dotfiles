dotfiles_folder=$HOME"/dotfiles"
config_folder=$dotfiles_folder"/configs"

destination_folder=$HOME/.config

mkdir $destination_folder

programs=()

programs+=(nvim)
source_nvim=$config_folder/nvim
target_nvim=$destination_folder/nvim

programs+=(wezterm)
source_wezterm=$config_folder/wezterm
target_wezterm=$destination_folder/wezterm

programs+=(tmux)
source_tmux=$config_folder/tmux
target_tmux=$destination_folder/tmux

for program in ${programs[@]}
do
	source=source_${program}
	target=target_${program}
	ln -sfhF ${!source} ${!target}
	echo "Symlinked " $program " " ${!source} " -> " ${!target}
done
