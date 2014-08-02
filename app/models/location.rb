class Location < ActiveRecord::Base

  def toFormName
    self.id.to_s + " " + self.getLocation
  end

  def getLocation
    self.apartment  +  " " +
    self.room  +  " " +
    self.shelf 
  end

end
