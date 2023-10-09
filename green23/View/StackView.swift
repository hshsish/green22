
import SwiftUI

struct StackView<Title: View, Content: View>: View {
    
    var titleView: Title
    var contentView: Content
    
    @State var topOffset: CGFloat = 0
    @State var bottomOffset: CGFloat = 0
    
    init(@ViewBuilder titleView: @escaping () -> Title, @ViewBuilder contentView: @escaping() -> Content ){
        
        self.titleView = titleView()
        self.contentView = contentView()
    }
    
    var body: some View {
        VStack(spacing:0) {
            titleView
                .font(.callout)
                .lineLimit(1)
            
                .frame(height: 38)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading)
                .background(.ultraThinMaterial, in: Corner(corner: bottomOffset < 38 ?
                    .allCorners : [.topLeft, .topRight], radius: 12))
                .zIndex(0)
            
            VStack{
                Divider()
                contentView
                    .padding()
                
            }
            .background(.ultraThinMaterial ,in: Corner(corner: [.bottomLeft, .bottomRight], radius: 12))
            .offset(y: topOffset >= 120 ? 0 : -(-topOffset + 120))
            .zIndex(0)
            .clipped()
            .opacity(GETopacity())
            
        }
        .colorScheme(.light)
        .cornerRadius(12)
        .opacity(GETopacity())
        .offset(y: topOffset >= 120 ? 0 : -topOffset + 120)
        .background(
            
            GeometryReader{ proxy -> Color in
                
                let minY = proxy.frame(in: .global).minY
                let maxY = proxy.frame(in: .global).maxY
                
                DispatchQueue.main.async {
                    self.topOffset = minY
                    self.bottomOffset = maxY
                    
                }
                return Color.clear
            }
        )
        .modifier(CornerModifier(bottomOffset: $bottomOffset))
        
    }
    
    func GETopacity() -> CGFloat{
        if bottomOffset < 28 {
            let progress = bottomOffset / 28
            return progress
        }
        return 1
    }
}

struct StackView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CornerModifier: ViewModifier {
    
    @Binding var bottomOffset: CGFloat
    
    func body(content: Content) -> some View {
        if bottomOffset < 38{
            content
        }else{
            content
                .cornerRadius(12)
        }
    }
}
