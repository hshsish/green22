
import CoreLocation
import Foundation
import SwiftUI
import CoreLocationUI
import MapKit

struct WeatherDataView: View {
    
    @State var manager = CLLocationManager()
    @State var managerDelegate = LocationManager()
    @State var offset: CGFloat = 0
    @State var weatherJSON =  WeatherResponse()
    @State var forecastJSON =  dailyforecast()
    @State private var locationRetrieved = true
    @State var coordinates : String = ""
    private let locationManager = LocationManager()
    
    var body: some View {
        VStack{
            HStack(spacing:8) {
                
                
                StackView {
                    
                    Label {
                        
                        Text("VISIBILITY")
                        
                        
                    } icon: {
                        
                        Image(systemName: "eye")
                        
                    }
                    
                } contentView: {
                    
                    VStack(alignment:.leading, spacing: 10){
                        
                        Text("\((self.weatherJSON.list.first?.visibility)?.roundDouble(pointnum: 0) ?? "") m")
                            .font(.title.bold())
                        
                        Text("\((self.weatherJSON.list.first?.visibility)?.visibilityText() ?? "" )")
                            .font(.body)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                
                StackView {
                    
                    Label {
                        
                        Text("UV-index")
                        
                        
                    } icon: {
                        
                        Image(systemName: "sun.min")
                        
                    }
                    
                } contentView: {
                    
                    VStack(alignment:.leading, spacing: 10){
                        
                        Text("\((self.forecastJSON.days.first?.uvindex)?.roundDouble(pointnum: 0) ?? "")")
                            .font(.title.bold())
                        
                        Text("\((self.forecastJSON.days.first?.uvindex)?.uvcalcl() ?? "")")
                            .font(.body)
                        
                    }
                    
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                
                
                
            }
            
            HStack(spacing:8) {
                
                StackView {
                    
                    Label {
                        
                        Text("WIND")
                        
                    } icon: {
                        
                        Image(systemName: "wind")
                        
                    }
                    
                } contentView: {
                    
                    VStack(alignment:.leading, spacing: 10){
                        
                        Text("\((self.weatherJSON.list.first?.wind.deg)?.toCardinalDirection() ?? "")")
                            .font(.title.bold())
                        
                        Text("Wind gusts up to  \((self.weatherJSON.list.first?.wind.gust)?.roundDouble(pointnum: 0) ?? "") m/s")
                            .font(.body)
                        //MARK:RWP
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                
                
                StackView {
                    
                    Label {
                        
                        Text("PRESSURE")
                        
                    } icon: {
                        
                        Image(systemName: "gauge")
                        
                    }
                    
                } contentView: {
                    VStack(alignment:.leading, spacing: 10){
                        Text("\((self.weatherJSON.list.first?.main.pressure)?.roundDouble(pointnum: 0) ?? "") hPa")
                            .font(.title.bold())
                        
                        Text("  ")
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
            }
            
            HStack(spacing:8) {
                
                StackView {
                    
                    Label {
                        
                        Text("FEELS LIKE")
                        
                    } icon: {
                        
                        Image(systemName: "thermometer")
                    }
                    
                } contentView: {
                    
                    VStack(alignment:.leading, spacing: 10){
                        
                        Text("\((self.weatherJSON.list.first?.main.feels_like)?.convertK2C.roundDouble(pointnum: 0) ?? "")°C")
                            .font(.title.bold())
                        
                        Text("  ")
                            .font(.body)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                
                StackView {
                    
                    Label {
                        
                        Text("HUMIDITY")
                        
                    } icon: {
                        Image(systemName: "humidity")
                    }
                } contentView: {
                    
                    
                    VStack(alignment:.leading, spacing: 10){
                        
                        Text("\((self.weatherJSON.list.first?.main.humidity)?.roundDouble(pointnum: 0) ?? "") %")
                            .font(.title.bold())
                        
                        Text("Precipitation probability \((self.weatherJSON.list.first?.pop)?.roundDouble(pointnum: 0) ?? "") %")
                            .font(.body)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
            }
            StackView{
                Label{
                    Text("15 DAYS FORECAST")
                } icon: {
                    
                    Image(systemName: "calendar")
                }
            } contentView: {
                VStack(alignment: .leading, spacing: 10){
                    ForEach(forecastJSON.days, id: \.self) { days in
                        
                        HStack(spacing:10){
                            
                            Text("\(days.datetime.convertToDate().dayWord())")
                                .font(.title3.bold())
                                .frame(width: 110, alignment: .center)
                            
                            
                            Image(systemName: "\(days.icon.getIcon())")
                                .font(.title3.bold())
                                .frame(width: 30, alignment: .center)
                            
                            Text("\(days.tempmin.convertF2C.roundDouble(pointnum: 0))")
                                .font(.title3.bold())
                                .frame(width: 40, alignment: .center)
                            
                            ZStack(alignment: .leading){
                                
                                GeometryReader { proxy in
                                    Capsule()
                                        .fill(.tertiary)
                                    
                                    Capsule()
                                        .fill(.linearGradient(colors: [.blue, .yellow], startPoint: .leading, endPoint: .trailing))
                                        .frame(width: (days.temp/140) * proxy.size.width)
                                    
                                }
                            }
                            .frame(height: 4)
                            
                            Text("\(days.tempmax.convertF2C.roundDouble(pointnum: 0))")
                                .font(.title3.bold())
                                .frame(width: 40, alignment: .center)
                            
                        }
                    }
                }
                
            }
        }
        .foregroundStyle(.white)
        .onAppear() {
            self.manager.delegate = self.managerDelegate
            self.manager.requestAlwaysAuthorization()
            
            if locationRetrieved {
                WeatherManager().getWeatherJSON { (data) in
                    self.weatherJSON = data
                }
                DailyForecast().getForecastJSON { (data) in
                    self.forecastJSON = data
                }
            }
            WeatherManager().determineLocation()
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDataView()
    }
}
