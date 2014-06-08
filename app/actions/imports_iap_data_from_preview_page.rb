require 'light-service'
require 'nokogiri'
require './app/importer/iap_data'

class ImportsIAPDataFromPreviewPage
  include LightService::Action
  expects :preview_page
  promises :iap_data

  executed do |context|
    context.iap_data = Importer::IAPData.import_preview_page_iap(context.preview_page)
  end
end
