#!/usr/bin/env ruby
# Name: git.rb
# Purpose: Used to Install Git

package git do
    action :upgrade
end

directory "/home/#{user}/git" do
  mode '0755'
  owner "#{user}"
  group "#{user}"
  action :create
end
