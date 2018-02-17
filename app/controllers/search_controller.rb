class SearchController < ApplicationController
  def index
    @right_wrapper = 'carts/cart'
    @type = params[:type] || 0

    @results =
      if query.present?
        Suggester.new(query, @type).call
      else
        []
      end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def query
    params[:name]
  end
end
