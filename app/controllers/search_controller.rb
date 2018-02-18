class SearchController < ApplicationController
  def index
    @right_wrapper = 'carts/cart'
    @type = params[:type] || 0
    @category = params[:category] || 0

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

  def new
    @name = params[:name]
    @category = params[:category]

    @results = Availability.new(@name, @category).call
  end

  private

  def query
    params[:name]
  end
end
