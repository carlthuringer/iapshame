require './app/client/apple_app_preview_page'
require 'light-service'

class FetchesAppPreviewPage
  include LightService::Action

  executed do |context|
    context[:preview_pages] = context[:games].reduce({}) do |pages, game|
      pages[game.app_id] = Client::AppleAppPreviewPage.fetch_preview(game.preview_uri).document
      pages
    end
  end
end
