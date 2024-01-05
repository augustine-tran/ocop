# frozen_string_literal: true

module ApplicationHelper
  def active_menu_class(link_path)
    current_page?(link_path) ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'
  end

  def render_stars(score, max, total_stars = nil)
    total_stars = max if total_stars.nil?
    filled_stars = (total_stars * (score.to_f / max)).round

    filled_star = <<~SVG
          <svg width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
          <path d="M12 2l2.39 7.37h7.76l-6.28 4.56 2.39 7.37L12 16.77l-6.26 4.53 2.39-7.37-6.28-4.56h7.76L12 2z" fill="gold" stroke="transparent" stroke-width="2"/>
      </svg>

    SVG

    unfilled_star = <<~SVG
      <svg width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path d="M12 2l2.39 7.37h7.76l-6.28 4.56 2.39 7.37L12 16.77l-6.26 4.53 2.39-7.37-6.28-4.56h7.76L12 2z" fill="none" stroke="gray" stroke-width="1"/>
      </svg>
    SVG

    (1..total_stars).map do |i|
      if i <= filled_stars
        filled_star.html_safe # SVG for filled star # rubocop:disable Rails/OutputSafety
      else
        unfilled_star.html_safe # SVG for empty star # rubocop:disable Rails/OutputSafety
      end
    end.join.html_safe # rubocop:disable Rails/OutputSafety
  end

  def dropzone_controller_div(&)
    data = {
      controller: 'dropzone',
      'dropzone-max-file-size' => '8',
      'dropzone-max-files' => '10',
      'dropzone-accepted-files' => 'image/jpeg,image/jpg,image/png,image/gif,application/pdf',
      'dropzone-dict-file-too-big' => 'Váš obrázok ma veľkosť {{filesize}} ale povolené sú len obrázky do veľkosti {{maxFilesize}} MB',
      'dropzone-dict-invalid-file-type' => 'Nesprávny formát súboru. Iba obrazky .jpg, .png alebo .gif su povolene'
    }

    content_tag(:div, class: 'border rounded p-4 dz-clickable', data:, &)
  end
end
