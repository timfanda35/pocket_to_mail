require 'addressable/uri'

module PocketToMail
  module UrlUtil
    def self.remove_utm(url)
      uri = Addressable::URI.parse(url)

      q = uri.query_values
      if q
        q.delete "hmsr"
        q.delete "utm_medium"
        q.delete "utm_source"

        uri.query_values = q
      end

      uri.normalize.to_s
    end
  end
end