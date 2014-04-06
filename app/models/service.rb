class Service < ActiveRecord::Base
  has_and_belongs_to_many :lawyers

  validates_presence_of :code, :name, :charge
  validates_uniqueness_of :code
end
