# frozen_string_literal: true

class User < ApplicationRecord
  validates :terms_of_service, acceptance: true
  validates :first_name, :last_name, presence: true

  has_many :transactions
  has_many :domains
  has_one :detail
  has_one :cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :lockable

  def active_details
    detail || Detail::Null::GoDaddy
  end

  def detail
    super || Detail.new(user: self)
  end
end
