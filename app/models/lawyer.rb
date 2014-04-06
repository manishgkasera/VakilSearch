class Lawyer < ActiveRecord::Base
  has_and_belongs_to_many :services
  belongs_to :location

  delegate :city, to: :location

  validates_presence_of :name, :code
  validates_uniqueness_of :code
end
