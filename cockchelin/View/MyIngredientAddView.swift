//
//  MyIngredientAddView.swift
//  cockchelin
//
//  Created by 한효병 on 2021/11/02.
//

import SwiftUI

struct MyIngredientAddView: View {
    @ObservedObject var myIngredientAddViewModel: MyIngredientAddViewModel = MyIngredientAddViewModel()
    
    @State var selectedTotal = true
    @State var selectedClassification: Int = -1
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack {
                HStack {
                    Text("가지고 계신 재료를 선택해주세요!\n마이페이지에서 가진 재료로 만들 수 있는 칵테일을 추천해드립니다.")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 110/255, green: 110/255, blue: 110/255, opacity: 100))
                    Spacer()
                }
                .padding(.vertical, 8)
                
                Divider()
                
                VStack {
                    HStack {
                        Button(action: {
                            selectedTotal = true
                            selectedClassification = -1
                        }, label: {
                            Text("전체")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(self.selectedTotal == true ? Color.selectedButtonColor : Color(red: 80/255, green: 80/255, blue: 80/255, opacity: 100))
                        })
                        Spacer()
                        
                        ForEach(self.myIngredientAddViewModel.classificationList) { classification in
                            HStack {
                                Button(action: {
                                    selectedClassification = classification.index
                                    selectedTotal = false
                                    
                                }, label: {
                                    Text(classification.name)
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(selectedClassification == classification.index ? Color.selectedButtonColor : Color(red: 80/255, green: 80/255, blue: 80/255, opacity: 100))
                                })
                            }
                            
                            if (classification.index != self.myIngredientAddViewModel.classificationList.count - 1) {
                                Spacer()
                            }
                        }
                        
                    }
                    .padding(.vertical, 5)
                    
                    VStack {
                        ForEach(myIngredientAddViewModel.classificationList) { classification in
                            ForEach(classification.ingredientSearchItems) { searchItem in
                                if (selectedTotal == true || selectedClassification == classification.index) {
                                    
                                    if (searchItem.ingredientName != "물" && searchItem.ingredientName != "으깬 얼음") {
                                        HStack {
                                            Text(searchItem.ingredientName)
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                            
                                            Spacer()
                                            
                                            Image(systemName: searchItem.selected ? "checkmark.circle.fill" : "checkmark.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25, height: 25, alignment: .center)
                                                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                                                .padding(.horizontal, 5)
                                            
                                        }
                                        .padding(.vertical, 2)
                                        .onTapGesture {
                                            myIngredientAddViewModel.toggleSelectedVariable(id: searchItem.id, classificationIdx: classification.index)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text("가진 재료 입력"))
        .padding(.horizontal, 25)
        .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
        
    }
}

struct MyIngredientAddView_Previews: PreviewProvider {
    static var previews: some View {
        MyIngredientAddView()
    }
}
