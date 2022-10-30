class BookmarksController < ApplicationController
# this will literally take whatever instance method defined in the argument and then add it before all of the other actions
# (index, create ,ect) so that we do not have to type multiple lines of code!!!
  before_action(:load_current_user)
  
  #we created a load user and added self.load_current_user so that we can call the instance method in all of our actions
  # , making it easier to  have each action associated with a specific user.
  def load_current_user
    @current_user = User.where({ :id => session[:user_id]}).at(0)
  end
  def index
    # we want to just show the users bookmakrs, so we session.fetch the :user_id generated for them through session and assaign the 
    # Bookmarklwhere the :user id that is given
    
    matching_bookmarks = @current_user.bookmarks

    @list_of_bookmarks = matching_bookmarks.order({ :created_at => :desc })

    render({ :template => "bookmarks/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_bookmarks = Bookmark.where({ :id => the_id })

    @the_bookmark = matching_bookmarks.at(0)

    render({ :template => "bookmarks/show.html.erb" })
  end

  def create
    the_bookmark = Bookmark.new
    # we used the migrated code. Now we can manipulate it with the values we need
    the_bookmark.user_id = session.fetch(:user_id)
    the_bookmark.movie_id = params.fetch("query_movie_id")

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks", { :notice => "Bookmark created successfully." })
    else
      redirect_to("/bookmarks", { :alert => the_bookmark.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :id => the_id }).at(0)

    the_bookmark.user_id = params.fetch("query_user_id")
    the_bookmark.movie_id = params.fetch("query_movie_id")

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks/#{the_bookmark.id}", { :notice => "Bookmark updated successfully."} )
    else
      redirect_to("/bookmarks/#{the_bookmark.id}", { :alert => the_bookmark.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :id => the_id }).at(0)

    the_bookmark.destroy

    redirect_to("/bookmarks", { :notice => "Bookmark deleted successfully."} )
  end
end
