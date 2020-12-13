//
//  File.swift
//  cockchelin
//
//  Created by 김현수 on 2020/12/14.
//

import SwiftUI


struct RangeSlider : View{
    
    @State var width : CGFloat = 0
    @State var width1 : CGFloat = 15
    var totalWidth = UIScreen.main.bounds.width-60
    
    var body: some View{
        
        VStack{
            
            Text("Degree")
                .font(.title)
                .fontWeight(.bold)
            
            Text("\(self.getValue(val: 100*self.width/self.totalWidth))-\(self.getValue(val:100*self.width1/self.totalWidth))도")
                .fontWeight(.bold)
                .padding(.top)
                
            ZStack(alignment:.leading){
                
                Rectangle()
                    .fill(Color.black.opacity(0.20))
                    .frame(height:6)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: self.width1 - self.width, height: 6)
                    .offset(x: self.width + 18)
                
                HStack(spacing: 0){
                    
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width)
                        .gesture(
                        
                            DragGesture()
                                .onChanged({
                                    (value) in
                                    
                                    if value.location.x>=0 && value.location.x<=self.width1{
                                    self.width = value.location.x
                                    }
                                })
                            
                        )
                    
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width1)
                        .gesture(
                        
                            DragGesture()
                                .onChanged({
                                    (value) in
                                    
                                    if value.location.x<=self.totalWidth && value.location.x>=self.width{
                                    self.width1 = value.location.x
                                    }
                                })
                            
                        )
                }
                
            }.padding(.top, 25)
            
        }
        .padding()
    }
    
    func getValue(val: CGFloat)->String{
        return String(format:"%.2f",val)
    }
    
}

struct CheckBox : View{
    

    
    @State var filters = [
        
        FilterItem(title: "Most Relevant", checked: false),
        FilterItem(title: "Top Rated", checked: false),
        FilterItem(title: "Lowest Price", checked: false),
        FilterItem(title: "Highest Price", checked: false),
        FilterItem(title: "Most Favourite", checked: false),
        FilterItem(title: "Available Now", checked: false)

        ]
    
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var showFilter = false
    
    var body : some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {

            
            //Filter button
            
            Button(action: {
                withAnimation{showFilter.toggle()}
            }, label: {
                Image(systemName: "slider.vertical.3")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
            })
            .padding(.trailing)
            .padding(.top)
            
            //Filter or Radio Button View
            
            VStack{
                
                Spacer()
                
                VStack(spacing:18){
                    
                    HStack{
                        Text("Search By")
                            .font(.title2)
                            .fontWeight(.heavy  )
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation{showFilter.toggle()}
                        }, label: {
                            Text("Done")
                                .fontWeight(.heavy)
                                
                        })
                        
                    }.padding([.horizontal,.top])
                    .padding(.bottom, 10)
                    
                    ForEach(filters){filter in
                        CardView(filter:filter)
                        
                    }
                }
                .padding(.bottom,10)
                .padding(.bottom,edges?.bottom)
                .padding(.top,10)
                .background(Color.white)
                .offset(y: showFilter ? 0 :UIScreen.main.bounds.height/2)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(0.3).ignoresSafeArea().opacity(showFilter ? 1 : 0))
            .onTapGesture(perform: {
                withAnimation{showFilter.toggle()}
            })
        })
    }
}

struct CardView: View{
    @State var filter: FilterItem
    
    var body : some View{
        
        HStack{
             
            Text(filter.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.black.opacity(0.7))
            Spacer()
            
            ZStack{
                Circle()
                    .stroke(filter.checked ? Color("green") :Color.gray, lineWidth: 1)
                    .frame(width: 25, height: 25)
                
                if filter.checked{
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color("green"))
                }
                
            }
            
        }.padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            filter.checked.toggle()
        })
    }
    
}


struct FilterItem : Identifiable{
    
    var id = UUID().uuidString
    var title: String
    var checked: Bool
    
}
