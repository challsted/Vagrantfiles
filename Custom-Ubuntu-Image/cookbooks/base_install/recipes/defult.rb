#!/usr/bin/env ruby
# TODO: Seperate this into individual packages and call them from here
# Change this value to a user you want to own everything
user = vagrant

case node['platform_family']
when ubuntu debian do
  apt_update "apt-get update" do
      action :update
  end
end

package git do
    action :upgrade
end
package curl do
    action :upgrade
end
package wget do
    action :upgrade
end
package zsh do
    action :upgrade
end
package tmux do
    action :upgrade
end
package python3 do
    action :upgrade
end
package ruby do
    action :upgrade
end

user "#{user}" do
    comment "Managed by Chef"
    home "/home/#{user}"
    shell '/usr/bin/zsh'
    action :create
end

%w{git .config .config/nvim .tmux .tmux/plugins}.each do | dir |
  directory "/home/#{user}/#{dir}" do
    mode '0755'
    owner "#{user}"
    group "#{user}"
    action :create
  end
end

%w{colors autoload plugged undo swap spell backup}.each do | dir |
  directory "/home/#{user}/.congif/nvim/#{dir}" do
    mode '0755'
    owner "#{user}"
    group "#{user}"
    action :create
  end
end

git 'Chases Dotfiles' do
    repository 'git://github.com/challsted/dotfiles.git'
    destination "/home/#{user}/git/dotfiles"
    action :sync
end

git 'Oh-My-Zsh' do
    repository 'git://github.com/robbyrussell/oh-my-zsh.git'
    destination "/home/#{user}/.oh-my-zsh"
    action :sync
end

git 'TMux Plugin Manager' do
    repository 'clone https://github.com/tmux-plugins/tpm'
    destination "/home/#{user}/.tmux/plugins/tpm"
    action :sync
end

execute 'Vim Plug - NVim' do
    command 'curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    creates '~/.config/nvim/autoload/plug.vim'
    action :run
end

execute 'Install NVim Plugins' do
    command '$(which nvim) +PlugInstall +qall'
end

link "/home/#{user}/git/dotfiles/zsh/zshrc.symlink" do
  to "/home/#{user}/.zshrc"
  owner "#{user}"
  group "#{user}"
  action :create
end

link "/home/#{user}/git/dotfiles/nvim/nvimrc.symlink" do
  to "/home/#{user}/.config/nvim/nvim.init"
  owner "#{user}"
  group "#{user}"
  action :create
end

link "/home/#{user}/git/dotfiles/zsh/tmux.conf.symlink" do
  to "/home/#{user}/.tmux.conf"
  owner "#{user}"
  group "#{user}"
  action :create
end
