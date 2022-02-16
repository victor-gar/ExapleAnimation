//
//  Home.swift
//  AdvancedAnimation
//
//  Created by Victor Garitskyu on 17.01.2022.
//

import SwiftUI

struct Home: View {
    @State var currentIndex: Int = 0
    
    @State var bgOffset: CGFloat = 0
    @State var textColor: Color = .white
    
    @State var animateText: Bool = false
    @State var animateImage: Bool = false
    
    var body: some View {
        VStack{
            let isSmallDevice = getRect().height < 750
            
            Text(foods[currentIndex].itemTitle)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 100, alignment: .top)
                .offset(y:animateText ? 200 : 0)
                .clipped()
                .animation(.easeInOut, value: animateText)
                .padding(.top)
            HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 25){
                Label{
                    Text("1 Hour")
                }icon:{
                    Image(systemName: "flame")
                        .frame(width: 30)
                }
                
                Label{
                    Text("40")
                }icon:{
                    Image(systemName: "bookmark")
                        .frame(width: 30)
                }
                
                Label{
                    Text("Easy")
                }icon:{
                    Image(systemName: "bolt")
                        .frame(width: 30)
                }
                
                Label{
                    Text("Safety")
                }icon:{
                    Image(systemName: "safari")
                        .frame(width: 30)
                }
                
                Label{
                    Text("Healthy")
                }icon:{
                    Image(systemName: "drop")
                        .frame(width: 30)
                }
                
                
                
            }
            .font(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    Image(foods[currentIndex].itemImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .rotationEffect(.init(degrees: animateImage ? 360 : 0))
                        .background(
                        Circle()
                            .trim(from: 0.5, to: 1)
                            .stroke(
                                LinearGradient(colors:[textColor, textColor.opacity(0.1),textColor.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                                ,lineWidth: 0.7
                                                        )
                            .padding(-15)
                            .rotationEffect(.init(degrees: -90))
                                                        )
                        .frame(width: size.width, height: size.width * (isSmallDevice ? 1.5 : 1.8))
                        .frame(maxHeight: .infinity, alignment: .center)
                        .offset(x: 70)
                }
                .frame(height: (getRect().width / 2) * (isSmallDevice ? 1.6 : 2))
            }
            
            Text("Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry's standard.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .lineLimit(3)
                .lineSpacing(8)
                .padding(.vertical)
                .offset(y:animateText ? 200 : 0)
                .clipped()
                .animation(.easeInOut, value: animateText)
            
        }
        .padding()
        .foregroundColor(textColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
        
            GeometryReader{proxy in
                let height = proxy.size.height
                LazyVStack(spacing:0){
                    ForEach(foods.indices, id: \.self){index in
                        if index % 2 == 0{
                            Color("BG")
                                .frame(height:height)
                        }
                        else {
                            Color(.white)
                                .frame(height:height)
                        }
                    }
                }
                .offset(y: bgOffset)
            }
                .ignoresSafeArea()
        )
        .gesture(
        DragGesture()
            .onEnded({ value in
                if animateImage{return}
                
                let translation = value.translation.height
                
                if translation < 0 && -translation > 50 && (currentIndex < (foods.count - 1)){
                    
                   AnimateSlide(moveUp: true)
                
                }
                if translation > 0 && translation > 50 && currentIndex > 0{
                    
                    AnimateSlide(moveUp: false)
                }
                
            })
        
        )
    }

    func AnimateSlide(moveUp: Bool = true){
        
        animateText = true
        
        withAnimation(.easeInOut(duration: 0.2)){
            bgOffset += (moveUp ? -getRect().height : getRect().height)
        }
        
        withAnimation(.interactiveSpring(response: 1.5, dampingFraction: 0.8, blendDuration: 0.8)){
            animateImage = true
        }
      
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
           
        animateText = false
        
        currentIndex = (moveUp ? (currentIndex + 1) : (currentIndex - 1))
            
        withAnimation(.easeInOut){
                
                textColor = (textColor == .black ? .white : .black)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            animateImage = false
        }
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
