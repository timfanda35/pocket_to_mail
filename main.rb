require_relative 'lib/pocket_to_mail.rb'

class Main
  def run
    client = PocketToMail::PocketClient.new(ENV['API_KEY'], ENV['ACCESS_TOKEN'])

    info = client.older_items

    return "no pocket posts to mail" if info['list'].length == 0

    content = ""
    info['list'].each do |key, item|
      url = PocketToMail::UrlUtil.remove_utm(item['resolved_url'])
      content << "<a href=\"#{url}\">#{item['resolved_title']}</a><br /><br />"
    end

    send_mail("Older pocket", content)

    client.delete_older_items(info)

    "done!"
  end

  def send_mail(subject, content)
    mail_client = PocketToMail::GmailClient.new(
      ENV['MAIL_ADDRESS'],
      ENV['MAIL_PASSWORD']
    )

    mail_client.deliver(
      ENV['MAIL_ADDRESS'],
      ENV['MAIL_ADDRESS'],
      subject,
      content
    )
  end
end
