file_names = ['TidePoolTwo/settings.plist']

file_names.each do |file_name|
  text = File.read(file_name)
  text = text.gsub("http://tidepool-user-staging.elasticbeanstalk.com", "https://user-service.tidepool.co")
  text = text.gsub("http://tidepool-game-staging.elasticbeanstalk.com", "https://game-service.tidepool.co")
  # text = text.gsub("http://tidepool-user-staging.elasticbeanstalk.com", "https://event-service.tidepool.co")
  text = text.gsub("http://tidepool-challenge-staging.elasticbeanstalk.com", "https://challenge-service.tidepool.co")
  # To merely print the contents of the file, use:
  # puts text

  # To write changes to the file, use:
  File.open(file_name, "w") {|file| file.puts text }
end