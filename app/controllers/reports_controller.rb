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

  def destroy
    report = Report.find_by id: params[:id]
    authorize report
    if report
      @question = report.question
      report.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "admin.delete_report_fails"
      redirect_to :back
    end
  end

  private
  def report_params
    params.require(:report).permit :question_id, :content
  end
end
