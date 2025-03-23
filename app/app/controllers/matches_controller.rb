class MatchesController < ApplicationController
    before_action :set_match, only: [:show, :edit, :update, :destroy]
    
    def index
        @matches = Match.all
    end
    
    def show
    end
    
    def new
        @match = Match.new
    end
    
    def create
        @match = Match.new(match_params)
        if @match.save
        flash[:notice] = " ✅ Match created successfully."
        redirect_to match_path(@match)
        else
        flash.now[:alert] = @match.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
        end
    end
    
    def edit
    end
    
    def update
        if @match.update(match_params)
        flash.now[:notice] = " ✅ Match updated successfully."
        redirect_to match_path(@match)
        else
        render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        if @match.destroy
        flash[:notice] = " ✅ Match deleted successfully."
        redirect_to matches_path
        else
        flash.now[:alert] = @match.errors.full_messages.join(", ")
        render :show, status: :unprocessable_entity
        end
    end
    
    private
    
    def set_match
        @match = Match.find(params[:id])
    end
    
    def match_params
        params.require(:match).permit(:team1_id, :team2_id, :score1, :score2, :date)
    end
end
