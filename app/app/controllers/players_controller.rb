class PlayersController < ApplicationController
    before_action :set_player, only: [:show, :edit, :update]
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
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        @player = Player.find(params[:id])
        if @player.update(player_params)
            redirect_to player_path(@player), notice: "Player updated successfully."
        else
            render :edit, status: :unprocessable_entity
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
