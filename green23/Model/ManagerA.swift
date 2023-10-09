
import Foundation

class Store: ObservableObject {

    @Published var weatherList: [WeatherResponse] = [WeatherResponse]()
    
    func addWeather(_ weather: WeatherResponse) {
        weatherList.append(weather)
    }
    
}
