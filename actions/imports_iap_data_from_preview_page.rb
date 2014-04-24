require 'light-service'
require 'nokogiri'
require './lib/importer/iap_data'

class ImportsIAPDataFromPreviewPage
  include LightService::Action

  executed do |context|
    preview_pages = context.fetch(:preview_pages)
    context[:iap_data] = Hash[
      preview_pages.map do |id, page|
        [id, Importer::IAPData.import_preview_page(page)]
      end
    ]
  end
end
