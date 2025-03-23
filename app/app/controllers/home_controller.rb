class HomeController < ApplicationController
    def index 
        # @teams = Team.all
        # @players = Player.all
        @tournaments = Tournament.all
        # @matches = Match.all
    end
end
