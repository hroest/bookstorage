class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors
  belongs_to :language
  belongs_to :book_type
  belongs_to :owner
  belongs_to :location
end
