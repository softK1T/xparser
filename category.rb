require_relative "html"

CATEGORY_MAIN = '//a[contains(@class, "menu-categories__link ")]/@href'
CATEGORY = '//a[contains(@class, "tile-cats__heading")]/@href'

class Category
  def initialize(url)
    @url = url
  end

  attr_accessor :url
end

class CategoryGetter
  def initialize(url)
    @url = url
    @categories = []
  end

  def GetCategories
    timestart = Time.now
    threads = []
    html = HTML.new(@url).getHTML
    category_main = html.xpath(CATEGORY_MAIN)
    category_main.each_with_index { |url, l|
      threads << Thread.new {
        c_url = HTML.new(url).getHTML.xpath(CATEGORY)
        c_url.each_with_index { |cat_url, k|
          cn = Category.new(cat_url)
          @categories << cn
          puts "Parsing category #{cn.url}..."
        }
      }
    }
    threads.each(&:join)
    timedelta = Time.now - timestart
    puts "#{timedelta} seconds"
  end

  def Categories
    @categories
  end
end
