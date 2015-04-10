# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "sitcoms_admin@example.com", password: "launchacademy", password_confirmation: "launchacademy",  role: "admin")
User.create!(email: "kyle@example.com", password: "launchacademy", password_confirmation: "launchacademy", role: "admin")
User.create!(email: "kate@example.com", password: "launchacademy", password_confirmation: "launchacademy", role: "admin")
User.create!(email: "tobias@example.com", password: "launchacademy", password_confirmation: "launchacademy", role: "admin")
User.create!(email: "rocco@example.com", password: "launchacademy", password_confirmation: "launchacademy", role: "admin")

Sitcom.create!(user_id: 1,
               name: "Modern Family",
               description: "Three different, but related families face trials and tribulations in their own uniquely comedic ways.",
               start_year: 2009,
               network: "ABC",
               genre: "Sitcom")

Sitcom.create!(user_id: 1,
               name: "New Girl",
               description: "A newly single woman moves into an apartment with 3 men.",
               start_year: 2011,
               network: "Fox",
               genre: "Sitcom")
