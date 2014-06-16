require './app/client/apple_app_preview_page'
require 'light-service'

class FetchesAppPreviewPage
  include LightService::Action
  expects :game
  promises :preview_page

  executed do |context|
    response = Client::AppleAppPreviewPage.fetch_preview(context.game.preview_uri)

    if response.code == 200 && response_indicates_app_is_available?(response)
      context.preview_page = response.document
    else
      context.fail!
    end
  end

  def self.response_indicates_app_is_available?(response)
    response.headers[:x_apple_request_store_front] != "<null>"
  end
end
