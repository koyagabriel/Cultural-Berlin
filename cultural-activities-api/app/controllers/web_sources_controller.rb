class WebSourcesController < ApplicationController

  def index
    render json:  { web_sources: WebSource.all }
  end
end
