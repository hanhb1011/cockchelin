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
    
    @State var colorFirstRow = [
        ColorFilterItem(colorType: .black, color: Color(Color.myBlack)),
        ColorFilterItem(colorType: .blue, color: Color(Color.myBlue)),
        ColorFilterItem(colorType: .brown, color: Color(Color.myBrown)), // beige and brown merged
        ColorFilterItem(colorType: .green, color: Color(Color.myGreen))]
    @State var colorSecondRow = [
        ColorFilterItem(colorType: .mixed, color: Color(Color.myMixed)),
        ColorFilterItem(colorType: .red, color: Color(Color.myRed)), //red and pink merged
        ColorFilterItem(colorType: .yellow, color: Color(Color.myYellow)),
        ColorFilterItem(colorType: .none, color: Color(Color.myTransparent))]
    
    @State var selectedTotal = true
    @State var selectedClassificationList: [Bool] = [false, false, false, false]
    @State var temp: String = ""
    @State var savedClassificaionList: [Bool] = [false, false, false, false]
    
    func clearSelectedClassificationList() {
        savedClassificaionList.removeAll()
        savedClassificaionList = selectedClassificationList.map {$0}
        selectedClassificationList = selectedClassificationList.map {_ in false}
    }
    
    func setSelectedClassificationList() {
        selectedClassificationList = savedClassificaionList.map {$0}
        savedClassificaionList.removeAll()
    }
    
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
                .padding(.bottom, 30)
                
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
                .padding(.bottom, 30)
                
                
                VStack {
                    HStack {
                        Text("재료 선택")
                            .bold()
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    HStack {
                        Text("주어진 재료로 만들 수 있는 칵테일 찾기")
                            .bold()
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(red: 110/255, green: 110/255, blue: 110/255, opacity: 100))
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    VStack {
                        HStack {
                            Button(action: {
                                selectedTotal.toggle()
                                if (selectedTotal == true) {
                                    clearSelectedClassificationList()
                                }
                                else {
                                    setSelectedClassificationList()
                                }
                                
                            }, label: {
                                Text("전체")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(self.selectedTotal == true ? Color.selectedButtonColor : Color(red: 80/255, green: 80/255, blue: 80/255, opacity: 100))
                            })
                            Spacer()
                            
                            ForEach(self.filterViewModel.classificationList) { classification in
                                HStack {
                                    Button(action: {
                                        self.selectedClassificationList[classification.index].toggle()
                                        
                                        if(self.selectedClassificationList[classification.index] == true) {
                                            selectedTotal = false
                                        }
                                        
                                    }, label: {
                                        Text(classification.name)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(self.selectedClassificationList[classification.index] == true ? Color.selectedButtonColor : Color(red: 80/255, green: 80/255, blue: 80/255, opacity: 100))
                                    })
                                }
                                
                                if (classification.index != self.filterViewModel.classificationList.count - 1) {
                                    Spacer()
                                }
                            }
                            
                        }
                        .padding(.vertical, 5)
                        VStack {
                            ForEach(filterViewModel.classificationList) { classification in
                                ForEach(classification.ingredientSearchItems) { searchItem in
                                    if (selectedTotal == true || selectedClassificationList[classification.index] == true) {
                                        
                                        HStack {
                                            Text(searchItem.ingredientName)
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                            
                                            Spacer()
                                            
                                            Image(systemName: searchItem.selected ? "checkmark.circle.fill" : "checkmark.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20, alignment: .center)
                                                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                                .padding(.horizontal, 5)
                                            
                                        }
                                        .padding(.vertical, 2)
                                        .onTapGesture {
                                            filterViewModel.toggleSelectedVariable(id: searchItem.id, classificationIdx: classification.index)
                                            filter.updateIngredients(givenIngredients: getIngredientsFromClassificationList())
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                
            }
        }
        .navigationBarTitle(Text("필터"))
        .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
        .navigationBarItems(trailing:
                                Button(action: {
            filter.isEnabled.toggle()
            filter.printIngredients()
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
        
        var body : some View {
            HStack{
                ZStack{
                    Circle()
                        .stroke(colorFilterItem.color, lineWidth: 5)
                        .frame(width: 25, height: 25)
                    
                    if (checked) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(colorFilterItem.color)
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

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        Filterview(filter: Filter())
    }
}
