#!/usr/bin/ruby
# -*- coding: utf-8 -*-

def dot_txt(filename, revision, client, user)
  return false unless urlecho(filename, client)
  insert_history(user["uid"], filename, revision)
end
