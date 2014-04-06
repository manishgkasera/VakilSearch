class Location < ActiveRecord::Base
  validates_presence_of :city
  cleanse_before_save :city

end
