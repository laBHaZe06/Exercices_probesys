module TournamentsHelper
    def tournament_form(tournament)
      form_with(model: tournament, url: tournaments_path, method: :post) do |form|
        content_tag(:div, class: "form-group") do
          form.label(:name, "Name tournament") +
          form.text_field(:name, class: "form-control", required: true)
        end +
  
        form.submit("Start tournament", class: "mt-4 btn btn-success")
      end
    end
  end
  