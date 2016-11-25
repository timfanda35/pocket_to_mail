module PocketToMail
  class GmailClient
    def initialize(email, password)
      options = { :address              => "smtp.gmail.com",
                  :port                 => 587,
                  :domain               => 'smtp.gmail.com',
                  :user_name            => email,
                  :password             => password,
                  :authentication       => 'plain',
                  :enable_starttls_auto => true  }

      Mail.defaults do
        delivery_method :smtp, options
      end
    end

    def deliver(to, from, subject, content)
      Mail.deliver do
             to to
           from from
        subject subject

        text_part do
          content_type 'text/plain; charset=UTF-8'
          body content
        end

        html_part do
          content_type 'text/html; charset=UTF-8'
          body content
        end
      end
    end
  end
end