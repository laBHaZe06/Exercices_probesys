class HomeController < ApplicationController
    def index 
        @teams = Team.all
        @players = Player.all
    end
end
