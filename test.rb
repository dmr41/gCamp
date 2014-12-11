require 'json'
require 'faraday'
require 'pp'

conn = Faraday.new(:url => 'https://www.pivotaltracker.com')

response = conn.get do |req|
          req.url "/services/v5/projects/1183304/stories"
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-TrackerToken'] = 'b7dc2450f93461bf30cd4fdbd850e1f8'
        end

 if response.success?
          response_json = JSON.parse(response.body, symbolize_names: true)
          response_json.each do |pivotal|
            @pivota_project_names = pivotal[:name]
            pivotal_project_id = pivotal[:id]
            @pivotal_project_link = "https://www.pivotaltracker.com/n/projects/#{pivotal_project_id}"
            pp pivotal
          end
        end
