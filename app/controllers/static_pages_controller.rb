class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = Activity.includes(:user)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
