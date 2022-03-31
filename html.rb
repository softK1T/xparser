require "nokogiri"
require "curb"

class HTML
  def initialize(url)
    @url = url
    # proxy = "203.34.28.3:80"
    http = Curl::Easy.new(url) # do |curl|
    # curl.proxy_url = proxy
    # end
    http.perform
    html = Nokogiri.parse(http.body_str)
    @html = html
  end

  def getHTML
    @html
  end
end
