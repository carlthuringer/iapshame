require './lib/importer/importer'
require 'nokogiri'

class Importer::IAPData
  def self.import_preview_page(document)
    document.css('div.in-app-purchases').map do |iap_node|
      {
        :text => iap_node.css('span.in-app-title').inner_text,
        :price => iap_node.css('span.in-app-price').inner_text.match(/\d+\.\d+/).to_s.to_f
      }
    end
  end
end
