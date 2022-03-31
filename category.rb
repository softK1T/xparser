# frozen_string_literal: true

require_relative 'html'

CATEGORY_MAIN = '//a[contains(@class, "menu-categories__link ")]/@href'
CATEGORY = '//a[contains(@class, "tile-cats__heading")]/@href'

# category class: creating category-type objects
class Category
  def initialize(url)
    @url = url
  end

  attr_accessor :url
end

# categorygetter: getting array of all categories
class CategoryGetter
  def initialize(url)
    @url = url
    @categories = []
  end

  attr_accessor :categories

  def proceed_categories
    timestart = Time.now
    html = HTML.new(@url).html
    threads = []
    category_main = html.xpath(CATEGORY_MAIN)
    category_main.each_with_index do |url, _l|
      threads << Thread.new { cathread(url) }
    end
    threads.each(&:join)
    timedelta = Time.now - timestart
    puts "#{timedelta} seconds"
  end

  private

  def cathread(url)
    c_url = HTML.new(url).html.xpath(CATEGORY)
    c_url.each_with_index do |cat_url, _k|
      cn = Category.new(cat_url)
      @categories << cn
      puts "Parsing category #{cn.url}..."
    end
  end
end
