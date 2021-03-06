class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :update, :destroy]
  before_action :authorized

  # GET /goals
  def index
    @goals = Goal.where user: @user.id

    render json: @goals
  end

  # GET /goals/1
  def show
    render json: @goal
  end

  # POST /goals
  def create
    @goal = Goal.new(goal_params)
    @goal.user = @user

    if @goal.save
      render json: @goal, status: :created, location: @goal
    else
      render json: @goal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /goals/1
  def update
    if @goal.update(goal_params)
      render json: @goal
    else
      render json: @goal.errors, status: :unprocessable_entity
    end
  end

  # DELETE /goals/1
  def destroy
    @goal.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def goal_params ***DOESN'T WORK***
    #   params.require(:goal).permit(:goal, :target_date, :notes, :completed, :user_id)
    # end

    def goal_params
      params.permit(:goal, :target_date, :notes, :completed, :user_id)
    end
end
