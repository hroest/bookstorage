class Location < ActiveRecord::Base

  def getLocation

    self.room  +  " " +
    self.shelf 
  end

end
