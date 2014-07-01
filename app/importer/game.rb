require './app/importer/importer'
require 'nokogiri'

class Importer::Game
  def self.import_feed_document(document, is_top_list)
    document.xpath('//entry').map.with_index do |entry_node, index|
      {
        :app_id => entry_node.xpath('id').first["id"].to_i,
        :name => entry_node.xpath('name').inner_text,
        :developer_name => entry_node.xpath('artist').inner_text,
        :preview_uri => entry_node.xpath('link').first["href"],
        :image_uri => entry_node.xpath('image[@height=100]').first.inner_text,
        :release_date => entry_node.xpath('releaseDate').inner_text,
        :top_list_rank => is_top_list ? index + 1 : nil,
        :genre => entry_node.xpath('category').first['id'].to_i
      }
    end
  end
end
