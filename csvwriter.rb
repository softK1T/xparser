# frozen_string_literal: true

require 'csv'
# csvwriter class: writing each item object to .csv file
class CSVWriter
  def initialize(filename)
    @filename = filename
    CSV.open(@filename, 'w') do |csv|
      csv << ['Product name', 'Product cost', 'Product review count', 'Product image link', 'Product URL']
    end
  end

  def write_items(items)
    CSV.open(@filename, 'w') do |csv|
      items.each do |item|
        csv << [item.name, item.cost, item.reviewcount, item.image, item.url]
      end
    end
  end
end
