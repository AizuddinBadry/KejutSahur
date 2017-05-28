desc "This task is called by the Heroku scheduler add-on"
task :sahur_reminder => :environment do
  response = HTTParty.get("http://www.kejutsahur.com/customerlist")
  phoneArray = []
    response.each do |i|
      @url = "http://www.kejutsahur.com/call"
      @result = HTTParty.post(@url.to_str, 
        :body => { :userPhone => i['phone'],
                 }.to_json,
        :headers => { 'Content-Type' => 'application/json' } )
    end
  end

task :testing => :environment do
   @url = "http://www.kejutsahur.com/call"
      @result = HTTParty.post(@url.to_str, 
        :body => { :userPhone => '+601133602267',
                 }.to_json,
        :headers => { 'Content-Type' => 'application/json' } )
end