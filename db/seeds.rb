# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

account = Account.create! name: 'Huyện Châu Đức'

identity = Identity.create! email: 'nongnghiep@chaduc.vn', name: 'Nguyễn Mạnh Tường', password: 'mypassword123',
                            password_confirmation: 'mypassword123',
                            verified: true

identity_editor = Identity.create! email: 'chicong@chauduc.vn', name: 'Võ Chí Công', password: 'mypassword123',
                                   password_confirmation: 'mypassword123',
                                   verified: true

identity_writer = Identity.create! email: 'kiet@cacao-baria.com', name: 'Trần Tuấn Kiệt', password: 'mypassword123',
                                   password_confirmation: 'mypassword123',
                                   verified: true

person = Person.create! account:, personable: User.new(identity:, role: :admin)

Person.create! account:, personable: User.new(identity: identity_editor, role: :editor)

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
    registration_no: '123456789',
    legal_type: 'pc',
    status: Recording.statuses[:active],
    account: Current.account
  },
  {
    name: 'TNHN Đức Minh',
    registration_no: '023456789',
    legal_type: 'pc',
    status: Recording.statuses[:active],
    account: Current.account
  },
  {
    name: 'TNHN Nông Sản Hải An',
    registration_no: '323456789',
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

Person.create! account:, personable: Client.new(identity: identity_writer, role: :writer, company: Company.first!)

csv_text = Rails.root.join('db', 'ocop-bo-tieu-chi-03.csv').read
csv = CSV.parse csv_text, headers: true, col_sep: ';'

last_levels = {
  -1 => nil,
  0 => nil,
  1 => nil,
  2 => nil
}

level_mapping = {
  '1' => 'node_groups',
  '2' => 'node_subs',
  '3' => 'node_leaves'
}

csv.each do |row|
  params = row.to_hash

  # convert level from number to enum of Criterium using hash mapping
  params['level'] = level_mapping[params['level']] || 'node_roots'

  item = Criterium.find_or_create_by!(params) do |criterium|
    criterium.year = 2023
    criterium.account = Current.account
    criterium.parent = last_levels[Criterium.levels[criterium.level] - 1]
    criterium.status = Recording.statuses[:active]
  end

  last_levels[Criterium.levels[item.level]] = item
rescue ActiveRecord::RecordInvalid => e
  puts "Failed to create record: #{e.message}"
end
