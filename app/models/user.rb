class User < ApplicationRecord
  has_many :transactions
  has_many :domains

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
end
