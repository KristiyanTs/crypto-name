# frozen_string_literal: true

class Domains::CodeController < ApplicationController
  before_action :login

  def show
    @domain = Domain.find(params[:domain_id])

    render json: Domain::UnlockCode.new(@domain).call
  rescue StandardError => e
    render json: { error: e.message }
  end
end
