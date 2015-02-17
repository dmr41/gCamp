class FaqsController < MarketingController

  def faqpg

    query1 = Faq.new
    query1.question = "What is gCamp?"
    query1.answer = "gCamp is a project management site built entirely in Ruby
                     on Rails."
    query1.slug = "slug1"

    query2 = Faq.new
    query2.question = "Who developed this website?"
    query2.answer = "The site was developed by me, David Rivers, as part of a
    six mont intensive training course to learn Fullstack development.  Every
    line of code was written and refactored by myself."
    query2.slug = "slug2"

    query3 = Faq.new
    query3.question = "What aspects of Rails did you learn in building gCamp?"
    query3.answer = "An incredible amount. Rails is a remarkable beast with
    some amazing capabilities. During the development of gCamp I have learnt
    everything from authentication, authorization, validation and has-many
    database relationships to the fundamentals of Test Driven Development."
    query3.slug = "slug3"

    query4 = Faq.new
    query4.question = "Are there any other things this project has taught you?"
    query4.answer = "Like I implied in the last answer, there are too many to
    count really. We did use the Bootstrap CSS framework which was, in hindsight,
    very convient. I am hand rolling CSS on new projects right now so I
    am really appreciating the speed with which frameworks like Bootstrap and
    Semantic-ui allow for pretty and responsive presentation."
    query4.slug = "slug4"

    query5 = Faq.new
    query5.question = "Is there anything you would do different if you built
    a site like gCamp again?"
    query5.answer = "Tons of things. Since it is my first project in Rails there
    is a lot of room for refactoring and redesign. Though I will say
    I have tried to do heavy refactoring on the business end of the application.
    There is still plenty of room to move a number of functions out of controllers
    and into their corresponding or new models to help DRY up the code. If I get the
    time I will do that. "
    query5.slug = "slug5"

    query6 = Faq.new
    query6.question = "Is there anything else you would like to say about this project?"
    query6.answer = "Only that it was built in 3 months by me.  Before starting
    gSchool I knew literally nothing about Ruby/Rails/HTML. To be able to build
    this in such a short period of time speaks to the quaility of the gSchool
    program. If I did it from scratch again
    I am confident I could build it in 3 weeks..........."
    query6.slug = "slug6"



    @questions = [query1, query2, query3, query4, query5, query6]

  end

end
