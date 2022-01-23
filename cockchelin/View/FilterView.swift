//
//  File.swift
//  cockchelin
//
//  Created by 김현수 on 2020/12/14.
//

import SwiftUI

struct Filterview : View{
    
    @ObservedObject var filterViewModel: FilterViewModel
    @ObservedObject var filter: Filter
    @State var width : CGFloat
    @State var width1 : CGFloat
    let totalWidth: CGFloat = 300
    
    @State var selectedBaseList: [TechniqueType:Bool] = [.build:true, .stir:true, .shake:true, .float: true, .blend:true]
    
    @State var colorFirstRow = [
        ColorFilterItem(colorType: .black, color: Color(Color.myBlack)),
        ColorFilterItem(colorType: .blue, color: Color(Color.myBlue)),
        ColorFilterItem(colorType: .brown, color: Color(Color.myBrown)), // beige and brown merged
        ColorFilterItem(colorType: .green, color: Color(Color.myGreen))]
    @State var colorSecondRow = [
        ColorFilterItem(colorType: .mixed, color: Color(Color.myMixed)),
        ColorFilterItem(colorType: .red, color: Color(Color.myRed)), //red and pink merged
        ColorFilterItem(colorType: .yellow, color: Color(Color.myYellow)),
        ColorFilterItem(colorType: .none, color: Color(Color.myTransparent))] // white, transparent, +lightyellow?
    
    @State var techList = [
        TechItem(tech: .build, techString: RecipeViewModel.getTechniqueKorean(type: .build)),
        TechItem(tech: .stir, techString: RecipeViewModel.getTechniqueKorean(type:.stir)),
        TechItem(tech: .shake, techString: RecipeViewModel.getTechniqueKorean(type: .shake)),
        TechItem(tech: .float, techString: RecipeViewModel.getTechniqueKorean(type: .float)),
        TechItem(tech: .blend, techString: RecipeViewModel.getTechniqueKorean(type: .blend))
    ]
    
    init(filter: Filter) {
        self.filter = filter
        self._width = State<CGFloat>(initialValue: CGFloat(filter.minDegree) * self.totalWidth / 50)
        self._width1 = State<CGFloat>(initialValue: CGFloat(filter.maxDegree) * self.totalWidth / 50)
        self.filterViewModel = FilterViewModel(filter: filter)
    }
    
    var body: some View{
        ScrollView {
            VStack {
                VStack {
                    HStack {
                        Text("색상")
                            .bold()
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        Spacer()
                    }
                    
                    HStack {
                        ForEach(colorFirstRow){ color in
                            ColorItemView(colorFilterItem:color, filter: filter, checked: filter.isSelectedColor(color: color.colorType))
                        }
                    }
                    HStack {
                        ForEach(colorSecondRow){ color in
                            
                            ColorItemView(colorFilterItem:color, filter: filter, checked: filter.isSelectedColor(color: color.colorType))
                        }
                    }
                    
                }
                .padding(.horizontal, 30)
                
                Divider().padding()
                
                VStack {
                    HStack {
                        Text("도수")
                            .bold()
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        
                        Text("\(self.getValue(val: round(50*self.width/self.totalWidth)))-\(self.getValue(val:round(50*self.width1/self.totalWidth)))도")
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    ZStack(alignment:.leading){
                        
                        Rectangle()
                            .fill(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                            .frame(width: self.totalWidth, height:6)
                        
                        Rectangle()
                            .fill(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                            .frame(width: self.width1 - self.width, height: 6)
                            .offset(x: self.width)
                        
                        HStack(spacing: 0){
                            
                            Circle()
                                .fill(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                .frame(width: 18, height: 18)
                                .offset(x: self.width)
                                .gesture(
                                    
                                    DragGesture()
                                        .onChanged({
                                            (value) in
                                            
                                            if value.location.x>=0 && value.location.x<=self.width1{
                                                self.width = value.location.x
                                                self.filter.minDegree = Double(100 * self.width / self.totalWidth)/2
                                            }
                                        })
                                    
                                )
                            
                            Circle()
                                .fill(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                .frame(width: 18, height: 18)
                                .offset(x: self.width1 - self.totalWidth/10)
                                .gesture(
                                    
                                    DragGesture()
                                        .onChanged({
                                            (value) in
                                            
                                            if value.location.x<=self.totalWidth && value.location.x>=self.width{
                                                self.width1 = value.location.x
                                                self.filter.maxDegree = Double(100 * self.width1 / self.totalWidth)/2
                                            }
                                        })
                                    
                                )
                        }
                        
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.horizontal, 30)
                
                Divider().padding()
                
                
                VStack {
                    HStack {
                        Text("조주법")
                            .bold()
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        Spacer()
                    }
                    
                    VStack {
                        ForEach(techList) { tech in
                            HStack {
                                Text(tech.techString)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                
                                Spacer()
                                
                                Image(systemName: filter.selectedTechList[tech.tech]! == true ? "checkmark.circle.fill" : "checkmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                    .padding(.horizontal, 5)
                                
                            }
                            .padding(.vertical, 2)
                            .onTapGesture {
                                filter.selectedTechList[tech.tech]!.toggle()
                            }
                        }
                        
                        
                    }
                    .padding(.top, 2)
                }
                .padding(.horizontal, 30)
                
                Divider().padding()
                
                VStack {
                    HStack {
                        Text("기주")
                            .bold()
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        Spacer()
                    }
                    
                    VStack {
                        ForEach(filter.selectedBaseList) { base in
                            HStack {
                                Text(base.ingredientName)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                
                                Spacer()
                                
                                Image(systemName: base.selected == true ? "checkmark.circle.fill" : "checkmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                    .padding(.horizontal, 5)
                                
                            }
                            .padding(.vertical, 2)
                            .onTapGesture {
                                filter.toggleBaseItem(id: base.id)
                            }
                        }
                        
                        
                    }
                    .padding(.top, 2)
                }
                .padding(.horizontal, 30)
            }
        }
        .navigationBarTitle(Text("필터"))
        .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
        .navigationBarItems(trailing:
                                Button(action: {
            filter.isEnabled.toggle()
        }) {
            if (true == filter.isEnabled) {
                Text("해제")
            }
            else {
                Text("적용")
            }
        }
        )
    }
    func getValue(val: CGFloat)->String{
        return String(format:"%.2f",val)
    }
    
    struct ColorItemView: View{
        var colorFilterItem: ColorFilterItem
        @ObservedObject var filter: Filter
        @State var checked: Bool
        var colorArray: [Color]
        
        init(colorFilterItem: ColorFilterItem, filter: Filter, checked: Bool) {
            self.colorFilterItem = colorFilterItem
            self.filter = filter
            self.checked = checked
            
            if (colorFilterItem.colorType == .mixed) {
                colorArray = [.blue, .green, .red]
            }
            else {
                colorArray = [colorFilterItem.color]
            }
            
        }
        
        var body : some View {
            HStack{
                ZStack{
                    Circle()
                        .strokeBorder(
                            LinearGradient(gradient: Gradient(colors: colorArray), startPoint: .top, endPoint: .bottom),
                            lineWidth: 5
                        )
                        .frame(width: 30, height: 30)
                    
                    if (checked) {
                        LinearGradient(gradient: Gradient(colors: colorArray), startPoint: .top, endPoint: .bottom)
                            .frame(width: 30, height: 30)
                            .mask(Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit))
                    }
                }
            }.padding(.horizontal)
                .contentShape(Rectangle())
                .onTapGesture(perform: {
                    checked.toggle()
                    filter.updateSelectedColor(color: colorFilterItem.colorType, isChecked: checked)
                })
        }
        
    }
}

struct ColorFilterItem : Identifiable {
    var id = UUID().uuidString
    var colorType: LiquidColorType
    var color: Color
    var checked: Bool = true
    
}

struct TechItem : Identifiable {
    var id = UUID()
    var tech: TechniqueType
    var techString: String
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        Filterview(filter: Filter())
    }
}
