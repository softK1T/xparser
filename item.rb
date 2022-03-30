require_relative "html"

IMAGE_PATH = '(//img[contains(@class,"picture-container__picture")]/@src)[1]'
COST_PATH = '//p[contains(@class,"product-prices__big")]'
REVIEW_PATH = '//div[contains(@class,"product-comments")]/h3/span'
NAME_PATH = '//h1[contains(@class,"product__title")]'

class Item
  def initialize(url, name, image, cost, reviewcount)
    @url = url
    @image = image
    @cost = cost
    @name = name
    @reviewcount = reviewcount
  end

  attr_accessor :name

  attr_accessor :cost

  attr_accessor :image

  attr_accessor :reviewcount

  attr_accessor :url
end

class ItemGetter
  def initialize(urls)
    @urls = urls
    @items = []
  end

  def GetItems
    @urls.each_with_index { |url, i|
      puts "Parsing item №#{i + 1}/#{@urls.length}: #{url}"
      i_html = HTML.new(url).getHTML
      name = i_html.xpath(NAME_PATH)
      cost = i_html.xpath(COST_PATH)
      image = i_html.xpath(IMAGE)
      reviewcount = i_html.xpath(REVIEW_PATH)
      @items << Item.new(url, name, image, cost, reviewcount)
    }
  end

  def Items
    @items
  end
end
