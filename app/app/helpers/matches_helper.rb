module MatchesHelper
        def match_actions(player)
            content_tag(:div, class: "d-flex gap-2") do
            link_to("Show", player, class: "btn btn-info btn-sm") 
        end
    end
end
