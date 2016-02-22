#!/usr/bin/env ruby
# Name: tmux.rb
# Purpose: Used to Install TMux, TMux Plugin Manager, and Custom Tmux Configs

package tmux do
    action :upgrade
end

%w{.tmux .tmux/plugins}.each do | dir |
  directory "/home/#{user}/#{dir}" do
    mode '0755'
    owner "#{user}"
    group "#{user}"
    action :create
  end
end

git 'TMux Plugin Manager' do
    repository 'clone https://github.com/tmux-plugins/tpm'
    destination "/home/#{user}/.tmux/plugins/tpm"
    action :sync
end

link "/home/#{user}/git/dotfiles/zsh/tmux.conf.symlink" do
  to "/home/#{user}/.tmux.conf"
  owner "#{user}"
  group "#{user}"
  action :create
end
