class PagesController < MarketingController

  def index
    quote1 = Quote.new
    quote1.phrase = "\"When it is obvious that the goals cannot be reached, don't adjust the goals, adjust the action steps.\""
    quote1.author = "Confucius"

    quote2 = Quote.new
    quote2.phrase = "\"The doer alone learneth.\""
    quote2.author = "Friedrich Nietzsche"

    quote3 = Quote.new
    quote3.phrase = "\"Autumn is a second spring when every leaf is a flower.\""
    quote3.author = "Albert Camus"

    @quotes = [quote1, quote2, quote3]

  end

end
