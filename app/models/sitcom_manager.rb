class SitcomManager
  attr_reader :search_params, :page_params

  def initialize(search_params, page_params)
    @search_params = search_params
    @page_params = page_params
  end

  def newest_sitcoms
    if search_params.nil?
      Sitcom.order(start_year: :desc).page page_params
    else
      Sitcom.search(search_params).order(start_year: :desc).page page_params
    end
  end

  def highest_rated
    if search_params.nil?
      highest_rated = Sitcom.all.sort_by do |sitcom|
        sitcom.reviews.average(:rating).round(2).to_f unless sitcom.reviews.average(:rating).nil?
      end
    else
      highest_rated = Sitcom.search(search_params).sort_by do |sitcom|
        sitcom.reviews.average(:rating).round(2).to_f unless sitcom.reviews.average(:rating).nil?
      end
    end
    Kaminari.paginate_array(highest_rated.reverse).page page_params
  end

  def most_reviewed
    if search_params.nil?
      most_reviewed = Sitcom.all.sort_by do |sitcom|
        sitcom.reviews.count
      end
    else
      most_reviewed = Sitcom.search(search_params).sort_by do |sitcom|
        sitcom.reviews.count
      end
    end
    Kaminari.paginate_array(most_reviewed.reverse).page page_params
  end
end
