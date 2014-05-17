require './app/actions/enqueues_iap_fetcher'

describe "EnqueuesIAPFetcher" do
  it "Enqueues the IAP fetcher job in Resque for all games in the context" do
    game_double = double(:game, :app_id => 111)
    context = {
      :games => [game_double]
    }
    expect(Resque).to receive(:enqueue).once.with(FetchInAppPurchasesJob, 111)
    EnqueuesIAPFetcher.execute(context)
  end
end
