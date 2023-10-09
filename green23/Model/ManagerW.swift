
import SwiftUI
import Foundation
import CoreLocation
import CoreLocationUI
import MapKit

struct WeatherManager{
    
    @State var locationManager = LocationManager()
    @State var manager = CLLocationManager()
    @State var coordinates : String = ""
    @State var weatherJSON = WeatherResponse()
    @State private var locationRetrieved = true
    
    private let API_KEY = "YOURAPIKEY"
    
    func determineLocation() {
        
        guard let location = locationManager.getCurrentLocation() else {
            
            locationRetrieved = false
            return
        }
        
        let latitude = location.latitude
        let longitude = location.longitude
        
        coordinates = "\(latitude), \(longitude)"
        
        locationRetrieved = true
    }
   
    func getWeatherJSON(completion: @escaping (WeatherResponse) -> ()) {
  
        guard let coordinates = locationManager.getCurrentLocation() else { return }
        
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&exclude=daily&appid=\(API_KEY)") else { fatalError("missing url") }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
             let weatherJSON = try! JSONDecoder().decode(WeatherResponse.self, from: data!)
            DispatchQueue.main.async {
                completion(weatherJSON)
            }
        }
        .resume()
    }
}
