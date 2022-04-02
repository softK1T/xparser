# frozen_string_literal: true

require 'yaml'
require_relative 'html'

arr = []
html = HTML.new('https://oz.by/chocolate/more101112220.html').html
gg = html.xpath('//a[contains(@data-switcher-map, "1") and not(@style)]/span/text()')
arr = gg
puts arr.size
puts arr.class
