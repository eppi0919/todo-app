class TasksController < ApplicationController
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    @task.user_id = current_user.id
    if @task.save!
      redirect_to board_path(board), notice: '保存完了'
    else
      flash.now[:error] = '保存失敗'
      render :new
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline)
  end
end