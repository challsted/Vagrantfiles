#!/usr/bin/env ruby
# TODO: Seperate this into individual packages and call them from here
# Change this value to a user you want to own everything
user = vagrant

case node['platform_family']
when ubuntu debian mint do
  apt_update "apt-get update" do
      action :update
  end
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

user #{user} do
    comment "Managed by Chef"
    home "/home/#{user}"
    shell '/usr/bin/zsh'
    action :create
end

git 'Chases Dotfiles' do
    repository 'git://github.com/challsted/dotfiles.git'
    destination "/home/#{user}/git/dotfiles"
    action :sync
end
