class BottomsController < ApplicationController
  def index
    matching_bottoms = Bottom.all

    @list_of_bottoms = matching_bottoms.order({ :created_at => :desc })

    render({ :template => "bottoms/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_bottoms = Bottom.where({ :id => the_id })

    @the_bottom = matching_bottoms.at(0)

    render({ :template => "bottoms/show.html.erb" })
  end

  def create
    the_bottom = Bottom.new
    the_bottom.temperature_minimum = params.fetch("query_temperature_minimum")
    the_bottom.temperature_maximum = params.fetch("query_temperature_maximum")
    the_bottom.image = params.fetch("query_image")
    the_bottom.user_id = params.fetch("query_user_id")

    if the_bottom.valid?
      the_bottom.save
      redirect_to("/bottoms", { :notice => "Bottom created successfully." })
    else
      redirect_to("/bottoms", { :alert => the_bottom.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bottom = Bottom.where({ :id => the_id }).at(0)

    the_bottom.temperature_minimum = params.fetch("query_temperature_minimum")
    the_bottom.temperature_maximum = params.fetch("query_temperature_maximum")
    the_bottom.image = params.fetch("query_image")
    the_bottom.user_id = params.fetch("query_user_id")

    if the_bottom.valid?
      the_bottom.save
      redirect_to("/bottoms/#{the_bottom.id}", { :notice => "Bottom updated successfully."} )
    else
      redirect_to("/bottoms/#{the_bottom.id}", { :alert => the_bottom.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_bottom = Bottom.where({ :id => the_id }).at(0)

    the_bottom.destroy

    redirect_to("/bottoms", { :notice => "Bottom deleted successfully."} )
  end
end
