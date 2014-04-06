class Lawyer < ActiveRecord::Base
  has_and_belongs_to_many :services
  belongs_to :location

  delegate :city, to: :location

  validates_presence_of :name, :code
  validates_uniqueness_of :code

  before_save :cleanse_name_and_code

  searchable do
    string  :city
    string  :service_codes, multiple: true do
      self.services.map(&:code)
    end

    float :average_rating
  end

  private

    def cleanse_name_and_code
      self.name = self.name.squish if self.name_changed?
      self.code = self.code.squish if self.code_changed?
    end
end
