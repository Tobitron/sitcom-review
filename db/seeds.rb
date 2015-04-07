# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

50.times do |n|
  User.create!(email: "email#{n}@gmail.com", password: "password")
end

50.times do |n|
  Sitcom.create!(user_id: 1, name: "Always Sunny#{n}",
  description: "this is a description", start_year: 2003)
end

50.times do |n|
  Review.create!(user_id: (n + 1), sitcom_id: 1,
  body: "The path of the righteous man is beset on all sides by the iniquities
   of the selfish and the tyranny of evil men. Blessed is he who, in the name
   of charity and good will, shepherds the weak through the valley of darkness,
   for he is truly his brother's keeper and the finder of lost children.
   And I will strike down upon thee with great vengeance and furious anger those
   who attempt to poison and destroy my brothers. And you will know my name is
   the Lord when I lay my vengeance upon thee.", rating: 4)
end
