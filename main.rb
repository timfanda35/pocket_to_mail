require 'bundler/setup'
Bundler.require
require 'net/smtp'

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
  def run
    info = oldest_item

    content = ""
    info['list'].each do |key, item|
      content << "<a href=\"#{item['given_url']}\">#{item['given_title']}</a><br /><br />"
    end

    send_mail("Older pocket", content)
  end

  def oldest_item
    client = Pocket.client(:access_token => ENV['ACCESS_TOKEN'])
    info = client.retrieve(
      :sort => :oldest,
      :detailType => :simple,
      :count => 5
    )
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
end

ap Main.new.run
