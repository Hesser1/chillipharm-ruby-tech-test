class SavedSearchesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    options = {
      library_id: params[:id], 
      name: params[:save_name],
      keyword: params[:search],
      sort: params[:sort],
      filter: params[:filter]
    }

    @saved_search = SavedSearches.new(options)
    if @saved_search.save
      flash[:notice] = 'Search was saved'
    else
      flash[:error] = 'Search could not be saved'
    end
    redirect_to library_path(params[:id])
  end

  def delete
    if SavedSearches.find(params[:saved_search_id]).delete
      flash[:notice] = 'Search was deleted' 
    else
      flash[:error] = 'Search could not be deleted'
    end
    redirect_to library_path(params[:id])
  end
end
