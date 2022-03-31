require "csv"

class CSVWriter
  def initialize(filename)
    @filename = filename
    CSV.open(@filename, "w") do |csv|
      csv << ["Product name", "Product cost", "Product review count", "Product image link", "Product URL"]
    end

    def WriteItems(items)
      CSV.open(@filename, "w") do |csv|
        items.each { |item|
          csv << [item.name, item.cost, item.reviewcount, item.image, item.url]
        }
      end
    end
  end
end
