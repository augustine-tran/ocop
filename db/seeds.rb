# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

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

account = Account.create! name: 'Phòng Nông nghiệp và Phát triển nông thôn huyện Châu Đức'
Current.account = account

departments = ['Phòng Nông nghiệp và Phát triển nông thôn huyện Châu Đức',
               'Phòng Tài nguyên và Môi trường huyện Châu Đức', 'Phòng Giáo dục và Đào tạo huyện Châu Đức', 'Phòng Y tế huyện Châu Đức', 'Phòng Lao động - Thương binh và Xã hội huyện Châu Đức', 'Phòng Kế hoạch và Đầu tư huyện Châu Đức', 'Phòng Công thương huyện Châu Đức', 'Phòng Văn hóa và Thông tin huyện Châu Đức', 'Phòng Công an huyện Châu Đức', 'Phòng Quản lý xây dựng huyện Châu Đức', 'Phòng Tư pháp huyện Châu Đức', 'Phòng Nội vụ huyện Châu Đức', 'Phòng Tổ chức cán bộ huyện Châu Đức', 'Phòng Thanh tra huyện Châu Đức', 'Phòng Kế hoạch và Đầu tư huyện Châu Đức', 'Phòng Công thương huyện Châu Đức', 'Phòng Văn hóa và Thông tin huyện Châu Đức', 'Phòng Công an huyện Châu Đức', 'Phòng Quản lý xây dựng huyện Châu Đức', 'Phòng Tư pháp huyện Châu Đức', 'Phòng Nội vụ huyện Châu Đức', 'Phòng Tổ chức cán bộ huyện Châu Đức', 'Phòng Thanh tra huyện Châu Đức']

Category.create!([
                   { title: 'Tin tức' },
                   { title: 'Sản phẩm' }
                 ])
Category.create!([
                   { title: 'Tin tức', parent: Category.find_by(slug: 'tin-tuc') },
                   { title: 'Văn bản pháp luật', parent: Category.find_by(slug: 'tin-tuc') },
                   { title: 'Ngành đồ uống', parent: Category.find_by(slug: 'san-pham') },
                   { title: 'Ngành thịt trứng sữa', parent: Category.find_by(slug: 'san-pham') }
                 ])

bucket_ocop = Current.account.criteria_buckets.create! name: 'OCOP', year: 2024
cg1 = bucket_ocop.criteria_groups.create! name: 'Nhóm thức uống'

ocop_council = Current.account.councils.create! name: 'Hội đồng đánh giá OCOP huyện Châu Đức',
                                                criteria_bucket: bucket_ocop
2.times do |i|
  idx = (i + 1)
  identity = Identity.create! email: "giamkhao#{idx}@g.com", name: "Giám khảo #{idx}", password: 'Ocop@2024',
                              password_confirmation: 'Ocop@2024',
                              verified: true
  person = Person.create! account:, personable: Judge.new(identity:, department: departments.sample)
  ocop_council.members.create! person:, role: CouncilMember.roles[(i.zero? ? :president : :judge)]
end

2.times do |i|
  idx = (i + 1)
  identity = Identity.create! email: "chuyenvien#{idx}@g.com", name: "Chuyên viên #{idx}", password: 'Ocop@2024',
                              password_confirmation: 'Ocop@2024',
                              verified: true
  person = Person.create! account:, personable: Assistant.new(identity:, department: departments.sample)
  ocop_council.members.create! person:, role: :assistant
end

province_council = Current.account.councils.create! name: 'Hội đồng đánh giá OCOP tỉnh Bà Rịa Vũng Tàu',
                                                    criteria_bucket: bucket_ocop
2.times do |i|
  idx = (i + 1)
  identity = Identity.create! email: "judge#{idx}@t.com", name: "Giám khảo #{idx}", password: 'Ocop@2024',
                              password_confirmation: 'Ocop@2024',
                              verified: true
  person = Person.create! account:, personable: Judge.new(identity:, department: departments.sample)
  province_council.members.create! person:, role: CouncilMember.roles[(i.zero? ? :president : :judge)]
end

2.times do |i|
  idx = (i + 1)
  identity = Identity.create! email: "assistant#{idx}@t.com", name: "Chuyên viên #{idx}", password: 'Ocop@2024',
                              password_confirmation: 'Ocop@2024',
                              verified: true
  person = Person.create! account:, personable: Assistant.new(identity:, department: departments.sample)
  province_council.members.create! person:, role: :assistant
end

identity = Identity.create! email: 'demo@acme.vn', name: 'Demo User', password: 'Ocop@2024',
                            password_confirmation: 'Ocop@2024',
                            verified: true
Person.create! account:, personable: User.new(identity:)

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
    criterium.criteria_group = cg1
    criterium.parent = last_levels[Criterium.levels[criterium.level] - 1]
    criterium.status = Recording.statuses[:active]
  end

  last_levels[Criterium.levels[item.level]] = item
rescue ActiveRecord::RecordInvalid => e
  puts "Failed to create record: #{e.message}"
end
