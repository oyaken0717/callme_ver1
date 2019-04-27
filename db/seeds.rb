# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
21.times do |n|
  title = Faker::Job.title
  content = Faker::Job.field
  Post.create!(title: title,
               content: content,
               user_id: 1,
               group_id: 1
               )
end
