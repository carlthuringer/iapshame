require './app/actions/imports_iap_data_from_preview_page'

describe "ImportsIAPDataFromPreviewPage" do
  it "imports the IAP data from the preview page and stores it in iap_data by game id" do
    context = {
      :preview_pages => {
        111 => double(:page_1),
        222 => double(:page_2)
      }
    }

    iap_data = [{
      :text => "Box of Crap",
      :price => 99.99
    }]

    Importer::IAPData.stub(:import_preview_page => iap_data)
    result_context = ImportsIAPDataFromPreviewPage.execute(context)
    expect(result_context[:iap_data][111][0][:text]).to eq("Box of Crap")
    expect(result_context[:iap_data][111][0][:price]).to eq(99.99)
  end
end
