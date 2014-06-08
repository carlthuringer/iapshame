require 'light-service'

class VerifiesAvailabilityOfPreviewPage
  include LightService::Action
  expects :preview_page

  executed do |context|
    context.fail! unless context.preview_page.document.css('#productheader').present?
  end
end
