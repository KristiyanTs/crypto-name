# frozen_string_literal: true

class PagesController < ApplicationController
  def show
    @right_wrapper = 'pages/terms_nav' if params[:page] == 'terms'
    render template: "pages/#{params[:page]}"
  end

  def create
    
  end
end
