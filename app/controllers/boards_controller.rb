class BoardsController < ApplicationController

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
    @tasks = Task.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to board_path(@board), notice: '保存完了'
    else
      flash.now[:error] = '保存失敗'
      render :new
    end
  end

  private
  def board_params
    params.require(:board).permit(:name, :description)
  end
end
