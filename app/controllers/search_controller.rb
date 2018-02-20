# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @right_wrapper = 'carts/cart'
    @category = params[:category] || 0

    @results =
      if query.present?
        Suggester.new(query).call
      else
        []
      end

    debugger

    respond_to do |format|
      format.html { render template: "search/index" }
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
