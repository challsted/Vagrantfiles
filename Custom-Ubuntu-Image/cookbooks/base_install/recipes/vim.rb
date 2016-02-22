#!/usr/bin/env ruby
# Name: vim.rb
# Purpose: Used to Install Vim, Vim-Plug and Vim Plugin

package vim do
  action :upgrade
end

directory "/home/#{user}/.vim" do
  mode '0755'
  owner "#{user}"
  group "#{user}"
  action :create
end

%w{colors autoload plugged undo swap spell backup}.each do | dir |
  directory "/home/#{user}/.vim/#{dir}" do
    mode '0755'
    owner "#{user}"
    group "#{user}"
    action :create
  end
end

execute 'Vim Plug - Vim' do
    command 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    creates '~/.vim/autoload/plug.vim'
    action :run
end

execute 'Install Vim Plugins' do
    command '$(which vim) +PlugInstall +qall'
end

link "/home/#{user}/git/dotfiles/vim/vimrc.symlink" do
  to "/home/#{user}/.vimrc"
  owner "#{user}"
  group "#{user}"
  action :create
end

# Fix a bug with Molokai which defaults to a white theme if not in colors dir when called
link "/home/#{user}/.vim/plugged/molokai/colors/molokai.vim" do
  to "/home/#{user}/.vim/colors/molokai.vim"
  owner "#{user}"
  group "#{user}"
  action :create
end
