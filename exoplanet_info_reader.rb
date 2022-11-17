require 'open-uri'
require 'json'

JSON_content = open('https://gist.githubusercontent.com/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe/exoplanets').read
arrayContent = JSON.parse(JSON_content)

hottestSunOfPlanetsName = ""
hottestSunTemp = 0
number_of_orphan_planets = 0
groupingObject = Hash.new()

for planet in arrayContent do
    if planet["TypeFlag"] == 3
        number_of_orphan_planets += 1
    end

    if planet["HostStarTempK"].class == Integer && planet["HostStarTempK"] > hottestSunTemp
        hottestSunOfPlanetsName = planet["PlanetIdentifier"]
        hottestSunTemp = planet["HostStarTempK"]
    end

    planetSize = "small"
    if planet["RadiusJpt"].to_f > 2.0
        planetSize = "large"
    elsif planet["RadiusJpt"].to_f > 1.0
        planetSize = "medium"
    end

    discoveryYear = planet["DiscoveryYear"]

    if groupingObject[discoveryYear] == nil
        groupingObject[discoveryYear] = { "small" => 0, "medium" => 0, "large" => 0}
    end

    groupingObject[discoveryYear][planetSize] += 1
end

puts "\norphaned planets"
puts(number_of_orphan_planets)

puts "\nexoplanet with hottest sun"
puts(hottestSunOfPlanetsName)

puts "\ntimeline of planets"
puts(groupingObject)
