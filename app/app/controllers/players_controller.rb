class PlayersController < ApplicationController
    before_action :set_player, only: [:show, :edit, :update, :destroy]
    def index
        @players = Player.all
    end

    def show
    end

    def new  
        @player = Player.new
    end

    def create
        @player = Player.new(player_params)
        if @player.save
            redirect_to player_path(@player), notice: "Player created successfully."
        else
            flash.now[:alert] = @player.errors.full_messages.join(", ")
            render new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        @player = Player.find(params[:id])
        if @player.update(player_params)
            flash.now[:notice] = " ✅ Player updated successfully."
            redirect_to player_path(@player)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @player.destroy
        if @player.destroyed?
            flash[:notice] = " ✅ Player deleted successfully."
            redirect_to players_path
        else
            Rails.logger.error "❌ Player deletion failed: #{@player.errors.full_messages.join(", ")}"
            flash.now[:alert] = @player.errors.full_messages.join(", ")
            render :show, status: :unprocessable_entity
        end
    end 

    private
    def set_player
        @player = Player.find(params[:id])
    end
    def player_params
        params.require(:player).permit(:name, :position, :team_id)
    end
    
end
