# == Schema Information
#
# Table name: bottoms
#
#  id                  :integer          not null, primary key
#  image               :string
#  temperature_maximum :integer
#  temperature_minimum :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#
class Bottom < ApplicationRecord
  has_many(:outfits, { :class_name => "Outfit", :foreign_key => "bottom_id", :dependent => :destroy })
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
end
