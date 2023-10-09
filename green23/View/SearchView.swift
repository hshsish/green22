
import SwiftUI

struct SearchView: View {
    
    @State var viewModel = SearchForecast()
    
    var body: some View {
        
        ZStack{
            GeometryReader { proxy in
                Image("skyImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .opacity(1)
                    .background(.white)
            }
            .ignoresSafeArea()
            .blur(radius: 3)
            ScrollView(.vertical,showsIndicators: false) {
                
                VStack(alignment: .center, spacing: 5){
                    
                    TextField("Enter city name", text: $viewModel.addRess)
                        .padding()
                        .frame(height: 70, alignment: .center)
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                    
                    Button(action: {
                        viewModel.searchButtonPressed()
                    }, label: {
                        Text("Search")
                            .padding(10)
                            .background(.ultraThinMaterial)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    })
                    
                }
                .padding([.top, .leading, .trailing], 20.0)
                .foregroundStyle(.white)
                
                List {
                    Text("")
                        .foregroundColor(.primary)
                }
            }
        }
        .colorScheme(.light)
        .onAppear {
            self.viewModel.fetchWeather(cityName: viewModel.cityLabel)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
