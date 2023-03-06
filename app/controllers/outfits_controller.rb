class OutfitsController < ApplicationController
  def index
    matching_outfits = Outfit.all

    @list_of_outfits = matching_outfits.order({ :created_at => :desc })

    render({ :template => "outfits/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_outfits = Outfit.where({ :id => the_id })

    @the_outfit = matching_outfits.at(0)

    render({ :template => "outfits/show.html.erb" })
  end

  def create
    the_outfit = Outfit.new
    the_outfit.top_id = params.fetch("query_top_id")
    the_outfit.bottom_id = params.fetch("query_bottom_id")
    the_outfit.user_id = params.fetch("query_user_id")

    if the_outfit.valid?
      the_outfit.save
      redirect_to("/outfits", { :notice => "Outfit created successfully." })
    else
      redirect_to("/outfits", { :alert => the_outfit.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_outfit = Outfit.where({ :id => the_id }).at(0)

    the_outfit.top_id = params.fetch("query_top_id")
    the_outfit.bottom_id = params.fetch("query_bottom_id")
    the_outfit.user_id = params.fetch("query_user_id")

    if the_outfit.valid?
      the_outfit.save
      redirect_to("/outfits/#{the_outfit.id}", { :notice => "Outfit updated successfully."} )
    else
      redirect_to("/outfits/#{the_outfit.id}", { :alert => the_outfit.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_outfit = Outfit.where({ :id => the_id }).at(0)

    the_outfit.destroy

    redirect_to("/outfits", { :notice => "Outfit deleted successfully."} )
  end
end
