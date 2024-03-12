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

[ # rubocop:disable Metrics/BlockLength
  { file: 'OCOP - 1. Bộ sản phẩm_ Rau, củ, quả, hạt tươi.csv', name: '1. Bộ sản phẩm_ Rau, củ, quả, hạt tươi' },
  { file: 'OCOP - 2. Bộ sản phẩm_ Thịt, thủy sản, trứng, sữa tươi.csv',
    name: '2. Bộ sản phẩm_ Thịt, thủy sản, trứng, sữa tươi' },
  { file: 'OCOP - 3. Bộ sản phẩm_ Gạo, ngũ cốc, hạt sơ chế khác.csv',
    name: '3. Bộ sản phẩm_ Gạo, ngũ cốc, hạt sơ chế khác' },
  { file: 'OCOP - 4. Bộ sản phẩm_ Mật ong, mật khác và nông sản thực phẩm khác.csv',
    name: '4. Bộ sản phẩm_ Mật ong, mật khác và nông sản thực phẩm khác' },
  { file: 'OCOP - 5. Bộ sản phẩm_ Đồ ăn nhanh.csv', name: '5. Bộ sản phẩm_ Đồ ăn nhanh' },
  { file: 'OCOP - 6. Bộ sản phẩm_ Chế biến từ gạo, ngũ cốc.csv', name: '6. Bộ sản phẩm_ Chế biến từ gạo, ngũ cốc' },
  { file: 'OCOP - 7. Bộ sản phẩm_ Chế biến từ rau, củ, quả, hạt.csv',
    name: '7. Bộ sản phẩm_ Chế biến từ rau, củ, quả, hạt' },
  { file: 'OCOP - 8. Chế biến từ thịt, thủy sản, trứng, sữa, các sản phẩm từ mật ong.csv',
    name: '8. Chế biến từ thịt, thủy sản, trứng, sữa, các sản phẩm từ mật ong' },
  { file: 'OCOP - 9. Bộ sản phẩm_ Tương, nước mắm, gia vị dạng lỏng khác.csv',
    name: '9. Bộ sản phẩm_ Tương, nước mắm, gia vị dạng lỏng khác' },
  { file: 'OCOP - 10. Bộ sản phẩm_ Gia vị khác (muối, hành, tỏi, tiêu,...).csv',
    name: '10. Bộ sản phẩm_ Gia vị khác (muối, hành, tỏi, tiêu,...).' },
  { file: 'OCOP - 11. Bộ sản phẩm_ Chè tươi, chè chế biến.csv', name: '11. Bộ sản phẩm_ Chè tươi, chè chế biến' },
  { file: 'OCOP - 12. Sản phẩm trà từ thực vật khác.csv', name: '12. Sản phẩm trà từ thực vật khác' },
  { file: 'OCOP - 13. Sản phẩm cà phê, ca cao.csv', name: '13. Sản phẩm cà phê, ca cao' },
  { file: 'OCOP - 14. Bộ sản phẩm_ Rượu trắng.csv', name: '14. Bộ sản phẩm_ Rượu trắng' },
  { file: 'OCOP - 15. Bộ sản phẩm_ Đồ uống có cồn khác.csv', name: '15. Bộ sản phẩm_ Đồ uống có cồn khác' },
  { file: 'OCOP - 16. Bộ sản phẩm; Nước khoáng thiên nhiên, nước uống tinh khiết đóng chai.csv',
    name: '16. Bộ sản phẩm; Nước khoáng thiên nhiên, nước uống tinh khiết đóng chai' },
  { file: 'OCOP - 17. Bộ sản phẩm_ Đồ uống không cồn khác.csv', name: '17. Bộ sản phẩm_ Đồ uống không cồn khác' },
  { file: 'OCOP - 18. Bộ sản phẩm_ Thực phẩm chức năng, thuốc dược liệu, thuốc y học cổ truyền.csv',
    name: '18. Bộ sản phẩm_ Thực phẩm chức năng, thuốc dược liệu, thuốc y học cổ truyền' },
  { file: 'OCOP - 19. Bộ sản phẩm_ Mỹ phẩm có thành phần từ Thảo dược.csv',
    name: '19. Bộ sản phẩm_ Mỹ phẩm có thành phần từ Thảo dược' },
  { file: 'OCOP - 20. Bộ sản phẩm_ Tinh dầu và thảo dược khác.csv',
    name: '20. Bộ sản phẩm_ Tinh dầu và thảo dược khác' },
  { file: 'OCOP - 21. Bộ sản phẩm_ Thủ công mỹ nghệ gia dụng, trang trí.csv',
    name: '21. Bộ sản phẩm_ Thủ công mỹ nghệ gia dụng, trang trí' },
  { file: 'OCOP - 22. Bộ sản phẩm_ Vải, may mặc.csv', name: '22. Bộ sản phẩm_ Vải, may mặc' },
  { file: 'OCOP - 23. Bộ sản phẩm_ Hoa.csv', name: '23. Bộ sản phẩm_ Hoa' },
  { file: 'OCOP - 24. Bộ sản phẩm_ Cây cảnh.csv', name: '24. Bộ sản phẩm_ Cây cảnh' },
  { file: 'OCOP - 25. Bộ sản phẩm_ Động vật cảnh.csv', name: '25. Bộ sản phẩm_ Động vật cảnh' },
  { file: 'OCOP - 26. Bộ sản phẩm_ Dịch vụ du lịch cộng đồng, du lịch sinh thái và điểm du lịch.csv',
    name: '26. Bộ sản phẩm_ Dịch vụ du lịch cộng đồng, du lịch sinh thái và điểm du lịch' }
].each do |group|
  cg = bucket_ocop.criteria_groups.create! group

  next if group[:file].blank?

  puts "Processing file: #{cg.name} -> #{group[:file]}"

  csv_text = Rails.root.join('db', 'ocop', group[:file]).read
  csv = CSV.parse csv_text, headers: true, col_sep: ','

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

  last_item = nil

  csv.each do |row|
    params = row.to_hash

    # convert level from number to enum of Criterium using hash mapping
    level = params['level'].to_i
    params['level'] = level_mapping[params['level']] || 'node_roots'
    params['title'] = params['title'].gsub(/^□\s/, '')

    # puts "#{last_item&.id} -> #{last_item&.level} == 'node_groups' && #{params['level']} == 'node_leaves'"
    if last_item&.level == 'node_groups' && params['level'] == 'node_leaves'
      node_sub = Criterium.create! title: last_item.title.gsub(/^[\d]+\./, 'a)'), level: 'node_subs',
                                   criteria_group: cg, parent: last_item
      last_levels[2] = node_sub
      last_item = node_sub
      puts "\t\t #{node_sub.title}"
    end

    case params['level']
    when 'node_roots'
      puts "#{params['title']}"
    when 'node_groups'
      puts "\t #{params['title']}"
    when 'node_subs'
      puts "\t\t #{params['title']}"
    when 'node_leaves'
      puts "\t\t\t #{params['title']}"
    end

    item = Criterium.create!(params) do |criterium|
      criterium.criteria_group = cg

      criterium.parent = last_levels[Criterium.levels[criterium.level] - 1]

      criterium.status = Recording.statuses[:active]
      if criterium.stars.to_i.positive?
        if criterium.level == 'node_leaves'
          criterium.parent.update "star_#{criterium.stars}": criterium.score
        else # node_groups, node_subs
          criterium["star_#{criterium.stars}"] = criterium.score
        end
      end
    end

    last_levels[Criterium.levels[item.level]] = item
    last_item = item
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create record: #{e.message}"
  end
end
