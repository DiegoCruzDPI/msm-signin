# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :integer
#  user_id    :integer
#
class Bookmark < ApplicationRecord
  #adding :required => true gives us  a chance to add validations directly on our associations. Is that okay to do for all associations? NO! be 
  #mindful of what the possibilities are with your domain model
  belongs_to :user, :required => true
  belongs_to :movie, :required => true

  # we need to validate the movie for our bookmark so that we are not given Nil when we try to call title in our loop of bookmarked movies
  # validates :movie_id, :precence => true
end
