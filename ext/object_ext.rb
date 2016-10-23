require "cgi"

class Object
  def to_query(key)
    "#{CGI.escape(key.to_param)}=#{CGI.escape(to_param.to_s)}"
  end

  def to_param
    to_s
  end
end