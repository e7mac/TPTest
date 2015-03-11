file_names = ['TidePoolTwo/settings.plist']

file_names.each do |file_name|
  text = File.read(file_name)
  text = text.gsub("https://user-service.tidepool.co", "http://tidepool-user-staging.elasticbeanstalk.com")
  text = text.gsub("https://game-service.tidepool.co", "http://tidepool-game-staging.elasticbeanstalk.com")
  # text = text.gsub("https://event-service.tidepool.co", "http://tidepool-user-staging.elasticbeanstalk.com")
  text = text.gsub("https://challenge-service.tidepool.co", "http://tidepool-challenge-staging.elasticbeanstalk.com")
  # To write changes to the file, use:
  File.open(file_name, "w") {|file| file.puts text }
end