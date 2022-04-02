# frozen_string_literal: true

require_relative 'category'
require_relative 'item'
require_relative 'categorypage'
require_relative 'csvwriter'

def categories_links(url)
  categorygetter = CategoryGetter.new(url) # Getting array
  categorygetter.proceed_categories # of all
  categorygetter.categories # categories links
end

def category_items_links(category_url)
  categorypage = CategoryPage.new(category_url) # Getting
  categorypage.proceed_links # items
  categorypage.items_links # links
end

def items(items_urls)
  itgetter = ItemGetter.new(items_urls) # Getting
  itgetter.proceed_items # Items
  itgetter.items
end
timestart = Time.now
puts timestart
mutex = Mutex.new
url = ARGV[0]
filename = ARGV[1]
# catlinks = categories_links(url)
catitemslinks = []
threads = []
catlinks = []
catlinks[0] = url
# catlinks.each do |catlink|
#   mutex.synchronize do
#     threads << Thread.new do
#       catitemslinks += category_items_links(catlink)
#       puts "Total amount: #{catitemslinks.length}"
#     end
#   end
# end
catitemslinks += category_items_links(catlinks[0])
puts "Total amount: #{catitemslinks.length}"
# threads.each(&:join)

items = items(catitemslinks)

puts '=' * 80
puts "Total amount: #{catitemslinks.length}"

CSVWriter.new(filename).write_items(items)

puts "Time: #{Time.now - timestart} seconds"
