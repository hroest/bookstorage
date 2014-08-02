class Author < ActiveRecord::Base
  has_and_belongs_to_many :books

  def getName
    if self.firstname.empty? and self.lastname.empty?
      return self.publisher unless (self.publisher.nil? or self.publisher.empty?)
      return self.comment unless (self.comment.nil? or self.comment.empty?)
      return self.id # last resort
    end
    self.firstname + " "  + self.lastname 
  end
end
