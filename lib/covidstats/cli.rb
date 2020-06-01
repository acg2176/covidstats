class Covidstats::CLI 
  def call
    puts "Welcome to the daily corona tracker! This CLI app provides real time data regarding the ongoing coronavirus pandemic and includes information from numerous countries and continents.".colorize(:light_green)
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
  
  def ask_for_choices       
    puts "Would you like to do anything else? (y/n)".colorize(:light_green)
    input = gets.strip
    if input == "y"
      list_of_actions
    else
      puts "Ok, thanks for using Covidstats today!".colorize(:light_green)
    end
  end
  
  def world_stats
    puts "To begin, would you like to see the world statistics for today? (y/n)".colorize(:light_green)
    input = gets.strip
    if input == "y"
      puts "Here are the World Statistics:".colorize(:light_green)
      world = Covidstats::API.get_reports[0]
      puts "Total Cases:".colorize(:red) + " #{world["TotalCases"]}".colorize(:yellow)
      puts "New Cases:".colorize(:red) + " #{world["NewCases"]}".colorize(:yellow)  
      puts "Total Deaths:".colorize(:red) + " #{world["TotalDeaths"]}".colorize(:yellow)
      puts "New Deaths:".colorize(:red) + " #{world["NewDeaths"]}".colorize(:yellow)
      puts "TotalRecovered:".colorize(:red) + " #{world["TotalRecovered"]}".colorize(:yellow)
      puts "Active Cases:".colorize(:red) + " #{world["ActiveCases"]}".colorize(:yellow)
      puts "Deaths per Million:".colorize(:red) + " #{world["Deaths_1M_pop"]}".colorize(:yellow)
      puts "Number of Serious/Critical Cases:".colorize(:red) + " #{world["Serious_Critical"]}".colorize(:yellow)
      puts "Total Cases per Million:".colorize(:red) + " #{world["TotCases_1M_Pop"]}".colorize(:yellow)
      ask_for_choices
    else
      list_of_actions
    end
  end
  
  def list_of_actions
    prompt = TTY::Prompt.new
    choice = prompt.select("Please select what you would like to do:".colorize(:light_green)) do |prompt|
      prompt.choice "stats by country"
      prompt.choice "stats by continent"
      prompt.choice "Top 10 countries with highest cases"
      prompt.choice "Top 10 countries with highest testing rates by tests per million"
      prompt.choice "Top 10 countries with highest fatality rates by deaths per million"
    end
   country_select if choice == "stats by country"
   continent_select if choice == "stats by continent"
   highest_cases if choice == "Top 10 countries with highest cases"
   testing_rates if choice == "Top 10 countries with highest testing rates by tests per million"
   fatality_rates if choice == "Top 10 countries with highest fatality rates by deaths per million"
  end
  
  def country_select
    puts "Enter the name of the country you would like to search. Please note that for the country United States, please enter".colorize(:light_green) + " USA".colorize(:yellow) + " for United Kingdom, please enter".colorize(:light_green) + " UK".colorize(:yellow) + " and for South Korea, please enter".colorize(:light_green) + " S. Korea".colorize(:yellow)
    input = gets.strip
    input = input.capitalize if input != "USA" && input != "S. Korea" && input != "UK"
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
    choice = prompt.select("Please select which continent:".colorize(:light_green)) do |prompt|
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
    puts "Total Cases:".colorize(:magenta) + " #{country.total_cases}".colorize(:yellow)
    puts "New Cases:".colorize(:magenta) + " #{country.new_cases}".colorize(:yellow)
    puts "Total Deaths:".colorize(:magenta) + " #{country.total_deaths}".colorize(:yellow)
    puts "Total Recovered:".colorize(:magenta) + " #{country.total_recovered}".colorize(:yellow)
    puts "Active Cases:".colorize(:magenta) + " #{country.active_cases}".colorize(:yellow)
    puts "Total Tests:".colorize(:magenta) + " #{country.total_tests}".colorize(:yellow)
    puts "Population:".colorize(:magenta) + " #{country.population}".colorize(:yellow)
    puts "Continent:".colorize(:magenta) + " #{country.continent}".colorize(:yellow)
    puts "Deaths per Million:".colorize(:magenta) + " #{country.deaths_per_mil}".colorize(:yellow)
    puts "Number of Serious/Critical Cases:".colorize(:magenta) + " #{country.serious_critical}".colorize(:yellow)
    puts "Tests per Million:".colorize(:magenta) + " #{country.tests_per_mil}".colorize(:yellow)
    puts "Total Cases per Million:".colorize(:magenta) + " #{country.total_cases_per_mil}".colorize(:yellow)
  end
  
  def display_stats_continent(continent)
    puts "Total Cases:".colorize(:light_blue) + " #{continent.total_cases}".colorize(:yellow)
    puts "New Cases:".colorize(:light_blue) + " #{continent.new_cases}".colorize(:yellow)
    puts "Total Deaths:".colorize(:light_blue) + " #{continent.total_deaths}".colorize(:yellow)
    puts "New Deaths:".colorize(:light_blue) + " #{continent.new_deaths}".colorize(:yellow)
    puts "Total Recovered:".colorize(:light_blue) + " #{continent.total_recovered}".colorize(:yellow)
    puts "Active Cases:".colorize(:light_blue) + " #{continent.active_cases}".colorize(:yellow)
    puts "Total Tests:".colorize(:light_blue) + " #{continent.total_tests}".colorize(:yellow)
    puts "Number of Serious/Critical Cases:".colorize(:light_blue) + " #{continent.serious_critical}".colorize(:yellow)
  end
  
  def highest_cases
    arr_total_cases = []
    Covidstats::Country.all.each {|country| arr_total_cases << country.total_cases}
    top_10_cases = arr_total_cases.sort.reverse[0,10]
    
    top_10_cases.each do |total_case|
      Covidstats::Country.all.each do |country|
        if country.total_cases == total_case
          puts "#{country.name}:".colorize(:red) + " #{country.total_cases}"
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
          puts "#{country.name}:".colorize(:blue) + " #{country.tests_per_mil}"
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
          puts "#{country.name}:".colorize(:green) + " #{country.deaths_per_mil}".colorize(:yellow)
        end
      end
    end
    ask_for_choices
  end

end