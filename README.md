# Lelouvincx's dotfiles

My dotfiles configuration with alacritty, zsh, tmux and neovim.

**Warning**: Don't blindly copy my settings and use directly in your system without knowing details. You should clone this repo and give it a try before applying to your system. Use at your own risk!

## Contents

- Alacritty
- Zsh
- Tmux
- Neovim

## Alacritty

No need installing extensions but you need a [config file](./alacritty.yml).

Font I used: JetbrainsMono Nerd Font Mono (supports icons). [More info](https://github.com/ryanoasis/nerd-fonts).

## Zsh

(Update: currently not true, will be updated soon)
Version: 5.9 or higher.

- [ZimFW](https://github.com/ohmyzsh/ohmyzsh): a framework for zsh plugin management and configuration

For more zsh plugins, [visit here](https://github.com/unixorn/awesome-zsh-plugins).

## Tmux

Version: 3.2a or higher.

I customized from [.tmux](https://github.com/gpakosz/.tmux), you can separately clone this repo and use it for your own.

## Neovim

Version: 0.10.0 or higher.

## Requirements

### Alacritty

Read the fully installation [here](https://github.com/alacritty/alacritty/blob/master/INSTALL.md) for more.

### Zsh and oh-my-zsh

Install zsh and oh-my-zsh plugin manager.

```bash
sudo apt-get install zsh -y
sudo curl -L http://install.ohmyz.sh | sh
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```

Set it as the default shell

```bash
sudo chsh -s $(which zsh)
```

### Tmux

Install tmux

```bash
sudo apt-get install tmux
```

### Neovim

Download the releases and install the latest version of neovim [here](https://github.com/neovim/neovim/releases/tag/v0.7.0).

#### Ruby

```bash
sudo apt-get install ruby-full
```

#### Nodejs

```bash
sudo apt-get install nodejs
sudo apt-get install npm
```

#### Neovim package on python3, nodejs, ruby

```bash
sudo apt-get install python3-pip # If pip's not on your system
pip install neovim
pip install pynvim

sudo npm install -g neovim

gem install neovim
```

#### Neovim package on python2

```bash
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py # To download get-pip.py
sudo python2 get-pip.py
pip2 --version # Check the pip2's version

pip2 install neovim
pip2 install pynvim
```

For more dependencies, you can open neovim and run `:checkhealth` to know which packages need installing.

## Usage

Please make sure you know and understand how your configs work before continuing. Since this is just my personal working configurations, I don't provide any user support. Just look at it as a valuable references for your own configurations. If you run into any issues, you can try:

1. Google and stackoverflow the error message
2. Check your dependencies and environments
3. Report with the plugin author

If you want to experience with this dotfiles it's pretty easy to do. Firstly you should backup all your config files in one place to keep it safe. Then fork this repo and clone to your local system and play with it anyway you want.

- Resource alacritty config by saving the `alacritty.yml` file.
- Resource zsh config by `zsh ~/.zshrc` or relaunch the terminal.
- Resource tmux by `tmux source ~/.tmux.conf`. And you can install extensions by pressing `Ctrl + b + I` (in this case prefix key is Ctrl + b).
- Resource neovim config by saving then `:so%`. Or you can relaunch it.

Many thanks for reading until here and enjoy your own dotfiles!

## Thanks to...

I want to give the special thanks to Ly Thanh Nhan, who first inspired me to use neovim as main IDE (you can visit his blog [here](https://nextlint.com/@lythanhnhan27294)). After a pretty long time working on this project I think myself has a good knowledge and experience to share you guys. Besides, [balldk](https://github.com/balldk), [craftzdog](https://github.com/craftzdog/dotfiles-public) and [drievints](https://github.com/driesvints/dotfiles) taught me a lot for completing and improving my configs.

In general, I want to give thanks to everyone who shares their dotfiles for their efforts to contribute their knowledge, mind and experience to the open-source community.

## About me

- Visit my blog: [lelovincx](https://lelouvincx.hashnode.com)
- Email me: dinhminhchinh3357@duck.com
