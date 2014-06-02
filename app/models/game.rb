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
    :top_list_rank

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

  def release_date=(a_time_value)
    return unless a_time_value.present?
    if a_time_value.kind_of? Time
      @release_date = a_time_value
    else
      @release_date = Time.parse(a_time_value)
    end
  end

  def score
    Math.log([top_iap_price.to_f, 1].max) + release_date.to_i / 10000000
  end
end
