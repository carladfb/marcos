//
//  HolidayView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 29/08/24.
//

import SwiftUI

struct HolidayView: View {
    
    let holiday: HolidayWithStyle?;
    let space: Int;
    
    
    
    var body: some View {
        
        Button(action: {
            if let holiday1 = holiday {
                print(holiday1.holiday.description)
                print(holiday1.holiday.canonical_url)
            }
            
        }, label: {
            HStack {
                Text(holiday?.holidayStyle.emoji ?? "😕")
                    .font(.body)
                    .padding(6)
                    .background(
                        Circle()
                            .fill(Color.black)
                            .opacity(0.35)
                    )
                Text(holiday?.holiday.name ?? "Today is a normal day")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .lineLimit(0)
                
                Spacer()
                
                if let _ = holiday{
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.black)
                        .opacity(0.4)
                }
                
            }
            .padding(.vertical, CGFloat(space))
            .padding(.leading, 6)
            .padding(.trailing, 12)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(holiday?.holidayStyle.cor ?? Color.cinzinhaClaro)
            )
        })
        
    }
    
    
}


