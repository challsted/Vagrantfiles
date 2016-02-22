#!/usr/bin/env ruby
# Name: nvim.rb
# Purpose: Used to Install NVim, Vim-Plug and NeoVim Plugin
# TODO: This Recipe currently wont work on Ubuntu or any Distro that needs it added externally (it should work on arch)

package neovim do
    action :upgrade
end

link "/home/#{user}/git/dotfiles/nvim/nvimrc.symlink" do
  to "/home/#{user}/.config/nvim/nvim.init"
  owner #{user}
  group #{user}
  action :create
end

execute 'Vim Plug - NVim' do
    command 'curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    creates '~/.config/nvim/autoload/plug.vim'
    action :run
end

execute 'Install NVim Plugins' do
    command '$(which nvim) +PlugInstall +qall'
end

directory "home/#{user}/.config" do
  mode '0755'
  owner #{user}
  group #{user}
  action :create
end

directory "home/#{user}/.config/nvim" do
  mode '0755'
  owner #{user}
  group #{user}
  action :create
end

%w{colors autoload plugged undo swap spell backup}.each do | dir |
  directory "/home/#{user}/.config/nvim/#{dir}" do
    mode '0755'
    owner #{user}
    group #{user}
    action :create
  end
end
