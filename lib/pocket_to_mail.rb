require_relative 'ext/ext.rb'

module PocketToMail
  def self.init
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
  end
end