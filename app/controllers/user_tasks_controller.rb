class UserTasksController < ApplicationController
  before_action :set_user_task, only: %i[ show update destroy check ]

  # GET /user_tasks
  def index
    @user_tasks = UserTask.where(active: true)

    render json: @user_tasks
  end

  # GET /user_tasks/1
  def show
    render json: @user_task
  end

  # POST /user_tasks
  def create
    @user_task = UserTask.new(user_task_params)

    if @user_task.save
      render json: @user_task, status: :created, location: @user_task
    else
      render json: @user_task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_tasks/1
  def update
    if @user_task.update(user_task_params)
      render json: @user_task
    else
      render json: @user_task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_tasks/1
  def destroy
    @user_task.destroy!
  end

  def check
    @user_task.update(active: false)
  end

  def realized
    @user_tasks = UserTask.where(active: false)

    render json: @user_tasks
  end

  def filter_task
    @user_tasks = UserTask.where("name LIKE ?", "%#{params[:name]}%")

    render json: @user_tasks
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_task
      @user_task = UserTask.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_task_params
      params.permit(:name, :active)
    end
end
