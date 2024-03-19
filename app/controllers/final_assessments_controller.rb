# frozen_string_literal: true

class FinalAssessmentsController < ApplicationController
  before_action :set_assessment, only: %i[show edit update]
  before_action :set_submission, only: %i[show edit update]

  def show; end

  def edit
    return if Current.person.can? :final, @submission

    flash.now[:alert] = 'Chỉ có chủ tịch hội đồng giám khảo mới có quyền thực hiện chức năng này!'
  end

  def update
    unless Current.person.can? :final, @submission
      return redirect_to panel_submission_path(@submission),
                         alert: 'Chỉ có chủ tịch hội đồng giám khảo mới có quyền thực hiện chức năng này!'
    end

    unless @assessment.can_submit?
      return redirect_to panel_submission_path(@submission),
                         alert: 'Chưa thể hoàn thành đánh giá hồ sơ này. Vui lòng kiểm tra lại và thử lại sau.'
    end

    if @assessment.submit
      redirect_to final_assessment_path(@assessment), notice: "Hoàn thành đánh giá cho hồ sơ #{@submission.name}"
    else
      render :edit
    end
  end

  private

  def set_assessment
    @assessment = Assessment.find(params[:id])
  end

  def set_submission
    @submission = @assessment.submission
  end
end
