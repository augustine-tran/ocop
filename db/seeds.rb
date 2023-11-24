# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

account = Account.create! name: 'Huyện Châu Đức'

identity = Identity.create! email: 'nongnghiep@chaduc.vn', name: 'Mạnh Tường', password: 'mypassword123',
                            password_confirmation: 'mypassword123',
                            verified: true

person = Person.create! account:, personable: User.new(identity:)

Current.person = person
Current.account = account

AdministrativeUnit.create! [
  {
    name: 'Bà Rịa Vũng Tàu',
    level: 'province'
  },
  {
    name: 'Châu Đức',
    level: 'district'
  },
  {
    name: 'Suối Nghệ',
    level: 'ward'
  },
  {
    name: 'Bình Ba',
    level: 'ward'
  }
]

companies_params = [
  {
    name: 'TNHN Thiên Đức',
    legal_type: 'pc',
    status: Recording.statuses[:active],
    account: Current.account
  },
  {
    name: 'TNHN Đức Minh',
    legal_type: 'pc',
    status: Recording.statuses[:active],
    account: Current.account
  },
  {
    name: 'TNHN Nông Sản Hải An',
    legal_type: 'pc',
    status: Recording.statuses[:active],
    account: Current.account
  }
]

companies_params.each do |company_param|
  company = Company.create! company_param
  ceo = Employee.create! name: 'Big Boss', company:, account: Current.account, status: Recording.statuses[:active]
  # Employee.create! name: 'Employee 01', manager: ceo, company:, status: Recording.statuses[:active],
  #                  account: Current.account
end

csv_text = Rails.root.join('db', 'ocop-bo-tieu-chi-03.csv').read
csv = CSV.parse csv_text, headers: true, col_sep: ';'

last_levels = {
  -1 => nil,
  0 => nil,
  1 => nil,
  2 => nil
}

csv.each do |row|
  params = row.to_hash

  puts params

  item = Criterium.new(params)
  item.account = Current.account
  item.parent = last_levels[item.level - 1]
  item.status = Recording.statuses[:active]
  item.save!

  last_levels[item.level] = item
end
