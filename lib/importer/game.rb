require './lib/importer/importer'
require 'nokogiri'

class Importer::Game
  def self.import_feed_document(document)
    document.xpath('//entry').map do |entry_node|
      {
        :app_id => entry_node.xpath('id').first["id"].to_i,
        :name => entry_node.xpath('name').inner_text,
        :developer_name => entry_node.xpath('artist').inner_text,
        :preview_uri => entry_node.xpath('link').first["href"],
        :image_uri => entry_node.xpath('image[@height=100]').first.inner_text,
        :release_date => entry_node.xpath('releaseDate').inner_text,
      }
    end
  end
end
