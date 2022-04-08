# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Employee.create!([
  {email: "adam@adam.com", password: "adamadam", password_confirmation: "adamadam", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "tomasz@tomasz.com", password: "tomasztomasz", password_confirmation: "tomasztomasz", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "test@test.com", password: "testtest", password_confirmation: "testtest", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "admin@admin.com", password: "adminadmin", password_confirmation: "adminadmin", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "user@user.com", password: "useruser", password_confirmation: "useruser", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil}
])