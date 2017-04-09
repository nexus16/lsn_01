class ReportsController < ApplicationController
  def create
    @report = current_user.reports.new report_params
    if @report.save
      flash[:success] = t "success_report"
    else
      flash[:danger] = t "failure_report"
    end
    redirect_to question_path params[:report][:question_id]
  end

  private
  def report_params
    params.require(:report).permit :question_id, :content
  end
end
