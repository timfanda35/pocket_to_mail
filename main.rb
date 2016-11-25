require 'bundler/setup'
Bundler.require
require 'net/smtp'
require "cgi"
require "uri"
require_relative 'lib/pocket_to_mail.rb'

Dotenv.load

Pocket.configure do |config|
  config.consumer_key = ENV['API_KEY']
end

options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'smtp.gmail.com',
            :user_name            => ENV['MAIL_ADDRESS'],
            :password             => ENV['MAIL_PASSWORD'],
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

Mail.defaults do
  delivery_method :smtp, options
end

class Main
  def initialize
    @client = Pocket.client(:access_token => ENV['ACCESS_TOKEN'])
  end

  def run
    info = older_items

    return if info['list'].length == 0

    content = ""
    info['list'].each do |key, item|
      url = remove_utm(item['resolved_url'])
      content << "<a href=\"#{url}\">#{item['resolved_title']}</a><br /><br />"
    end

    send_mail("Older pocket", content)

    delete_older_items(info)
  end

  def older_items
    info = @client.retrieve(
      :sort => :oldest,
      :detailType => :simple,
      :count => 5
    )
  end

  def delete_older_items(info)
    actions = []
    info['list'].each do |key, item|
      actions << {
        action: 'delete',
        item_id: item['item_id'].to_i
      }
    end

    ap actions

    @client.modify(actions)
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

ap Main.new.older_items
