class BookType < ActiveRecord::Base

  has_and_belongs_to_many :books

  def toFormName
    self.id.to_s + " " + self.name
  end

  def <=> (other) #1 if self>other; 0 if self==other; -1 if self<other
    return self.name.downcase <=> other.name.downcase
  end

end
