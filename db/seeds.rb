# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Employee.create!([
  {email: "adam@test.com", password: "adamadam", password_confirmation: "adamadam", number_of_available_kudos: '9'},
  {email: "tomasz@test.com", password: "tomasztomasz", password_confirmation: "tomasztomasz", number_of_available_kudos: '9'},
  {email: "test@test.com", password: "testtest", password_confirmation: "testtest", number_of_available_kudos: '9'},
  {email: "asd@test.com", password: "asdasd", password_confirmation: "asdasd", number_of_available_kudos: '10'},
  {email: "user@test.com", password: "useruser", password_confirmation: "useruser", number_of_available_kudos: '10'}
])

["Honesty", "Ownership", "Accountability", "Passion"].each { |cv| CompanyValue.create!(title: cv) }

Kudo.create!([
  {title: "Kudo 1", content: "Kudo 1 content", giver: Employee.find_by(email: 'adam@test.com'), reciever: Employee.find_by(email: 'tomasz@test.com'), company_value: CompanyValue.find_by(title: 'Passion')},
  {title: "Kudo 2", content: "Kudo 2 content", giver: Employee.find_by(email: 'test@test.com'), reciever: Employee.find_by(email: 'user@test.com'), company_value: CompanyValue.find_by(title: 'Honesty')},
  {title: "Kudo 3", content: "Kudo 3 content", giver: Employee.find_by(email: 'tomasz@test.com'), reciever: Employee.find_by(email: 'adam@test.com'), company_value: CompanyValue.find_by(title: 'Honesty')}
])

Admin.create!([
  {email: "admin@test.com", password: "adminadmin", password_confirmation: "adminadmin"},
  {email: "admin2@test.com", password: "adminadmin", password_confirmation: "adminadmin"}
  ])
