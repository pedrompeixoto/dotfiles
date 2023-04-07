dotfiles_folder=$HOME"/projects/dotfiles"
config_folder=$dotfiles_folder"/configs"

programs=()

programs+=(git)
source_git=$config_folder/git/gitconfig
target_git=$HOME/.gitconfig

programs+=(nvim)
source_nvim=$config_folder/nvim
target_nvim=$HOME/.config/nvim

programs+=(wezterm)
source_wezterm=$config_folder/wezterm
target_wezterm=$HOME/.config/wezterm

programs+=(awesomewm)
source_awesomewm=$config_folder/awesome
target_awesomewm=$HOME/.config/awesome

for program in ${programs[@]}
do
	source=source_${program}
	target=target_${program}
	ln -sfTF ${!source} ${!target}
	echo "Symlinked " $program " " ${!source} " -> " ${!target}
done
