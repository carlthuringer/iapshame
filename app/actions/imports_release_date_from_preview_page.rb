require 'light-service'

class ImportsReleaseDateFromPreviewPage
  include LightService::Action
  expects :game, :preview_page

  executed do |context|
    context.game.release_date = Date.parse(
                                                         Importer::IAPData.import_preview_page_release_date(context.preview_page)
    ).to_time
  end
end
