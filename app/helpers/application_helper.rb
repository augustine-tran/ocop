# frozen_string_literal: true

module ApplicationHelper # rubocop:disable Metrics/ModuleLength
  def page_title_tag
    tag.title @page_title || 'OCOP'
  end

  def current_user_meta_tags
    return if Current.person.nil?

    safe_join [
      tag.meta(name: 'current-person-id', content: Current.person.id),
      tag.meta(name: 'current-person-name', content: Current.person.name)
    ]
  end

  def current_env_meta_tags
    tag.meta name: 'current-env', content: Rails.env
  end

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

  def dropzone_controller_div(accepted_files: nil, max_file_size: '20', max_files: '10', &block)
    accepted_files = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] unless accepted_files.is_a?(Array)

    accepted_files = accepted_files.join(',')

    # Prepare the data hash
    data = {
      controller: 'dropzone',
      'dropzone-max-file-size' => max_file_size,
      'dropzone-max-files' => max_files,
      'dropzone-accepted-files' => accepted_files,
      'dropzone-dict-file-too-big' => 'File is too large. Please upload a file smaller than {{maxFilesize}} MB',
      'dropzone-dict-invalid-file-type' => "File type is not supported. Please upload a file of type #{accepted_files}"
    }

    # Create the content tag
    content_tag(:div, class: 'dropzone dropzone-default dz-clickable border rounded p-4', data:, &block)
  end

  def dropzone_files_controller_div(&)
    data = {
      controller: 'dropzone',
      'dropzone-max-file-size' => '20',
      'dropzone-max-files' => '10',
      'dropzone-accepted-files' => 'application/pdf,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'dropzone-dict-file-too-big' => 'Váš obrázok ma veľkosť {{filesize}} ale povolené sú len obrázky do veľkosti {{maxFilesize}} MB',
      'dropzone-dict-invalid-file-type' => 'Nesprávny formát súboru. Iba obrazky .jpg, .png alebo .gif su povolene'
    }

    content_tag(:div, class: 'dropzone dropzone-default dz-clickable border rounded p-4', data:, &)
  end

  def create_option(text, url)
    [text, url, { selected: current_page?(url) }]
  end

  def submission_tab_options(submission, _assessment = nil)
    list_options = []

    if Current.person.can? :edit,
                           submission
      list_options << create_option(t(:submission), submission_url(submission))
    end

    if Current.person.can? :judge,
                           submission
      list_options << create_option(t(:submission_name, name: submission.name),
                                    panel_submission_url(submission))
    end

    if Current.person.can? :approve,
                           submission.self_assessment
      list_options << create_option(t(:submission_name, name: submission.name),
                                    assistant_submission_url(submission))
      list_options << create_option(t(:approve_self_assessment),
                                    assistant_submission_assessment_url(submission, submission.self_assessment))
    end

    list_options << if submission.self_assessment.can_submit?
                      create_option(t(:self_assessment),
                                    edit_assessment_url(submission.self_assessment))
                    else
                      create_option(t(:self_assessment),
                                    assessment_url(submission.self_assessment))
                    end

    if Current.person.can? :judge, submission
      list_options << create_option(t(:do_assessment), edit_assessment_url(submission.assessment_for(Current.person)))
      list_options << create_option(t(:final_assessment),
                                    final_assessment_url(submission.final_assessment))
    end

    if Current.person.can?(:approve, submission.self_assessment)
      list_options << create_option(t(:final_assessment),
                                    final_assessment_url(submission.final_assessment))
    end

    list_options
  end

  def main_menus
    menus = []
    menus << create_option(t('navigation.home'), root_url)

    if Current.person.assistant?
      menus << create_option(t('navigation.assistant_submissions'),
                             assistant_submissions_url)
    end

    menus << create_option(t('navigation.panel_submissions'), panel_submissions_url) if Current.person.judge?
    if Current.person.user? || Current.person.assistant?
      menus << create_option(t('navigation.my_submissions'),
                             submissions_url)
      menus << create_option(t('navigation.companies'),
                             companies_url)
    end
    menus << create_option(t('navigation.councils'), councils_url) unless Current.person.user?

    menus
  end
end
