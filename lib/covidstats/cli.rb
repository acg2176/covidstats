class Covidstats::CLI 
  def call
    puts "Welcome to the daily corona tracker! This CLI app provides real time data regarding the ongoing coronavirus pandemic and includes information from numerous countries. As the USA has become the hardest hit country with nearly 100,000 deaths as of May 2020, this gem includes additional data on USA cases by states."
    #A few things you can do on this app
    world_stats
  end
  
  def world_stats
    puts "To begin, would you like to see the world statistics for today? (y/n)"
    input = gets.strip
    
    if input == "y"
      puts "Here are the World Statistics:"
      #call a function from the covidstats class
      Covidstats::Covid.get_world_stats
    else
      list_of_actions
    end
  end
  
  def list_of_actions
    puts "Here are the other things you can do with this gem:"
  end
  
end