
import CoreLocation
import Foundation
import SwiftUI
import CoreLocationUI
import MapKit

class SearchForecast: ObservableObject {    
    
    @State var searchJSON = SearchCity()
    @Published var cityLabel : String = "London"
    @Published var addRess : String = ""
    
    let API_KEY = "YOURAPIKEY"
    
    func fetchWeather(cityName: String) {
        let URLString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(cityName)?key=\(API_KEY)"
        performRequest(with: URLString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            print(url)
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(SearchCity.self, from: weatherData)
            //                let id = decodedData.weather[0].id
            let name = decodedData.address
            
            let weather = WeatherModel(cityName: name)
            return weather
            
        }catch {
            didFailWithError(error: error)
            return nil
        }
    }
    
    func  searchButtonPressed() {
        fetchWeather(cityName: addRess)
    }
    
    func didUpdateWeather(_ SearchForecast: SearchForecast  ,weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

struct WeatherModel {
    let cityName: String
}
