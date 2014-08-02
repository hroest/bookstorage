class Author < ActiveRecord::Base
  has_and_belongs_to_many :books

  def getName
    return self.publisher if self.firstname.empty? and self.lastname.empty?
    self.firstname + " "  + self.lastname 
  end
end
