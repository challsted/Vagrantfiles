#!/usr/bin/env ruby

name 'base_install'
version '0.1.0'
description 'A single cookbook to configure all of my dotfiles and configuration needed to setup a customized VM'

attribute 'user',
    :display_name => 'User Name',
    :descripton => 'A user name for the person who wants to own this stuff',
    :type => 'string',
    :required => 'required',
    :default => 'vagrant'
chef_version ">= 12"

issues_url 'https://github.com/challsted/Vagrantfiles/issues'
source_url 'https://github.com/challsted/Vagrantfiles/'
license 'GPL v3'

maintainer 'Chase Hallsted'
maintainer_email 'chase.hallsted@gmail.com'

supports 'ubuntu', '= 14.04'
