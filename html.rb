require "nokogiri"
require "curb"

class HTML
  def initialize(url)
    @url = url
    http = Curl::Easy.new(url)
    http.perform
    html = Nokogiri.parse(http.body_str)
    @html = html
  end

  def getHTML
    @html
  end
end
