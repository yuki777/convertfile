#!/usr/bin/ruby
# -*- coding: utf-8 -*-

def urlecho(filename, client)
  return false unless filename
  return false unless client

  begin
    # 実行する処理
    body = client.get_file(filename)
  rescue => e
    # 例外が発生したときの処理
    $LOG.debug(__FILE__+' +'+__LINE__.to_s+' urlecho error');
    $LOG.debug(e);
    return false
  else
    # 例外が発生しなかったときに実行される処理
    urlecho = Net::HTTP.post_form(URI.parse("http://urlecho.com/make.php"), {"text" => body.to_s, "dump" => 1})
    urlecho_file = filename + '.urlecho.com.wav'
    client.put_file(urlecho_file, urlecho.body.to_s, true)
  ensure
    # 例外の発生有無に関わらず最後に必ず実行する処理
  end
end

