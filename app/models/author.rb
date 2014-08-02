class Author < ActiveRecord::Base
  has_and_belongs_to_many :books

  def getName
    self.firstname + " "  + self.lastname
  end
end
