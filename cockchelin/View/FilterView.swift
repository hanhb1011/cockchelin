//
//  File.swift
//  cockchelin
//
//  Created by 김현수 on 2020/12/14.
//

import SwiftUI



struct Filterview : View{
    
    @State var width : CGFloat = 0
    @State var width1 : CGFloat = 15
    var totalWidth = UIScreen.main.bounds.width-60
    
    @State var filters = [
        
        FilterItem(title: "StemmedLiqueurGlass", checked: false),
        FilterItem(title: "CocktailGlass", checked: false),
        FilterItem(title: "OldFashonedGlass", checked: false),
        FilterItem(title: "HighballGlass", checked: false),
        FilterItem(title: "FootedPilsnerGlass", checked: false)

        ]
    
    @State var showFilter = false
    
    var body: some View{
        
        VStack{
            
            VStack{
                
                HStack{
                    Text("Glass")
                        .font(.title)
                        .fontWeight(.bold  )
                        .foregroundColor(.black)
                    
                    Spacer()
                   
                        Text("Done")
                            .fontWeight(.heavy)
                            
                }.padding([.horizontal,.top])
                .padding(.bottom, 10)
                
                ForEach(filters){filter in
                    CardView(filter:filter)
                    
                }
            }
            .padding(.bottom,10)
            .padding(.top,10)
            .background(Color.white)
            
            HStack{
            Text("Degree")
                .font(.title)
                .fontWeight(.bold)
            
                Spacer()
                
            Text("\(self.getValue(val: 100*self.width/self.totalWidth))-\(self.getValue(val:100*self.width1/self.totalWidth))도")
                .fontWeight(.bold)
                
            }
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

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        Filterview()
    }
}
