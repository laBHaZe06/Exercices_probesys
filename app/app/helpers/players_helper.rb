module PlayersHelper
    def player_form(player)
        content_tag(:div, class: "container mt-4") do
        form_with(model: player, class: "mt-3") do |form|
        content_tag(:div, class: "mb-3") do
            form.label(:name, class: "form-label") +
            form.text_field(:name, class: "form-control", placeholder: "Enter player name")
        end +

        content_tag(:div, class: "mb-3") do
            form.label(:position, "Position", class: "form-label") +
            form.select(:position, ["Heal", "Tank", "DPS"], {}, class: "form-select")
        end +

        content_tag(:div, class: "mb-3") do
            form.label(:team_id, "Team", class: "form-label") +
            form.collection_select(:team_id, Team.all, :id, :name, { prompt: "Select a team" }, class: "form-select")
        end +

        content_tag(:div, class: "d-flex gap-2") do
            form.submit(class: "btn btn-success") +
            link_to("Cancel", players_path, class: "btn btn-secondary")
        end
        end
    end
    end

    def player_actions(player)
    content_tag(:div, class: "d-flex gap-2") do
        link_to("Show", player, class: "btn btn-info btn-sm") +
        link_to("Edit", edit_player_path(player), class: "btn btn-warning btn-sm") +
        link_to("Delete", player, method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-danger btn-sm")
    end
    end
end
