class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :book_types
  belongs_to :language
  belongs_to :owner
  belongs_to :location

  def <=> (other) #1 if self>other; 0 if self==other; -1 if self<other
    return self.title.downcase <=> other.title.downcase
  end

  def getLocation
    self.location.getLocation +  " : "  +
    self.column_nr.to_s  + " (Column) " +
    self.row_nr.to_s + " (Height)" if self.location
  end

  def getTitle
    return self.title if title.present?
    return self.id
  end

end

