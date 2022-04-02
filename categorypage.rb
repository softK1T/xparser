# frozen_string_literal: true

$stdout.sync = true

require_relative 'html'
require_relative 'config'
c = Config.new
PAGE_NUM = c.last_path
ITEM_PATH = c.item_path
PAGE_PATH = c.page_path
# categorypage class: lets you create categorypage-type objects
class CategoryPage
  def initialize(url)
    @url = url
    @items_links = []
    c_html = HTML.new(url).html
    @pages_number = c_html.xpath(PAGE_NUM).text.to_i
    puts "Pages count: #{@pages_number}"
  end

  def proceed_links
    timestart = Time.now
    threads = []
    mutex = Mutex.new
    1.upto(@pages_number) do |p|
      mutex.synchronize do
        threads << Thread.new do
          proceed_items_links(p, PAGE_PATH, ITEM_PATH)
      end
      end
    end
    threads.each(&:join)
    timedelta = Time.now - timestart
    puts "Paging time: #{timedelta} seconds
#{Time.now}"
  end

  attr_reader :items_links

  private

  def proceed_items_links(p_numb, page_path, item_path)
    p_url = p_numb == 1 ? @url : @url.to_s + "#{page_path}#{p_numb}/"
    item_html = HTML.new(p_url).html
    item_links = item_html.xpath(item_path)
    item_links.each do |link|
      @items_links << "#{@url}#{link.value.split('/')[2]}"
    end
    puts "Written page #{p_numb} - #{p_url}
Time #{Time.now.strftime('%d/%m/%Y %H:%M:%S')
    }
Total links amount: #{@items_links.length}"
  end
end
