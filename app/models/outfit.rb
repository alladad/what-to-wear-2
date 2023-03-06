# == Schema Information
#
# Table name: outfits
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bottom_id  :integer
#  top_id     :integer
#  user_id    :integer
#
class Outfit < ApplicationRecord
  belongs_to(:top, { :required => true, :class_name => "Top", :foreign_key => "top_id", :counter_cache => true })
  belongs_to(:bottom, { :required => true, :class_name => "Bottom", :foreign_key => "bottom_id" })
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
end
