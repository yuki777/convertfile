#!/usr/bin/ruby
# -*- coding: utf-8 -*-

def get_db(h = MYSQL_HOST, u = MYSQL_USER, p = MYSQL_PASS, n = MYSQL_NAME)
  begin
    db = Mysql2::Client.new(
      :host     => h,
      :username => u,
      :password => p,
      :database => n,
    )
  rescue => e
    $LOG.error(__FILE__+' +'+__LINE__.to_s+' get_db error');
    $LOG.error(e);
    return false
  end
  db
end

