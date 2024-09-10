# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobarpaw',
             password_confirmation: 'foobarpaw',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
99.times do |n|
  test_name = Faker::Name.name
  test_email = "example-#{n + 1}@railstutorial.org"
  test_password = 'password'
  User.create!(name: test_name,
               email: test_email,
               password: test_password,
               password_confirmation: test_password,
               activated: true,
               activated_at: Time.zone.now)
end
user = User.order(:created_at).take(6)
50.times do
  dummy_content = Faker::Lorem.sentence(word_count: 5)
  user.each { |u| u.microposts.create!(content: dummy_content) }
end
