require_relative "category"
require_relative "item"
require_relative "categorypage"

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
  itgetter.GetItems.Items # Items
end

url = "https://rozetka.com.ua"
catlinks = CategoriesLinks(url)
catitemslinks = []
catlinks.each { |url| puts url.url }
puts catlinks.length
catlinks.each { |catlink|
  puts catlink.url
  catitemslinks += CategoryItemsLinks(catlink.url)
  puts catitemslinks.inspect
}

items = Items(catitemslinks)
items.each_with_index { |i, k|
  puts items.name
}
puts "=" * 80
puts "Total amount: #{catitemslinks}"

#
#
# AllItems = []
#
#
#
#
#
# csvn = CSVWriter.new("Items.csv")
# csvn.Write(items)
