require 'active_model'
class Game
  include ActiveModel::Model
  attr_accessor :app_id,
    :name,
    :developer_name,
    :preview_uri,
    :image_uri,
    :release_date,
    :top_iap_text,
    :top_iap_price
end
