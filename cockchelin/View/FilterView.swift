//
//  File.swift
//  cockchelin
//
//  Created by 김현수 on 2020/12/14.
//

import SwiftUI



struct Filterview : View{
    
    var filter: Filter
    @State var width : CGFloat
    @State var width1 : CGFloat
    var totalWidth = UIScreen.main.bounds.width-60
    
    @State var Colors = [
        
        FilterItem(title: "붉은 빛", checked: true),
        FilterItem(title: "푸른 빛", checked: true),
        FilterItem(title: "노란 빛", checked: true),
        FilterItem(title: "다채로운 색상 ", checked: true),
        FilterItem(title: "무색", checked: true)

        ]
    
    @State var showFilter = false
    
    init(filter: Filter) {
        self.filter = filter
        self._width = State<CGFloat>(initialValue: CGFloat(self.filter.minDegree) * self.totalWidth / 100)
        self._width1 = State<CGFloat>(initialValue: CGFloat(self.filter.maxDegree) * self.totalWidth / 100)
    }
    
    
    var body: some View{
        ScrollView{
        VStack{
            //GlassType RadioButton
            VStack{
                
                HStack{
                    Text("색상")
                        .font(.title)
                        .fontWeight(.bold  )
                        .foregroundColor(.black)
                    
                    Spacer()
                   
                        Text("적용")
                            .fontWeight(.heavy)
                            
                }.padding([.horizontal,.top])
                .padding(.bottom, 10)
                
                ForEach(Colors){filter in
                    CardView(filter:filter)
                    
                }
            }
            .padding(.bottom,10)
            .padding(.top,10)
            .background(Color.white)
            
            //Degree RangeSlider
            
            
            
            HStack{
            Text("도수")
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
                                        self.filter.minDegree = Double(100 * self.width / self.totalWidth)
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
                                        self.filter.maxDegree = Double(100 * self.width1 / self.totalWidth)
                                    }
                                })
                            
                        )
                }
            
            }.padding(.top, 25)
            
        }
        .padding()
        }
        .onAppear() {
            width = CGFloat(self.filter.minDegree) * self.totalWidth / 100
            width1 = CGFloat(self.filter.maxDegree) * self.totalWidth / 100
        }
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
                .frame(height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
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
        Filterview(filter: Filter())
    }
}
