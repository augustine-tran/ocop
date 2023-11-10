# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

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
    title: 'TNHN Thiên Đức',
    legal_type: 'pc'
  },
  {
    title: 'TNHN Đức Minh',
    legal_type: 'pc'
  },
  {
    title: 'TNHN Nông Sản Hải An',
    legal_type: 'pc'
  }
]

companies_params.each do |company_param|
  company = Current.account.record Company.new(company_param), status: Recording.statuses[:active]
  ceo = Current.account.record Employee.new(title: 'Big Boss'), parent: company, status: Recording.statuses[:active]
  Current.account.record Employee.new(title: 'Employee 01', manager: ceo), parent: company,
                                                                           status: Recording.statuses[:active]
end
