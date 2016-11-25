require "cgi"
require "uri"

module PocketToMail
  module UrlUtil
    def self.remove_utm(url)
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

      query_string.gsub!(/\?$/, "")

      uri.scheme + "://" + uri.host + uri.path + query_string
    end
  end
end