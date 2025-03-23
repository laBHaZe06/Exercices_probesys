class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update]
  def index
    @teams = Team.all
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:notice] = " ✅ Team created successfully."
      redirect_to team_path(@team)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to @team
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team = Team.find(params[:id])
    if @team.destroy
      flash[:notice] = " ✅ Team deleted successfully."
      redirect_to teams_path
    else
      Rails.logger.error "❌ Team deletion failed: #{@team.errors.full_messages.join(", ")}"
      flash.now[:alert] = @team.errors.full_messages.join(", ")
      render new, status: :unprocessable_entity
    end
  end

  private
  def set_team
    @team = Team.find(params[:id])
  end
  def team_params
    params.expect(team: [:name, :town])
  end
end
