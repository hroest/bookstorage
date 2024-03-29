class Owner < ActiveRecord::Base

  has_many :books

  def toFormName
    self.id.to_s + " " + self.name
  end

  def <=> (other) #1 if self>other; 0 if self==other; -1 if self<other
    return self.name.downcase <=> other.name.downcase
  end
end
