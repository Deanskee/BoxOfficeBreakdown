class GuessesController < ApplicationController
  def index
  end

  def new
    @guess = Guess.new
  end

  def create
    @guess = Guess.new(guess_params)
      if @guess.save
      redirect_to groups_path(@user)
      else
      render :new
      end
  end

  def show
    @guess = Guess.find(params[:id])
  end

  def edit
    @guess = Guess.find(params[:id])
  end

  def update
    @guess = Guess.find(params[:id])
    if @guess.update(guess_params)
      redirect_to groups_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @guess.destroy
    redirect_to :back
  end

  private

  def guess_params 
    params.require(:guess).permit(:amount)
  end
end
