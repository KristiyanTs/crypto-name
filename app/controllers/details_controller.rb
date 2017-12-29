class DetailsController < ApplicationController
  before_action :set_detail, only: [:show, :edit, :update, :destroy]

  def edit
    @detail = current_user.details.find(params[:id])
  end

  def create
    @detail = current_user.details.new(detail_params)
    @detail.activate!

    respond_to do |format|
      if @detail.save
        format.html { redirect_to edit_user_registration_path(current_user), notice: 'Detail was successfully created.' }
        format.json { render :show, status: :created, location: @detail }
      else
        format.html { render edit_user_registration_path(current_user) }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @detail.assign_attributes(detail_params)
    @detail.activate!

    respond_to do |format|
      if @detail.save
        format.html { redirect_to edit_user_registration_path(current_user), notice: 'Detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @detail }
      else
        format.html { render :edit }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @detail.destroy
    respond_to do |format|
      format.html { redirect_to edit_user_registration_path(current_user), notice: 'Detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def activate
    @detail = current_user.details.find(params[:id])
    current_user.details.update_all(active: false)
    @detail.update(active: true);

    respond_to do |format|
      format.html { redirect_to edit_user_registration_path(current_user), notice: 'Detail was selected as default.' }
      format.json { head :no_content }
    end
  end

  private
    def set_detail
      @detail = Detail.find(params[:id])
    end

    def detail_params
      params.require(:detail).permit(:first_name, :last_name, :organization, :job_title, :email, :phone, :fax, :address1, :address2, :city, :state, :postal_code)
    end
end
