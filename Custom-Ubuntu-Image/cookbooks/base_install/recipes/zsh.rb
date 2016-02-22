#!/usr/bin/env ruby
# Name: zsh.rb
# Purpose: Used to Install ZSH and Oh-My-ZSH

package zsh do
    action: upgrade
end

git 'Oh-My-Zsh' do
    repository 'git://github.com/robbyrussell/oh-my-zsh.git'
    destination "/home/#{user}/.oh-my-zsh"
    action :sync
end

link "/home/#{user}/git/dotfiles/zsh/zshrc.symlink" do
  to "/home/#{user}/.zshrc"
  owner "#{user}"
  group "#{user}"
  action :create
end
