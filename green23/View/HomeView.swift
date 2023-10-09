
import CoreLocation
import Foundation
import SwiftUI
import CoreLocationUI
import MapKit

struct Home: View {
    
    @State var changePage = false
    @State var manager = CLLocationManager()
    @State var managerDelegate = LocationManager()
    @State var offset: CGFloat = 0
    @State var weatherJSON =  WeatherResponse()
    @State var forecastJSON =  dailyforecast()
    @State private var locationRetrieved = true
    @State var coordinates : String = ""
    @State var topOffset: CGFloat = 0
    private let locationManager = LocationManager()
    let dateFormatter = DateFormatter()
    
    var topEdge: CGFloat
    
    var body: some View {
        
        ZStack{
            
            GeometryReader { proxy in
                Image("skyImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            .blur(radius: 3)
            
            ScrollView(.vertical,showsIndicators: false) {
                
//                VStack{
//                    
//                    Button(action: {
//                        self.changePage.toggle()
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                        Text("Search city")
//                        
//                        
//                    }
//                    .padding(.trailing, 30)
//                    .padding(.top, 140)
//                    .font(.callout.bold())
//                    .frame(width: UIScreen.main.bounds.width, height: 10, alignment: .trailing)
//                        .foregroundStyle(.white)
//                    .sheet(isPresented: $changePage) {
//                        SearchView()
//                    }
//                    
//                }
//                .offset(y: -offset)
//                .offset(y: offset > 0 ? (offset /  UIScreen.main.bounds.width) * 150 : 0)
//              
          
                
                
                
                VStack(alignment: .center, spacing: 5) {
                  
                    VStack(alignment: .center){
                        
                        Text(self.weatherJSON.city.name)
                
                            .padding(.top, 5)
                            .font(.system(size: 35))
                            .foregroundStyle(.primary)
                        
                        Text("\((self.weatherJSON.list.first?.main.temp ?? 0).convertK2C.roundDouble(pointnum: 0))°C")
                            .font(.system(size: 45))
                            .foregroundStyle(.primary)
                            .opacity(getTitleOpacity())
                        
                        Text("\(self.forecastJSON.days.first?.description ?? "")")
                            .font(.system(size: 20))
                            .foregroundStyle(.primary)
                            .opacity(getTitleOpacity())
                        
                        Text("L: \((self.weatherJSON.list.first?.main.temp_min ?? 0).convertK2C.roundDouble(pointnum: 0)), H: \((self.weatherJSON.list.first?.main.temp_max ?? 0).convertK2C.roundDouble(pointnum: 0))")
                            .font(.system(size: 20))
                            .foregroundStyle(.primary)
                            .padding(.bottom, 15)
                            .opacity(getTitleOpacity())
                        
                    }
                    .offset(y: -offset)
                    .offset(y: offset > 0 ? (offset /  UIScreen.main.bounds.width) * 100 : 0)
                    
                    VStack(spacing: 10){
                        
                        StackView {
                            
                            Label {
                                Text("HOURLY FORECAST")
                            } icon: {
                                Image(systemName: "clock")
                            }
                            
                        } contentView: {
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 19){
                                    ForEach(forecastJSON.days.first?.hours ?? [], id: \.self) { hour in
                                        
                                        VStack(spacing: 15){
                                            Text("\(hour.datetimeEpoch.conver2DateFromUNIX().hours())")
                                                .font(.callout.bold())
                                                .padding(.top, -3)
                                            
                                            Image(systemName: "\(hour.icon.getIcon())")
                                                .font(.title2)
                                                .symbolVariant(.fill)
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.white, .yellow)
                                                .frame(height: 30)
                                            
                                            
                                            Text("\(hour.temp.convertF2C.roundDouble(pointnum: 0))°C")
                                                .font(.callout.bold())
                                        }
                                        .padding(.horizontal, 4)
                                    }
                                }
                            }
                        }
                        WeatherDataView()
                    }
                }
                .foregroundStyle(.white)
                .padding(.top, topEdge)
                .padding([.horizontal, .bottom])
                .overlay(
                    GeometryReader { proxy -> Color in
                        
                        let  minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        return Color.clear
                    }
                )
                
                
            }
        }.onAppear() {
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
    
    func getTitleOpacity() -> CGFloat{
        let titleOffset = -getTitleOffset()
        let progress = titleOffset / 20
        let opacity = 1 - progress
        
        return opacity
    }
    
    func getTitleOffset() -> CGFloat{
        
        if offset < 0{
            
            let progress = -offset / 120
            let newOffset = (progress <= 1.0 ? progress : 1) * 20
            
            return -newOffset
        }
        
        return 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
