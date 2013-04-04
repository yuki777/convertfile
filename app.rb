#!/usr/bin/ruby
# -*- coding: utf-8 -*-

PWD = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.push(PWD)

# libs
require "rubygems"
require "bundler/setup"
require 'logger'
require 'dropbox_sdk'
require 'mysql2'
require 'mysql2-cs-bind'
require 'base64'

$LOG = Logger.new(PWD + "/logs/app.log")

# my libs
require 'define'
require 'functions/mysql'
require 'functions/mysql-users'
require 'functions/mysql-histories'
require 'functions/urlecho'
require 'functions/dot-txt'

select_users.each do |user|
  session = Marshal.load(Base64.decode64(user["session"]))
  session = DropboxSession.deserialize(session)
  client  = DropboxClient.new(session, ACCESS_TYPE)

  next unless client
  next unless delta = client.delta
  next unless entries = delta["entries"]

  entries.each do |entry|
    filename = entry[0]
    ext      = File.extname(filename)
    revision = entry[1]["revision"]
    history  = select_history(user["uid"], filename, revision)

    next unless history
    next if history.count > 0

    dot_txt(filename, revision, client, user) if ext == ".txt"
  end
end

