require 'light-service'

class ImportsReleaseDateFromPreviewPage
  include LightService::Action

  executed do |context|
    preview_page = context.fetch(:preview_pages).values.first
    context[:games].first.release_date = Date.parse(Importer::IAPData.import_preview_page_release_date(preview_page)).to_time
  end
end
