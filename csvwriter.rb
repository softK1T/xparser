# frozen_string_literal: true

require 'csv'

# csvwriter class: writing each item object to .csv file
class CSVWriter
  def initialize(filename)
    @filename = filename
  end

  def write_items(items)
    timestart = Time.now
    CSV.open(@filename, 'w') do |csv|
      csv << ['Product name', 'Product cost', 'Product image link', 'Product URL', 'Product ID', 'Product available',
              'Product shops']
      items.each do |item|
        csv << [item.name, item.cost, item.image, item.url, item.id, item.available, item.shop]
      end
    end
    puts "Writing time: #{Time.now - timestart}"
  end
end
