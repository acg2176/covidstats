class Covidstats::CLI 
  def call
    puts "Welcome to the daily corona tracker! This CLI app provides real time data regarding the ongoing coronavirus pandemic and includes information from numerous countries. As the USA has become the hardest hit country with nearly 100,000 deaths as of May 2020, this gem includes additional data on USA cases by states."
    world_stats
    continent_select
  end
  
  def ask_for_choices       #asks if there is anything user still wants to do
     puts "Would you like to do anything else? (y/n)"
      input = gets.strip
      if input == "y"
        list_of_actions
      else
        puts "Ok, thanks for using Covidstats for today!"
      end
  end
  
  def world_stats
    puts "To begin, would you like to see the world statistics for today? (y/n)"
    input = gets.strip
    if input == "y"
      puts "Here are the World Statistics:"
      #call a function from the covidstats class
      #Covidstats::Covid.get_world_stats
      world = Covidstats::Country.new("World")
      display_stats(world)
      ask_for_choices
    else
      list_of_actions
    end
  end
  
  def list_of_actions
    prompt = TTY::Prompt.new
    choice = prompt.select("Please select what you would like to do:") do |prompt|
      prompt.choice "stats_by_country"
      prompt.choice "stats_by_continent"
      prompt.choice "top_10_countries_w_highest_cases"
      prompt.choice ""
      #can add more choices
    end
   country_select if choice == "stats_by_country"
   continent_select if choice == "stats_by_continent"
  end
  
  def country_select
    puts "Enter the name of the country you would like to search:"
    input = gets.strip #add some constraints here
    country = Covidstats::Country.new(input) #creates the new instance
    display_stats(country)
    ask_for_choices
  end
  
  def continent_select
    puts "Enter the name of the continent you would like to search:"
    input = gets.strip
    Covidstats::Continents.new(input) #creates the new instance
  end
  
  def display_stats(country)
    #displays all the stats
    puts "Total Cases: #{country.total_cases}"
    puts "New Cases: #{country.new_cases}"
    puts "Total Deaths: #{country.total_deaths}"
    puts "Total Recovered: #{country.total_recovered}"
    puts "Active Cases: #{country.active_cases}"
    puts "Total Tests: #{country.total_tests}"
    puts "Population: #{country.population}"
    puts "Continent: #{country.continent}"
    puts "Deaths per Million: #{country.deaths_per_mil}"
    puts "Number of Serious/Critical Cases: #{country.serious_critical}"
    puts "Tests per Million: #{country.tests_per_mil}"
    puts "Total Cases per Million: #{country.total_cases_per_mil}"
  end
  
end