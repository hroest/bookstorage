class Owner < ActiveRecord::Base

  def toFormName
    self.id.to_s + " " + self.name
  end
end
