class Covidstats::Country
   attr_accessor :total_cases, :new_cases, :total_deaths, :new_deaths, :total_recovered, :active_cases, :total_tests, :population, :continent, :deaths_per_mil, :name, :serious_critical, :tests_per_mil, :total_cases_per_mil
  @@all = [] 

  def initialize(country_hash)
    hash_attr(country_hash)
    save
  end
  
  
  def hash_attr(hash)      #given a hash, returns all the attributes
    hash = hash.each do |key, value| 
      hash[key] = value.gsub(",","").gsub("+","")
      if key != "Continent" && key != "Country"
        hash[key] = hash[key].to_i
      end
    end
    @total_cases = hash["TotalCases"]
    @new_cases = hash["NewCases"]
    @total_deaths = hash["TotalDeaths"]
    @new_deaths = hash["NewDeaths"]
    @total_recovered = hash["TotalRecovered"]
    @active_cases = hash["ActiveCases"]
    @total_tests = hash["TotalTests"]
    @population = hash["Population"]
    @continent = hash["Continent"]
    @deaths_per_mil = hash["Deaths_1M_pop"]
    @name = hash["Country"]
    @serious_critical = hash["Serious_Critical"]
    @tests_per_mil = hash["Tests_1M_Pop"]
    @total_cases_per_mil = hash["TotCases_1M_Pop"]
  end
  
  
  def self.create_from_collection(countries_array)
    countries_array.delete_if { |h| h["Country"] == "World"}
    countries_array.delete_if { |h| h["Country"] == "Total:"}
    countries_array.each do |country|
      self.new(country)
    end     
  end
  
  def self.all
    @@all
  end
  
  def save
    @@all << self
  end
  
    
  
end