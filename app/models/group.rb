class Group < ActiveRecord::Base
  has_one :request, dependent: :destroy
  has_one :book
  has_many :notes
  has_and_belongs_to_many :users
end
