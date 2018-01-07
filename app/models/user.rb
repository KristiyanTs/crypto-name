class User < ApplicationRecord
  has_many :transactions
  has_many :domains
  has_one :detail

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  def active_details
    detail || Detail::Null::GoDaddy
  end

  protected

  def after_sign_in_path_for
    search_index_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end
