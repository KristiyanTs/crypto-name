# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[show edit update destroy]

  def index
    @right_wrapper = 'notifications/index_nav'
    @notifications = Notification.all
  end

  def show; end

  def new
    @notification = Notification.new
  end

  def edit; end

  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.fetch(:notification, {})
  end
end
