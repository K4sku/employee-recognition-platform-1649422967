Employee.create!([
  {email: "adam@test.com", password: "adamadam", password_confirmation: "adamadam", number_of_available_kudos: '10'},
  {email: "tomasz@test.com", password: "tomasztomasz", password_confirmation: "tomasztomasz", number_of_available_kudos: '10'},
  {email: "test@test.com", password: "testtest", password_confirmation: "testtest", number_of_available_kudos: '10'},
  {email: "asd@test.com", password: "asdasd", password_confirmation: "asdasd", number_of_available_kudos: '10'},
  {email: "user@test.com", password: "useruser", password_confirmation: "useruser", number_of_available_kudos: '10'}
])

Admin.create!([
  {email: "admin@test.com", password: "adminadmin", password_confirmation: "adminadmin"},
  {email: "admin2@test.com", password: "adminadmin", password_confirmation: "adminadmin"}
  ])

%w[Honesty Ownership Accountability Passion].each { |cv| CompanyValue.create!(title: cv) }

company_values = CompanyValue.all
employees = Employee.all
employees.each do |employee|
  recievers = Array.new(employees)
  recievers.delete(employee)
  rand(4..8).times do |i|
    Kudo.create!(title: "Kudo #{i}", content: "Kudo #{i} by #{employee.email} content",
                  giver: employee, reciever: recievers.sample,
                  company_value: company_values.sample)
    employee.decrement(:number_of_available_kudos).save
  end
end

Reward.create!([
  { title: "Bag of Wooden Nickels", description: "The Bag of Wooden Nickels was a bag of wooden coins was one of the many treasures in the treasure hold of LeChuck's ship.", price: 1 },
  { title: "Bottomless mug", description: "The Bottomless Mug was simply a mug with no bottom.", price: 1 },
  { title: "Brimstone Beach Club Card", description: "Brimstone Beach Club. Member Since 1632", price: 1 },
  { title: "Cursed Diamond Ring", description: "The ring, when placed on a persons finger, would turn its wearer gold.", price: 1 },
  { title: "Pancake Syrup", description: "Pancake Syrup was a sweet treat used as topping for puddings.", price: 1 },
  { title: "Murray's Arm", description: "The arm wore a floatie which made it float in the water, and grasped a pirate sword.", price: 1 }
])

rewards = Reward.all
employees.each do |employee|
  sample_rewards = rewards.sample(2)
  Order.create!([
    {employee: employee, reward: sample_rewards.first, purchase_price: sample_rewards.first.price, status: :placed},
    {employee: employee, reward: sample_rewards.last, purchase_price: sample_rewards.last.price, status: :delivered}
  ])
end
