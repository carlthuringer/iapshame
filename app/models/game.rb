require 'active_model'
class Game
  include ActiveModel::Model
  attr_accessor :app_id,
    :name,
    :developer_name,
    :preview_uri,
    :image_uri,
    :release_date,
    :top_iap_title,
    :top_iap_price,
    :top_list_rank,
    :score

  def attributes
    {
      :app_id => app_id,
      :name => name,
      :developer_name => developer_name,
      :preview_uri => preview_uri,
      :image_uri => image_uri,
      :release_date => release_date,
      :top_iap_title => top_iap_title,
      :top_iap_price => top_iap_price
    }
  end
end
