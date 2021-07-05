# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do |i|
    title = Faker::Book.title
    author = Faker::Book.author
    Book.create!(title: title, author: author)
end

10.times do |i|
    name = Faker::Name.first_name
    last_name = Faker::Name.last_name 
    email = Faker::Internet.email(domain: 'example')
    address = Faker::Address.street_address
    phone = Faker::PhoneNumber.cell_phone_in_e164
    User.create!(name: name, last_name: last_name, email: email, address: address, phone: phone)
end