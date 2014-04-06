# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

locations = {}
lawyers = {}
CSV.read('db/seeds/Lawyers City List.csv', headers: true).each do |row|
  city = row[' Location'].squish
  location = if locations[city]
    locations[city]
  else
    locations[city] = Location.create!(city: city)
  end

  lawyer = Lawyer.create! code: row['Lawyer Code'].squish,
                          name: row[' Lawyer Name'].squish,
                          experiance:  row[' Years of Experience'].to_i,
                          average_rating: row[' Average Rating'].to_f,
                          location: location

  lawyers[lawyer.code] = lawyer
end

services = {}
CSV.read('db/seeds/Lawyer Service List.csv', headers: true).each do |row|
  lawyer = lawyers[row['Lawyer Code'].squish]
  service_code = row[' Service Code'].squish
  service = services[service_code] || lawyer.services.create!(code: service_code,
                                                                      name: row[' Service Name'].squish,
                                                                      charge: row[' Charges'].to_f)
  lawyer.services << service
  services[service.code] ||= service
end