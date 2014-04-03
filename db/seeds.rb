require 'faker'

10.times do
  User.create(
    handle: Faker::Internet.user_name,
    name: Faker::Name.name,
    email: Faker::Internet.free_email,
    password: "password"
  )

  Tweet.create(
    user_id: rand(0..10),
    content: Faker::Lorem.sentence(5),
    location: Faker::Address.city
  )
end