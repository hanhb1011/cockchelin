//
//  ItemView.swift
//  cockchelin
//
//  Created by Hyojin Choi on 2021/01/01.
//

import SwiftUI

struct ItemView: View{
    @Binding var item: Item
    var body: some View{
        HStack(spacing: 15){
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 10){
                Text(item.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Text(item.details)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                HStack(spacing: 15){
                    Text("\(item.price)")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    
                }
            }
        }.padding()
    }
}
