class MarketingController < ApplicationController

  skip_before_filter :require_login

end
