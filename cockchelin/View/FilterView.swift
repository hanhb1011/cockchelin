//
//  File.swift
//  cockchelin
//
//  Created by 김현수 on 2020/12/14.
//

import SwiftUI



struct Filterview : View{
    
    @ObservedObject var filterViewModel = FilterViewModel()
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
    
    @State var selectedIndex = 0
    @State var temp: String = ""
    
    init(filter: Filter) {
        self.filter = filter
        self._width = State<CGFloat>(initialValue: CGFloat(self.filter.minDegree) * self.totalWidth / 100)
        self._width1 = State<CGFloat>(initialValue: CGFloat(self.filter.maxDegree) * self.totalWidth / 100)
        
        self.temp = filterViewModel.getSelectedIngredientList(index: self.selectedIndex)
    }
    
    
    var body: some View{
        ScrollView{
        VStack{
            HStack {
                Text("재료 선택")
                    .bold()
                    .font(.system(size: 25, weight: .bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                Spacer()
            }
            
            HStack {
                VStack {
                    ForEach(self.filterViewModel.classificationList) { classification in
                        HStack {
                            Button(action: {
                                self.selectedIndex = classification.index
                                self.temp = self.filterViewModel.getSelectedIngredientList(index: classification.index)
                                
                            }, label: {
                                Text(classification.name)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255, opacity: 100))
                            })
                            .padding()
                        }
                        .frame(width: 80)
                        .background(self.selectedIndex == classification.index ? Color(red: 255/255, green: 150/255, blue: 168/255, opacity: 100) : Color(red: 247/255, green: 247/255, blue: 251/255, opacity: 100))
                    }
                    
                    
                }
                .padding(.vertical)
                .frame(width: 80)
                .background(Color(red: 247/255, green: 247/255, blue: 251/255, opacity: 100)
                .edgesIgnoringSafeArea(.all))
                
                
                Text(self.temp)
                    .frame(height: 250, alignment: .topLeading)
                    .font(.system(size: 10, weight: .bold))
                
                Spacer()
                
            }
            
            
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
            
            
            
            VStack {
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
