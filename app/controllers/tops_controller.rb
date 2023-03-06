class TopsController < ApplicationController
  def index
    matching_tops = Top.all

    @list_of_tops = matching_tops.order({ :created_at => :desc })

    render({ :template => "tops/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_tops = Top.where({ :id => the_id })

    @the_top = matching_tops.at(0)

    render({ :template => "tops/show.html.erb" })
  end

  def create
    the_top = Top.new
    the_top.temperature_minimum = params.fetch("query_temperature_minimum")
    the_top.temperature_maximum = params.fetch("query_temperature_maximum")
    the_top.image = params.fetch("query_image")
    the_top.user_id = params.fetch("query_user_id")

    if the_top.valid?
      the_top.save
      redirect_to("/tops", { :notice => "Top created successfully." })
    else
      redirect_to("/tops", { :alert => the_top.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_top = Top.where({ :id => the_id }).at(0)

    the_top.temperature_minimum = params.fetch("query_temperature_minimum")
    the_top.temperature_maximum = params.fetch("query_temperature_maximum")
    the_top.image = params.fetch("query_image")
    the_top.user_id = params.fetch("query_user_id")

    if the_top.valid?
      the_top.save
      redirect_to("/tops/#{the_top.id}", { :notice => "Top updated successfully."} )
    else
      redirect_to("/tops/#{the_top.id}", { :alert => the_top.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_top = Top.where({ :id => the_id }).at(0)

    the_top.destroy

    redirect_to("/tops", { :notice => "Top deleted successfully."} )
  end
end
