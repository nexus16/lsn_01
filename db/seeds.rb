# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(username: "admin", email: "admin@gmail.com", password: "123456",
  password_confirmation: "123456", is_admin: true)

10.times do |n|
  name = Faker::Name.name
  email = "a#{n+1}@a.a"
  password = "123456"
  User.create!(username: name,
  email: email,
  password: password,
  vote_count: 0)
end

5.times do |n|
  class_name = "lop #{n+1}"
  Category.create!(
  name: class_name
  )
end

(1..5).each do |n|
  object_name = ["Toan", "Ly", "Hoa", "Van", "Anh"]
  5.times do |m|
    Category.create!(
    name: object_name[m],
    parent_id: n
  )
  end
end

