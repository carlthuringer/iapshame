require './lib/importer/importer'
require 'nokogiri'

class Importer::IAPData
  def self.import_preview_page(document)
    document.css('div.in-app-purchases li').map do |iap_node|
      {
        :text => iap_node.css('span.in-app-title').first.inner_text,
        :price => iap_node.css('span.in-app-price').first.inner_text.match(/\d+\.\d+/).to_s.to_f
      }
    end
  end
end
