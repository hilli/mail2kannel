class String
  require 'iconv'
  
  def to_utf8(charset_from='ISO-8859-1')
    Iconv.conv('utf-8', charset_from , self)
  end
end
