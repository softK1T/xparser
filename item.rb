# frozen_string_literal: true

require_relative 'html'
require_relative 'config'

$stdout.sync = true

c = Config.new
IMAGE_PATH = c.image_path
COST_PATH = c.cost_path
NAME_PATH = c.name_path
ID_PATH = c.id_path
SHOP_PATH = c.shop_path
AVAILABLE_PATH = c.available_path
# item class: lets you create item-type objects
class Item
  def initialize(url, name, image, cost, available, id, shop)
    @url = url
    @image = image
    @cost = cost
    @name = name
    @available = available
    @id = id
    @shop = shop
  end

  attr_accessor :name, :cost, :image, :url, :id, :shop, :available
end

# itemgetter class: lets get all the items from urls
class ItemGetter
  def initialize(urls)
    @urls = urls
    @items = []
  end

  attr_reader :items

  def proceed_items
    timestart = Time.now
    mutex = Mutex.new
    threads = []
    @urls.each_with_index do |url, i|
      mutex.synchronize do
        threads << Thread.new { ithread(i, url) }
      end
    end
    threads.each(&:join)
    puts "Parsed by: #{Time.now - timestart}"
  end

  private

  def ithread(num, url)
    puts "Parsing item №#{num + 1}/#{@urls.length}: #{url}"
    i_html = HTML.new(url).html
    cost, image, name, shops, id, available = info(i_html)
    @items << Item.new(url, name, image, cost, available, id, shops)
  end

  def info(i_html)
    name = i_html.xpath(NAME_PATH).text.strip
    cost = i_html.xpath(COST_PATH).text.strip
    image = i_html.xpath(IMAGE_PATH)
    shops = i_html.xpath(SHOP_PATH).text
    id = i_html.xpath(ID_PATH).text.strip
    available = i_html.xpath(AVAILABLE_PATH).text.strip
    [cost, image, name, shops, id, available]
  end
end
