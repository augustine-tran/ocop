# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

account = Account.create! name: 'Demo Account'

identity = Identity.create! email: 'donga.spirit@gmail.com', name: 'Demo Account', password: 'mypassword123',
                            password_confirmation: 'mypassword123',
                            verified: true

person = Person.create! account:, personable: User.new(identity:), role: :admin

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
    criterium.parent = last_levels[Criterium.levels[criterium.level] - 1]
    criterium.status = Recording.statuses[:active]
  end

  last_levels[Criterium.levels[item.level]] = item
rescue ActiveRecord::RecordInvalid => e
  puts "Failed to create record: #{e.message}"
end
