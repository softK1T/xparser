require_relative "html"

url = "https://rozetka.com.ua/ua/hp-4a7m9ea/p332149516/"
NAME_PATH = '//h1[contains(@class,"product__title")]'
IMAGE_PATH = '(//img[contains(@class,"picture-container__picture")]/@src)[1]'
COST_PATH = '//p[contains(@class,"product-prices__big")]'
REVIEW_PATH = '//div[contains(@class,"product-comments")]/h3/span'
html = HTML.new(url).getHTML

puts html.xpath(NAME_PATH).text.strip
puts html.xpath(IMAGE_PATH)
puts html.xpath(REVIEW_PATH).text.strip
puts html.xpath(COST_PATH).text.strip
