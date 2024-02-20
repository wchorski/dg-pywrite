---
{"dg-publish":true,"permalink":"/developer/shell-prompt-starship-rs-and-zsh/","noteIcon":""}
---


> [!info] [Starship: Cross-Shell Prompt](https://starship.rs/)
> The minimal, blazing-fast, and infinitely customizable prompt for any shell!

### install on Linux Mint
[[[Make Windows Terminal look amazing! - YouTube](https://www.youtube.com/watch?v=AK2JE2YsKto\|video tutorial]])  
[other video tutorial](https://www.youtube.com/watch?v=VgTu1_92U0U&t=176s)

0. grab `zsh` if you want all the pretty icons
```shell
sudo apt-get update
sudo apt-get install zsh
zsh
# press (2)

# make zsh default shell
chsh -s $(which zsh)
chsh -s /bin/bash
```
2. installer script
```shell
curl -sS https://starship.rs/install.sh | sh
```
2. Add the following to the end of `~/.zsh`
```shell
eval "$(starship init zsh)"
```
3. add config file 
```shell
mkdir -p ~/.config && touch ~/.config/starship.toml
```

## Configuration
`./config/starship.toml`
```toml
# ~/.config/starship.toml

# Inserts a blank line between shell prompts
add_newline = true

format = """
(238)$env_var\
$username\
$hostname\
$directory\
$fill\
$git_branch\
$git_state\
$git_status\
$git_metrics\
$nodejs\
$cmd_duration $jobs $time\
$line_break\
$character"""

[nodejs]
format = "[[$version )]($style|$symbol($version )]]"

[fill]
symbol = "."


# Change the default prompt characters
[character]
success_symbol = "[[238|]]"
error_symbol = "[[238|]]"

# Shows an icon that should be included by zshrc script based on the distribution or os
[env_var.STARSHIP_DISTRO]
format = '[[bold white|$env_value]]'  # removed space between distro and rest for pwsh
variable = "STARSHIP_DISTRO"
disabled = false

# Shows the username
[username]
style_user = "white bold"
style_root = "black bold"
format = "[[$style|$user]] "
disabled = true  # disable in powershell
show_always = false

[directory]
truncation_length = 3
truncation_symbol = "…/"
home_symbol = " ~"
read_only_style = "197"
read_only = "  "
format = "at [[$style|$path]][[$read_only_style|$read_only]] "

[git_branch]
symbol = " "
format = "on [[$style|$symbol$branch]] "
truncation_length = 4
truncation_symbol = "…/"
style = "bold green"

[git_status]
format = '[[$all_status$ahead_behind\)]($style|\($all_status$ahead_behind\)]] '
style = "bold green"
conflicted = "🏳"
up_to_date = " "
untracked = " "
ahead = "⇡${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
behind = "⇣${count}"
stashed = " "
modified = " "
staged = '[[$count\)](green|++\($count\)]]'
renamed = "襁 "
deleted = " "

[terraform]
format = "via [[$style| terraform $version]] 壟 [[$style|$workspace]] "

[vagrant]
format = "via [[$style| vagrant $version]] "

[docker_context]
format = "via [[bold blue| $context]] "

[helm]
format = "via [[bold purple| $version]] "

[python]
symbol = " "
python_binary = "python3"


[ruby]
format = "via [[$style| $version]] "

[kubernetes]
format = 'on [[$namespace\)](bold purple| $context\($namespace\)]] '
disabled = false
[kubernetes.context_aliases]
"clcreative-k8s-staging" = "cl-k8s-staging"
"clcreative-k8s-production" = "cl-k8s-prod"
```

#### copy fonts via terminal
find fonts at [Nerd Fonts - Iconic font aggregator, glyphs/icons collection, & fonts patcher](https://www.nerdfonts.com/font-downloads)
```shell
sudo cd /usr/share/fonts
sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/BigBlueTerminal.zip
sudo unzip -d BigBlueTerminal BigBlueTerminal.zip 
sudo rm BigBlueTerminal.zip 

# refresh 
sudo fc-cache -f -v
```