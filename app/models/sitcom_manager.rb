class SitcomManager
  attr_reader :search_params, :page_params

  def initialize(search_params, page_params)
    @search_params = search_params
    @page_params = page_params
  end

  def newest_sitcoms
    if user_searched?
      newest_sitcoms = order_search_by_start_year
    else
      newest_sitcoms = order_by_start_year
    end
    newest_sitcoms.limit(10)
  end

  def highest_rated
    if user_searched?
      highest_rated = order_search_by_highest_rated
    else
      highest_rated = order_by_highest_rated
    end
    Kaminari.paginate_array(highest_rated.reverse.take(10)).page page_params
  end

  def most_reviewed
    if user_searched?
      most_reviewed = order_search_by_most_reviewed
    else
      most_reviewed = order_by_most_reviewed
    end
    Kaminari.paginate_array(most_reviewed.reverse.take(10)).page page_params
  end

  private
  def user_searched?
    !(search_params.nil?)
  end

  def order_by_start_year
    Sitcom.order(start_year: :desc).page page_params
  end

  def order_search_by_start_year
    Sitcom.search(search_params).order(start_year: :desc).page page_params
  end

  def order_search_by_highest_rated
    Sitcom.search(search_params).sort_by do |sitcom|
      unless sitcom.reviews.average(:rating).nil?
        sitcom.reviews.average(:rating).round(2).to_f
      else
        0
      end
    end
  end

  def order_by_highest_rated
    Sitcom.all.sort_by do |sitcom|
      unless sitcom.reviews.average(:rating).nil?
        sitcom.reviews.average(:rating).round(2).to_f
      else
        0
      end
    end
  end

  def order_search_by_most_reviewed
    Sitcom.search(search_params).sort_by do |sitcom|
      sitcom.reviews.count
    end
  end

  def order_by_most_reviewed
    Sitcom.all.sort_by do |sitcom|
      sitcom.reviews.count
    end
  end
end
