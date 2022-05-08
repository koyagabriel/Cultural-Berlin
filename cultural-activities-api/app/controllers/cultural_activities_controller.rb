class CulturalActivitiesController < ApplicationController

  def index
    render json: {
      web_sources: WebSource.all,
      cultural_activities: CulturalActivity.ordered_activities_by_start_date
    }
  end

  def search
    render json: { cultural_activities: CulturalActivity.search(search_params) }
  end


  private

    def search_params
      params.permit(%i[web_source title date])
    end
end