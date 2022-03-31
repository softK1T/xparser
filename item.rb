# frozen_string_literal: true

require_relative 'html'

IMAGE_PATH = '(//img[contains(@class,"picture-container__picture")]/@src)[1]'
COST_PATH = '//p[contains(@class,"product-prices__big")]'
REVIEW_PATH = '//div[contains(@class,"product-comments")]/h3/span'
NAME_PATH = '//h1[contains(@class,"product__title")]'
# item class: lets you create item-type objects
class Item
  def initialize(url, name, image, cost, reviewcount)
    @url = url
    @image = image
    @cost = cost
    @name = name
    @reviewcount = reviewcount
  end

  attr_accessor :name, :cost, :image, :reviewcount, :url
end

# itemgetter class: lets get all the items from urls
class ItemGetter
  def initialize(urls)
    @urls = urls
    @items = []
  end

  attr_reader :items

  def proceed_items
    mutex = Mutex.new
    threads = []
    @urls.each_with_index do |url, i|
      mutex.synchronize do
        sleep 0.5
        threads << Thread.new { ithread(i, url) }
      end
    end
    threads.each(&:join)
  end

  private

  def ithread(num, url)
    puts "Parsing item №#{num + 1}/#{@urls.length}: #{url}"
    i_html = HTML.new(url).html
    cost, image, name, reviewcount = info(i_html)
    @items << Item.new(url, name, image, cost, reviewcount)
  end

  def info(i_html)
    name = i_html.xpath(NAME_PATH).text.strip
    cost = i_html.xpath(COST_PATH).text.strip
    image = i_html.xpath(IMAGE_PATH)
    reviewcount = i_html.xpath(REVIEW_PATH).text.strip
    [cost, image, name, reviewcount]
  end
end
