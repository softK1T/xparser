require_relative 'html'

url = 'https://www.jumia.dz/'

html = HTML.new(url).getHTML

puts html