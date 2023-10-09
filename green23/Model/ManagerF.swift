
import CoreLocation
import Foundation
import SwiftUI
import CoreLocationUI
import MapKit

struct DailyForecast{
    
    @State var locationManager = LocationManager()
    @State var manager = CLLocationManager()
    @State var coordinates : String = ""
    @State var forecastJSON = dailyforecast()
    @State private var locationRetrieved = true
    

    let API_KEY = "YOURAPIKEY"
    
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
    
    func getForecastJSON(completion: @escaping (dailyforecast) -> ()) {

        guard let coordinates = locationManager.getCurrentLocation() else { return }
        
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        let Location = "\(coordinates.latitude),\(coordinates.longitude)"
        
        guard let url = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(Location)?key=\(API_KEY)") else { fatalError("missing url") }
        
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let forecastJSON = try! JSONDecoder().decode(dailyforecast.self, from: data!)
            DispatchQueue.main.async {
                completion(forecastJSON)
            }
        }
        .resume()
    }
}

