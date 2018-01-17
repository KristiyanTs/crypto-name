class SearchController < ApplicationController
  def index  
    @right_wrapper = 'carts/cart'  
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

    @results   = @results.sort { |x,y| x['domain'].length <=> y['domain'].length }
    @suggested = @results.select { |res| [query+'.com', query, query.split('.').first + '.com'].include?(res['domain'])}


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
