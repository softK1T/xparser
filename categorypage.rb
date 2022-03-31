# frozen_string_literal: true

require_relative 'html'

PATH_ITEM = '//a[contains(@class, "goods-tile__heading")]/@href'
PAGE_NUM = '(//a[contains(@class, "pagination__link")])[last()]'
# categorypage class: lets you create categorypage-type objects
class CategoryPage
  def initialize(url)
    @url = url
    @items_links = []
    c_html = HTML.new(url).html
    @pages_number = c_html.xpath(PAGE_NUM).text.to_i / 50
    puts "Pages count: #{@pages_number}"
  end

  def proceed_links
    timestart = Time.now
    threads = []
    @pages_number.times do |p_numb|
      threads << Thread.new do
        proceed_items_links(p_numb)
      end
    end
    threads.each(&:join)
    timedelta = Time.now - timestart
    puts "#{timedelta} seconds"
  end

  attr_reader :items_links

  private

  def proceed_items_links(p_numb)
    p_url = p_numb.zero? ? @url : @url.to_s + "page=#{p_numb + 1}/"
    item_html = HTML.new(p_url).html
    item_links = item_html.xpath(PATH_ITEM)
    item_links.each do |link|
      @items_links << link.value
    end
    puts "Written page #{p_numb + 1} - #{p_url}
Time #{Time.now.strftime('%d/%m/%Y %H:%M:%S')}
Total links amount: #{@items_links.length}"
  end
end
