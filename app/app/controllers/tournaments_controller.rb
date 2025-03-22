class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit]

  def show
  end

  def new
    @tournament = Tournament.new
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to @tournament, notice: 'Tournament was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
      redirect_to @tournament, notice: 'Tournament was successfully updated.'
    else
      render :edit
    end
  end

  private
  def tournament_params
    params.require(:tournament).permit(:name, :start_date, :end_date)
  end
  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

end
