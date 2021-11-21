//
//  MyIngredientAddView.swift
//  cockchelin
//
//  Created by 한효병 on 2021/11/02.
//

import SwiftUI

struct MyIngredientAddView: View {
    var myIngredientAddViewModel: MyIngredientAddViewModel = MyIngredientAddViewModel()
    
    var body: some View {
        
        Text(".")
        /*
         
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
         
         
         */
    }
}

struct MyIngredientAddView_Previews: PreviewProvider {
    static var previews: some View {
        MyIngredientAddView()
    }
}
