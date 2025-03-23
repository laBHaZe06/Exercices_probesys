class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show]

  def index
    @tournaments = Tournament.all
    @classements = @tournaments.map { |tournament| [tournament.id, calculate_classement(tournament)] }.to_h
  end

  def new
    @tournament = Tournament.new
  end

  def show
  end

  def create
    # Tournament.destroy_all
    @tournament = Tournament.create(tournament_params)
    @tournament.start_date = Date.today

    if @tournament.persisted?
      Rails.logger.info "✅ Tournament created: #{@tournament.name}"

      teams = create_teams_and_players(@tournament)
      create_matches(@tournament, teams)

      flash.now[:notice] = "✅ Tournoi créé avec succès !"
      redirect_to tournament_path(@tournament)
    else
      Rails.logger.error "❌ Tournament creation failed: #{@tournament.errors.full_messages.join(", ")}"
      flash.now[:alert] = @tournament.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
      flash.now[:notice] = " ✅ Tournament updated successfully."
      redirect_to tournament_path(@tournament)
    else
      Rails.logger.error "❌ Tournament update failed: #{@tournament.errors.full_messages.join(", ")}"
      flash.now[:alert] = @tournament.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tournament.destroy
    if @tournament.destroyd?
      flash[:notice] = " ✅ Tournament deleted successfully."
      redirect_to tournaments_path
    else
      Rails.logger.error "❌ Tournament deletion failed: #{@tournament.errors.full_messages.join(", ")}"
      flash.now[:alert] = @tournament.errors.full_messages.join(", ")
      render :show, status: :unprocessable_entity
    end
  end

  
  def create_teams_and_players(tournament)
    positions = ["Tank", "DPS", "Heal"]
    teams = []

    indexes = (1..8).to_a.shuffle

    indexes.each do |i|
      team = Team.create(
        name: "Team #{i + 1}", 
        town: "Town #{i + 1}", 
        tournament: tournament
      )
      teams << team

      11.times do |j|
        Player.create(
          name: "Player #{j + 1}", 
          position: positions.sample, 
          team: team
          )
      end
    end
    teams
  end

  def create_matches(tournament, teams)
    teams.combination(2).each do |team1, team2|
      Match.create!(
        team1: team1, 
        team2: team2,
        team1_score: rand(0..5),
        team2_score: rand(0..5),
        tournament: @tournament
      )
      Rails.logger.info "✅ Match: #{team1.name} vs #{team2.name}"
    end
    tournament.update(end_date: Date.today)
  end

  def calculate_classement(tournament)
    classement = {}
  
    tournament.matches.each do |match|
      team1, team2 = match.team1, match.team2

  
      # Initialiser les équipes si elles ne sont pas encore dans le classement
      classement[team1] ||= { points: 0, kills_received: 0, kills_scored: 0 }
      classement[team2] ||= { points: 0, kills_received: 0, kills_scored: 0 }
  
      # Ajouter les kills marqués et reçus
      classement[team1][:kills_scored] += match.team1_score
      classement[team1][:kills_received] += match.team2_score
  
      classement[team2][:kills_scored] += match.team2_score
      classement[team2][:kills_received] += match.team1_score
  
      if match.team1_score > match.team2_score
        classement[team1][:points] += 3
      elsif match.team1_score < match.team2_score
        classement[team2][:points] += 3
      else 
        classement[team1][:points] += 1
        classement[team2][:points] += 1
      end

    end
  
    
    sorted_array = classement.sort_by { |team, stats| [-stats[:points], -stats[:kills_scored]] }

    classement = sorted_array.to_h

    Rails.logger.info "✅ Classement après tri : #{classement.inspect}"


    if classement.any?
      winner = classement.first
      @winner_message = "🏆 The winner is #{winner[0].name} with #{winner[1][:points]} points & #{winner[1][:kills_scored]} Kills 🪖 !"
    end
    classement 
  end
  


    private
  
    def set_tournament
      @tournament = Tournament.find(params[:id])
      @matches = @tournament.matches
      @classement = calculate_classement(@tournament)
      @winner_message = calculate_classement(@tournament)
    end
  
    def tournament_params
      params.require(:tournament).permit(:name)
    end
end
