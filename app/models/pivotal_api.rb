class PivotalApi

  def initialize
    @connection = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end

  def pivotal_projects(token)
    response = @connection.get do |request|
      request.url "/services/v5/projects"
      request.headers['Content-Type'] = 'application/json'
      request.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def pivotal_stories(token, pivotal_project)
    response = @connection.get do |request|
      request.url "/services/v5/projects/#{pivotal_project}/stories"
      request.headers['Content-Type'] = 'application/json'
      request.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
