class SearchController < ApplicationController
  def index
    @results =
      if query.present?
        Suggester.new(query).call
      else
        []
      end
  end

  private

  def query
    params[:name]
  end
end
