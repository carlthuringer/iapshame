require './app/importer/importer'
require 'nokogiri'

class Importer::IAPData
  def self.import_preview_page_iap(document)
    document.css('div.in-app-purchases li').map do |iap_node|
      {
        :text => iap_node.css('span.in-app-title').first.inner_text,
        :price => iap_node.css('span.in-app-price').first.inner_text.match(/\d+\.\d+/).to_s.to_f
      }
    end
  end

  def self.import_preview_page_release_date(document)
    document.css('.release-date').first.children.last.text
  end
end
