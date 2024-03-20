# frozen_string_literal: true

module RankingHelper
  def render_stars(score, max, total_stars = nil)
    total_stars = max if total_stars.nil?
    filled_stars = (total_stars * (score.to_f / [max, 1].max)).round

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

  def render_scores(score, max)
    score = 0 if score.nil?

    formatted_number = if score == score.to_i
                         score.to_i.to_s
                       else
                         format('%.1f', score)
                       end
    "#{formatted_number} / #{max} điểm"
  end

  def render_ranks(rank = 0)
    raise ArgumentError, 'Rank must be a number' unless rank.is_a? Numeric

    return '(chưa xếp hạng)' if rank.zero?

    (1..rank).map do
      '⭐️'
    end.join
  end
end
