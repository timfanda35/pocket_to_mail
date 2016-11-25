require_relative 'ext/ext.rb'
require_relative 'pocket_to_mail/pocket_client.rb'

module PocketToMail
  def self.init
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