class DetailsController < ApplicationController
  def update
    @detail = current_user.detail

    if @detail.update(detail_params)
      render nothing: true
    else
      errors = @detail.errors.messages.stringify_keys!
      errors.each { |k, v| errors[k] = "#{k.humanize} #{v.first}" }
      render json: { errors: errors }, status: 401
    end
  end

  private

  def detail_params
    params.require(:detail).permit(
      :first_name, :last_name, :organization, :job_title,
      :email, :phone, :fax, :address1, :address2,
      :city, :state, :postal_code, :country
    )
  end
end
