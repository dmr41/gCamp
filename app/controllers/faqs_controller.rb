class FaqsController < ApplicationController

  def faqpg

    query1 = Faq.new
    query1.question = "Should we explore the mysteries of life?"
    query1.answer = "The most beautiful thing we can experience is the mysterious.
    It is the source of all true art and all science. He to whom this emotion is a stranger,
    who can no longer pause to wonder and stand rapt in awe, is as good as dead: his eyes are closed. - Einstein"
    query1.slug = "slug1"

    query2 = Faq.new
    query2.question = "Is the sky blue?"
    query2.answer = "That depends on the time of day and weather.  But for the most part the sky is blue on Earth."
    query2.slug = "slug2"

    query3 = Faq.new
    query3.question = "How many monkeys are jumping on the bed? "
    query3.answer = "Generaly speaking it is not a good idea to have primates in your house.
    They are not very considerate and will destroy everything.  Opposable thumbs are great and all but
    not so much for the untrained monkey."
    query3.slug = "slug3"

    @questions = [query1, query2, query3]

  end

end
