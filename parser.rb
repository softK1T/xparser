require_relative "category"
require_relative "item"
require_relative "categorypage"
require_relative "csvwriter"
def CategoriesLinks(url)
  categorygetter = CategoryGetter.new(url) # Getting array
  categorygetter.GetCategories # of all
  categorygetter.Categories # categories links
end

def CategoryItemsLinks(category_url)
  categorypage = CategoryPage.new(category_url) # Getting
  categorypage.GetLinks # items
  categorypage.ItemsLinks # links
end

def Items(items_urls)
  itgetter = ItemGetter.new(items_urls) # Getting
  itgetter.GetItems # Items
  itgetter.Items
end
timestart = Time.now
mutex = Mutex.new
url = "https://rozetka.com.ua"
catlinks = CategoriesLinks(url)
catitemslinks = []
threads = []
i = 0
catlinks.each { |catlink|
  mutex.synchronize do
    sleep 0.1
    threads << Thread.new {
      catitemslinks += CategoryItemsLinks(catlink.url)
      puts "Total amount: #{catitemslinks.length}"
    }
  end
}
threads.each(&:join)
mutex.lock
items = Items(catitemslinks)

puts "=" * 80
puts "Total amount: #{catitemslinks.length}"

csvn = CSVWriter.new("Items.csv")
csvn.WriteItems(items)

puts "Time: #{Time.now - timestart}"
