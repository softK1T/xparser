require_relative "html"

PATH_ITEM = '//a[contains(@class, "goods-tile__heading")]/@href'
PAGE_NUM = '(//a[contains(@class, "pagination__link")])[last()]'

class CategoryPage
  def initialize(url)
    @url = url
    @items_links = []
    c_html = HTML.new(url).getHTML
    @pages_number = c_html.xpath(PAGE_NUM).text.to_i / 10
    puts "Pages count: #{@pages_number}"
  end

  def GetLinks
    timestart = Time.now
    threads = []
    @pages_number.times do |p_numb|
      threads << Thread.new {
        p_url = p_numb == 0 ? @url : @url.to_s + "page=#{p_numb + 1}/"
        item_html = HTML.new(p_url).getHTML
        item_links = item_html.xpath(PATH_ITEM)
        item_links.each do |link|
          @items_links << link.value
        end
        puts "Written page #{p_numb + 1} - #{p_url}
Time #{Time.now.strftime("%d/%m/%Y %H:%M:%S")}
Total links amount: #{@items_links.length}"
      }
    end
    threads.each(&:join)
    timedelta = Time.now - timestart
    puts "#{timedelta} seconds"
  end

  def ItemsLinks
    @items_links
  end
end
