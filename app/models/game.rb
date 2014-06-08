require './app/assignable_attributes'

class Game
  include AssignableAttributes
  attr_accessor :app_id,
    :name,
    :developer_name,
    :preview_uri,
    :image_uri,
    :release_date,
    :top_iap_title,
    :top_iap_price,
    :top_list_rank

  def release_date=(a_time_value)
    return if a_time_value.nil?
    if a_time_value.kind_of? Time
      @release_date = a_time_value
    else
      @release_date = Time.parse(a_time_value)
    end
  end

  def score
    top_list_rank_boost + iap_price_boost + release_date.to_f / 1000000
  end

  def iap_price_boost
    Math.log([top_iap_price.to_f, 1].max)
  end

  def top_list_rank_boost
    top_list_rank ? 16 : 0
  end
end
