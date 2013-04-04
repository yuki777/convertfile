#!/usr/bin/ruby
# -*- coding: utf-8 -*-

def select_history(uid, filename, revision)
  return false unless db = get_db
  return false unless uid
  return false unless filename
  return false unless revision

  query = 'select * from histories where uid = ? and filename = ? and revision =?'

  begin
    history = db.xquery(query, uid, filename, revision)
  rescue => e
    $LOG.error(__FILE__+' +'+__LINE__.to_s+' select histories error');
    $LOG.error(e);
    return false
  ensure
    db.close
  end

  return history
end

def insert_history(uid, filename, revision)
  return false unless db = get_db
  return false unless uid
  return false unless filename
  return false unless revision

  query = 'insert into histories (uid, filename, revision, created_at)values(?, ?, ?, ?)'

  begin
    history = db.xquery(query, uid, filename, revision, Time.now.to_s)
  rescue => e
    $LOG.error(__FILE__+' +'+__LINE__.to_s+' insert histories error');
    $LOG.error(e);
    return false
  ensure
    db.close
  end

  return history
end

