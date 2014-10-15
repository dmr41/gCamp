class PagesController < ApplicationController

  def index

    @people_quotes = [["Confucius","\"When it is obvious that the goals cannot be reached, don't adjust the goals, adjust the action steps.\""],
               ["Friedrich Nietzsche","\"The doer alone learneth.\""],
              ["Albert Camus","\"Autumn is a second spring when every leaf is a flower.\""]]
  end

end
