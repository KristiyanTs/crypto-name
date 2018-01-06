class DetailsController < ApplicationController

  def update
    @detail = current_user.detail

    respond_to do |format|
      if @detail.update(detail_params)
        format.html { redirect_to edit_user_registration_path(current_user), notice: 'Detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @detail }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
  
  private

  def detail_params
    params.require(:detail).permit(:first_name, :last_name, :organization, :job_title, :email, :phone, :fax, :address1, :address2, :city, :state, :postal_code)
  end
end
