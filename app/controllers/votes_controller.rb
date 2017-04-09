class VotesController < ApplicationController
  before_action :authenticate_user!
  def create
    vote = current_user.votes.new vote_params
    if vote.save
      votable = vote.votable
      votable.update_attributes vote_count:
        (votable.vote_count + Vote.vote_types[vote.vote_type])
      init_vote_js
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash[:danger] = t "vote_failed"
      redirect_to :back
    end
  end

  def destroy
    vote = Vote.find_by user_id: current_user.id,
      votable_id: params[:vote][:votable_id],
      votable_type: params[:vote][:votable_type]
    votable = vote.votable
    votable.update_attributes vote_count:
      (votable.vote_count - Vote.vote_types[vote.vote_type])
    vote.destroy
    init_vote_js
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end
  end

  private
  def vote_params
    params.require(:vote).permit :votable_id, :votable_type, :vote_type
  end

  def init_vote_js
    @question = Question.find_by id: params[:vote][:votable_id]
    if @question
      @supports = Supports::Question.new @question, user_signed_in?,
        current_user
    else
      flash[:danger] = t "question_not_found"
      redirect_to root_path
    end
  end
end
