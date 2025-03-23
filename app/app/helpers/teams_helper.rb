module TeamsHelper
    def team_form(team)
        content_tag(:div, class: "container mt-4") do
        # Affichage des erreurs
        errors_html = if team.errors.any?
                        content_tag(:div, class: "alert alert-danger") do
                            content_tag(:h4, "There were some errors:") +
                            content_tag(:ul) do
                            team.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe
                            end
                        end
                        else
                        "".html_safe
                        end

        # Formulaire principal
        errors_html +
        form_with(model: team, class: "mt-3") do |form|
            content_tag(:div, class: "mb-3") do
            form.label(:name, class: "form-label") +
            form.text_field(:name, class: "form-control", placeholder: "Enter team name")
            end +

            content_tag(:div, class: "mb-3") do
            form.label(:town, class: "form-label") +
            form.text_field(:town, class: "form-control", placeholder: "Enter team town")
            end +

            content_tag(:div, class: "d-flex gap-2") do
            form.submit(class: "btn btn-success") +
            link_to("Cancel", teams_path, class: "btn btn-secondary")
            end
        end
        end
    end

    def team_actions(team)
        content_tag(:div, class: "d-flex gap-2") do
        link_to("Show", team, class: "btn btn-info btn-sm") +
        link_to("Edit", edit_team_path(team), class: "btn btn-warning btn-sm")
        end
    end
end
