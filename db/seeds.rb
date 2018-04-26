# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# rake db:seed
puts "seeding..."
#User.create(:email => "admin@gmail.com",:password => "123")


user = User.create!(
    email: 'admin@gmail.com',
    password: '123456789',
    password_confirmation: '123456789',
    admin: 'true'
)
user.save!

puts "seeding is done"
puts "email: admin@gmail.com"
puts "password: 123"
puts "Remember to do this every time you reset the database!"
puts "Have nice day!"