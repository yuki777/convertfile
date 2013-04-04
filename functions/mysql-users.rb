#!/usr/bin/ruby
# -*- coding: utf-8 -*-

def select_users
  return false unless db = get_db

  query = 'select * from users'

  begin
    users = db.xquery(query)
  rescue => e
    $LOG.error(__FILE__+' +'+__LINE__.to_s+' select users error');
    $LOG.error(e);
    return false
  ensure
    db.close
  end

  return false if users.count == 0
  return users
end

