#!/usr/bin/env ruby

user "#{user}" do
    comment "Managed by Chef"
    home "/home/#{user}"
    shell '/usr/bin/zsh'
    action :create
end

include_recipe 'git'

git 'Chases Dotfiles' do
    repository 'git://github.com/challsted/dotfiles.git'
    destination "/home/#{user}/git/dotfiles"
    action :sync
end

include_recipe 'vim'
# include_recipe 'nvim' # Once the recipe is fixed this canb e uncommented
include_recipe 'zsh'
include_recipe 'tmux'
include_recipe 'ruby'
include_recipe 'python'

