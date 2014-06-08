require './app/client/apple_app_preview_page'
require 'light-service'

class FetchesAppPreviewPage
  include LightService::Action
  expects :game
  promises :preview_page

  executed do |context|
    context.preview_page = Client::AppleAppPreviewPage.fetch_preview(context.game.preview_uri).document
  end
end
