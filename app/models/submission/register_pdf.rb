# frozen_string_literal: true

class Submission::RegisterPdf < Prawn::Document
  def initialize(register_form)
    super({
      page_layout: :landscape
    })

    @form = register_form

    setup
    header
    text_content
    footer
  end

  def setup
    font_families.update(
      'Times' => {
        normal: "#{Rails.root}/app/assets/fonts/Times New Roman.ttf",
        bold: "#{Rails.root}/app/assets/fonts/Times New Roman Bold.ttf",
        italic: "#{Rails.root}/app/assets/fonts/Times New Roman Italic.ttf",
        bold_italic: "#{Rails.root}/app/assets/fonts/Times New Roman Bold Italic.ttf"
      }
    )
    fallback_fonts(['Times'])
    font 'Times'
  end

  def header
    text 'CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM', align: :center, size: 15, style: :bold
    text 'Độc lập - Tự do - Hạnh phúc', align: :center, size: 15, style: :bold
    text '-----------------------', align: :center, size: 15, style: :bold
    text 'PHIẾU ĐĂNG KÝ', align: :center, size: 15, style: :bold
  end

  def footer
    # image "#{Rails.root}/app/assets/images/logo-ocop.jpg", width: 530, height: 150
  end

  def text_content
    y_position = cursor - 15
    bounding_box([0, y_position], width: 720, height: 300) do
      default_leading 8
      text "Tham gia đánh giá, phân hạng sản phẩm Chương trình OCOP của tỉnh Bà Rịa Vũng Tàu năm #{Time.zone.now.year}",
           style: :bold, size: 14, align: :center
      text '1. Thông tin về đơn vị đăng ký:', size: 14
      text "- Tên đơn vị: #{@form.company_name} ", size: 14
      text "- Họ tên người đại diện pháp lý: #{@form.owner_name || '........................................'} ",
           size: 14
      text "- Chức vụ: #{@form.owner_job_title || '........................................'} ", size: 14
      text "- Địa chỉ liên hệ: #{@form.owner_address || '........................................'} ", size: 14
      text "- Điện thoại: #{@form.owner_phone || '........................................'} Email: #{@form.owner_email || '........................................'} ",
           size: 14
      text "2. Tên sản phẩm: <b>#{@form.product_name}</b>", size: 14, inline_format: true
      text "3. Nhóm sản phẩm đăng ký: #{@form.criteria_group_name} ", size: 14
      text '4. Lần đăng ký đánh giá: Lần đầu □ Nâng hạng: □ Đánh giá lại: □', size: 14
      text '5. Tài liệu kèm theo:', size: 14
      text '- Báo cáo đánh giá về sản phẩm theo Bộ tiêu chí (bản gốc, bản điện tử).', size: 14
      text "- Sản phẩm mẫu (số lượng): #{@form.sample_quantities || '........................................'} ",
           size: 14
    end
    text 'Cam đoan những thông tin trong Phiếu đăng ký là đúng sự thật, chúng tôi xin cam kết tuân thủ các quy định của Chương trình OCOP về đánh giá, phân hạng sản phẩm OCOP, chịu trách nhiệm trước Hội đồng và pháp luật về Hồ sơ đăng ký đánh giá, phân hạng sản phẩm.',
         size: 14, leading: 4

    y_position = cursor
    bounding_box([420, y_position], width: 240, height: 120) do
      default_leading 0
      text '................... ngày .... tháng .... năm .....', size: 14, align: :center
      text 'ĐẠI DIỆN', size: 14, style: :bold, align: :center
      text '(Ký, đóng dấu, ghi rõ họ tên)', size: 14, align: :center
      move_down 60
      text @form.owner_name, size: 14, style: :bold, align: :center
    end
  end
end
