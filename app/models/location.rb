class Location < ActiveRecord::Base

  def toFormName
    self.id.to_s + " " + self.getLocation
  end

  def getLocation
    self.apartment  +  " " +
    self.room  +  " " +
    self.shelf 
  end

  def <=> (other) #1 if self>other; 0 if self==other; -1 if self<other
    return self.getLocation.downcase <=> other.getLocation.downcase
  end

end
