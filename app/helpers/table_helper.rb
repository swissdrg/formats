# Use XML builder to convert an array of hashes into an html table
module TableHelper
  def build_table(output_hashes)
    require 'builder'
    xm = Builder::XmlMarkup.new(indent: 2)
    xm.table do
      xm.tr { output_hashes[0].keys.each { |key| xm.th(key) } }
      output_hashes.each { |row| xm.tr { row.values.each { |value| xm.td(value) } } }
    end
  end
end