require 'light-service'

class ImportsGenreFromPreviewPage
  include LightService::Action
  expects :game, :preview_page

  executed do |context|
    context.game.genre = Importer::IAPData.import_preview_page_genre(context.preview_page)
  end
end
