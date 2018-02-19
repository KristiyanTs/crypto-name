# frozen_string_literal: true

class Domains::UnlockController < ApplicationController
  before_action :login

  def update
    @domain = Domain.find(params[:domain_id])
    Domain::Unlocker.new(@domain).call

    # TODO: Check if successfully unlocked
    respond_to do |format|
      format.js { flash[:success] = "#{@domain.name} successfully unlocked." }
    end

    redirect_to domains_path, notice: e.message
  rescue StandardError => e
    redirect_to domains_path, notice: e.message
  end
end
