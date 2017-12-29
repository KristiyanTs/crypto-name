class SearchController < ApplicationController
  def index
    @results =
      if query.present?
        Suggester.new(query).call
      else
        []
      end

    @extensions = []
    @results.each do |result|
      @extensions << '.' + result["domain"].split('.').drop(1).join('.')
    end
    @extensions.uniq!

    respond_to do |format|
      format.html
      format.json { render :show, status: :created, location: @detail }
      format.js
    end
  end

  private

  def query
    params[:name]
  end
end
