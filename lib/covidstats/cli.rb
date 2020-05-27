require 'pry'
class Covidstats::CLI 
  def call
    puts "Welcome to the daily corona tracker! This CLI app provides real time data regarding the ongoing coronavirus pandemic and includes information from numerous countries. As the USA has become the hardest hit country with nearly 100,000 deaths as of May 2020, this gem includes additional data on USA cases by states."
    get_all_countries
    world_stats
  end
  
  def get_all_countries
    countries_array = Covidstats::API.get_reports
    Covidstats::Country.create_from_collection(countries_array)
  end
  
  def get_all_continents
    continents_array = Covidstats::Continents.continent_reports
    array = Covidstats::Continents.merge_hash(continents_array)
    Covidstats::Continents.create_from_collection(array)
  end
  
  def ask_for_choices       #asks if there is anything user still wants to do
     puts "Would you like to do anything else? (y/n)"
      input = gets.strip
      if input == "y"
        list_of_actions
      else
        puts "Ok, thanks for using Covidstats today!"
      end
  end
  
  def world_stats
    puts "To begin, would you like to see the world statistics for today? (y/n)"
    input = gets.strip
    if input == "y"
      puts "Here are the World Statistics:"
      Covidstats::Country.get_world_stats
      ask_for_choices
    else
      list_of_actions
    end
  end
  
  def list_of_actions
    prompt = TTY::Prompt.new
    choice = prompt.select("Please select what you would like to do:") do |prompt|
      prompt.choice "stats by country"
      prompt.choice "stats by continent"
      prompt.choice "Top 10 countries with highest cases"
      prompt.choice "Top 10 countries with highest testing rates"
      prompt.choice "Top 10 countries with highest fatality rates"
    end
   country_select if choice == "stats by country"
   continent_select if choice == "stats by continent"
   highest_cases if choice == "Top 10 countries with highest cases"
   testing_rates if choice == "Top 10 countries with highest testing rates"
   fatality_rates if choice == "Top 10 countries with highest fatality rates"
  end
  
  def country_select
    puts "Enter the name of the country you would like to search:"
    input = gets.strip #ADD CONSTRAINTS TO WHAT CAN BE PUT IN HERE
    #select the country where input == country.name
    Covidstats::Country.all.each do |country|
      if country.name == input
        display_stats_country(country)
      end
    end
    ask_for_choices
  end
  
  def continent_select
    get_all_continents
    prompt = TTY::Prompt.new
    choice = prompt.select("Please select which continent:") do |prompt|
      prompt.choice "Asia"
      prompt.choice "South America"
      prompt.choice "North America"
      prompt.choice "Europe"
       prompt.choice "Africa"
      prompt.choice "Australia/Oceania"
    end
    Covidstats::Continents.all.each do |continent|
      if continent.name == choice
        display_stats_continent(continent)
      end
    end
    ask_for_choices
  end
  
  def display_stats_country(country)
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
  
  def display_stats_continent(continent)
    puts "Total Cases: #{continent.total_cases}"
    puts "New Cases: #{continent.new_cases}"
    puts "Total Deaths: #{continent.total_deaths}"
    puts "New Deaths: #{continent.new_deaths}"
    puts "Total Recovered: #{continent.total_recovered}"
    puts "Active Cases: #{continent.active_cases}"
    puts "Total Tests: #{continent.total_tests}"
    puts "Number of Serious/Critical Cases: #{continent.serious_critical}"
  end
  
  def highest_cases
    arr_total_cases = []
    
    Covidstats::Country.all.each {|country| arr_total_cases << country.total_cases}
    top_10_cases = arr_total_cases.sort.reverse[0,10]
    
    
    top_10_cases.each do |total_case|
      Covidstats::Country.all.each do |country|
        if country.total_cases == total_case
          puts "#{country.name}: #{country.total_cases}"
        end
      end
    end
    ask_for_choices
  end
  
  def testing_rates
    arr_test_rates = []
    
    Covidstats::Country.all.each {|country| arr_test_rates << country.tests_per_mil}
    top_10_test_rates = arr_test_rates.sort.reverse[0,10]
    
    
    top_10_test_rates.each do |test_rate|
      Covidstats::Country.all.each do |country|
        if country.tests_per_mil == test_rate
          puts "#{country.name}: #{country.tests_per_mil}"
        end
      end
    end
    ask_for_choices
  end
    
  
  def fatality_rates
    arr_fatal_rates = []
    
    Covidstats::Country.all.each {|country| arr_fatal_rates << country.deaths_per_mil}
    top_10_fatal_rates = arr_fatal_rates.sort.reverse[0,10]
    
    
    top_10_fatal_rates.each do |fatal_rate|  
      Covidstats::Country.all.each do |country|
        if country.deaths_per_mil == fatal_rate
          puts "#{country.name}: #{country.deaths_per_mil}"
        end
      end
    end
    ask_for_choices
  end

  
end