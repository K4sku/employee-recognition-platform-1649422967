# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Employee.create!([
  {email: "adam@test.com", password: "adamadam", password_confirmation: "adamadam", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "tomasz@test.com", password: "tomasztomasz", password_confirmation: "tomasztomasz", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "test@test.com", password: "testtest", password_confirmation: "testtest", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "asd@test.com", password: "asdasd", password_confirmation: "asdasd", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "user@test.com", password: "useruser", password_confirmation: "useruser", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil}
])

Kudo.create!([
  {title: "Kudo 1", content: "Kudo 1 content", giver: Employee.find_by(email: 'adam@test.com'), reciever: Employee.find_by(email: 'tomasz@test.com')},
  {title: "Kudo 2", content: "Kudo 2 content", giver: Employee.find_by(email: 'test@test.com'), reciever: Employee.find_by(email: 'user@test.com')},
  {title: "Kudo 3", content: "Kudo 3 content", giver: Employee.find_by(email: 'tomasz@test.com'), reciever: Employee.find_by(email: 'admin@test.com')}
])

Admin.create!([
  email: "admin@test.com", password: "adminadmin", password_confirmation: "adminadmin", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil,
  email: "admin2@test.com", password: "admin", password_confirmation: "admin", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil
  ])
