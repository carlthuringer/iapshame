require 'light-service'

class VerifiesAvailabilityOfPreviewPage
  include LightService::Action
  expects :preview_pages

  executed do |context|
    context.preview_pages.each do |app_id, page|
      unless page.document.css('#productheader').present?
        context.fail!
      end
    end
  end
end
