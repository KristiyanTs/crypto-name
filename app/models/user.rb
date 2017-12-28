class User < ApplicationRecord
  has_many :transactions
  has_many :domains
  has_many :details

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
end
