
import Foundation
import SwiftUI

struct WeatherResponse: Decodable, Hashable {
    var list : [ResponseBody]
    var city : CityResponse
    
    init() {
        self.city = CityResponse()
        self.list = [ResponseBody()]
    }
    
    struct CityResponse: Decodable, Hashable {
        var id : Double
        var name: String
        var country: String
        var timezone: Double
        var sunrise: Double
        var sunset: Double
        var coord: CoordinateResponse
        
        init() {
            self.id = 0
            self.name = "cityName"
            self.country = ""
            self.timezone = 0
            self.sunrise = 0
            self.sunset = 0
            self.coord = CoordinateResponse()
        }
    }
    
    struct CoordinateResponse: Decodable, Hashable {
        var lat: Double
        var lon: Double
        
        init() {
            self.lat = 0
            self.lon = 0
        }
    }
    
    struct ResponseBody: Decodable, Hashable {
        var weather : [WeatherResponse]
        var clouds : CloudResponse
        var wind : WindRespose
        var main : MainResponse
        var visibility : Double
        var dt_txt: String
        var sys: SysResponse
        var pop : Double
        var dt: Double
        
        init() {
            self.clouds = CloudResponse()
            self.weather = [WeatherResponse()]
            self.wind = WindRespose()
            self.main = MainResponse()
            self.visibility = 0
            self.dt_txt = ""
            self.sys = SysResponse()
            self.pop = 0
            self.dt = 0
        }
    }
    
    struct SysResponse: Decodable, Hashable {
        var pod: String
        
        init() {
            self.pod = ""
        }
    }
    
    struct WeatherResponse: Decodable, Hashable {
        var icon : String
        var id : Double
        var main : String
        var description : String
        
        init() {
            self.icon = ""
            self.id = 0
            self.main = ""
            self.description = ""
        }
    }
    
    struct CloudResponse : Decodable, Hashable {
        var all : Double
        
        init(){
            self.all = 0
        }
    }
    
    struct MainResponse : Decodable, Hashable {
        var temp : Double
        var temp_min : Double
        var temp_max : Double
        var pressure: Double
        var feels_like: Double
        var humidity : Double
        
        init() {
            self.temp = 0
            self.temp_min = 0
            self.temp_max = 0
            self.pressure = 0
            self.feels_like = 0
            self.humidity = 0
        }
    }
    
    struct WindRespose: Decodable, Hashable {
        var speed : Double
        var deg : Double
        var gust : Double
        
        init() {
            self.speed = 0
            self.deg = 0
            self.gust = 0
        }
    }
}

struct dailyforecast: Decodable, Hashable {
    var days : [DaysResponse]
    
    
    init(){
        self.days = [DaysResponse()]
    }
    
    struct DaysResponse: Decodable, Hashable {
        var datetime : String
        var datetimeEpoch : Double
        var dew : Double
        var tempmax : Double
        var uvindex : Double
        var tempmin : Double
        var temp : Double
        var feelslikemax : Double
        var humidity : Double
        var precip : Double
        var windgust : Double
        var windspeed : Double
        var winddir : Double
        var pressure : Double
        var cloudcover : Double
        var visibility : Double
        var solarradiation : Double
        var sunrise : String
        var sunset : String
        var conditions : String
        var description : String
        var icon : String
        var hours : [HoursResponse]
        
        init(){
            self.hours = [HoursResponse()]
            self.icon = ""
            self.description = ""
            self.datetime = ""
            self.datetimeEpoch = 0
            self.dew = 0
            self.tempmax = 0
            self.uvindex = 0
            self.tempmin = 0
            self.temp = 0
            self.feelslikemax = 0
            self.humidity = 0
            self.precip = 0
            self.windgust = 0
            self.windspeed = 0
            self.winddir = 0
            self.pressure  = 0
            self.cloudcover = 0
            self.visibility = 0
            self.solarradiation = 0
            self.sunrise = ""
            self.sunset = ""
            self.conditions = ""
        }
    }
    
    struct HoursResponse : Decodable, Hashable {
        
        var datetime : String
        var datetimeEpoch : Double
        var dew : Double
        var uvindex : Double
        var temp : Double
        var humidity : Double
        var precip : Double
        var windgust : Double
        var windspeed : Double
        var winddir : Double
        var pressure : Double
        var cloudcover : Double
        var visibility : Double
        var solarradiation : Double
        var conditions : String
        var icon : String
        
        init(){
            self.icon = ""
            self.datetime = ""
            self.datetimeEpoch = 0
            self.dew = 0
            self.uvindex = 0
            self.temp = 0
            self.humidity = 0
            self.precip = 0
            self.windgust = 0
            self.windspeed = 0
            self.winddir = 0
            self.pressure  = 0
            self.cloudcover = 0
            self.visibility = 0
            self.solarradiation = 0
            self.conditions = ""
        }
    }
}

struct SearchCity : Decodable, Hashable {
    var address: String
    
    init(){
        self.address = ""
    }
}
