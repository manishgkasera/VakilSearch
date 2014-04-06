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
  location = if locations[row[' Location']]
    locations[row[' Location']]
  else
    locations[row[' Location']] = Location.create!(city: row[' Location'])
  end

  lawyer = Lawyer.create! code: row['Lawyer Code'],
                          name: row[' Lawyer Name'],
                          experiance:  row[' Years of Experience'],
                          average_rating: row[' Average Rating'],
                          location: location

  lawyers[lawyer.code] = lawyer
end

services = {}
CSV.read('db/seeds/Lawyer Service List.csv', headers: true).each do |row|
  lawyer = lawyers[row['Lawyer Code']]
  service = services[row[' Service Code']] || lawyer.services.create!(code: row[' Service Code'],
                                                                      name: row[' Service Name'],
                                                                      charge: row[' Charges'])
  lawyer.services << service
  services[service.code] ||= service
end