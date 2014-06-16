require 'spec_helper'
require 'rejects_non_approved_category_ids'

describe "RejectsNonApprovedCategoryIds" do
  it "Rejects games from the context if they do not have an approved category ID" do
    game = Game.new(:genre => 6014)
    app_in_other_category = Game.new(:genre => 1234)

    context = LightService::Context.make({
      :games => [app_in_other_category,
                 game]
    })

    result_context = RejectsNonApprovedCategoryIds.execute context
    expect(result_context[:games]).to have(1).item
  end

  it "Fails the context if there are no games left" do
    app_in_other_category = Game.new(:genre => 1234)

    context = LightService::Context.make({
      :game => app_in_other_category
    })

    result_context = RejectsNonApprovedCategoryIds.execute context
    expect(result_context).to_not be_success
  end
end
