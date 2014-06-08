require 'light-service'

class VerifiesAvailabilityOfPreviewPage
  include LightService::Action
  expects :preview_page

  executed do |context|
    context.fail! if context.preview_page.document.css('#productheader').empty?
  end
end
