require 'net/smtp'
require "cgi"
require "uri"
require_relative 'lib/pocket_to_mail.rb'

class Main
  def initialize
    PocketToMail.init
    @client = PocketToMail::PocketClient.new(ENV['API_KEY'], ENV['ACCESS_TOKEN'])
  end

  def run
    info = @client.older_items

    return "no pocket posts to mail" if info['list'].length == 0

    content = ""
    info['list'].each do |key, item|
      url = remove_utm(item['resolved_url'])
      content << "<a href=\"#{url}\">#{item['resolved_title']}</a><br /><br />"
    end

    send_mail("Older pocket", content)

    @client.delete_older_items(info)
  end

  def send_mail(subject, content)
    Mail.deliver do
           to ENV['MAIL_ADDRESS']
         from ENV['MAIL_ADDRESS']
      subject subject

      text_part do
        body content
      end

      html_part do
        content_type 'text/html; charset=UTF-8'
        body content
      end
    end
  end

  def remove_utm(url)
    uri = URI(URI.escape(url))
    query_string = if uri.query
      q = CGI.parse(uri.query)
      q.delete "hmsr"
      q.delete "utm_medium"
      q.delete "utm_source"
      query_string = "?" + q.to_query.gsub("%5B%5D", "")
    else
       ""
    end

    uri.scheme + "://" + uri.host + uri.path + query_string
  end
end
