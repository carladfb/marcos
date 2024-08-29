//
//  HolidayButtonView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 29/08/24.
//

import SwiftUI

struct HolidayButtonView: View {
    let holiday: HolidayWithStyle;
    
    var body: some View {
  
            HStack {
                Text(holiday.holidayStyle.emoji)
                    .font(.caption)
                    .padding(3)
                    .background(
                        Circle()
                            .fill(Color.black)
                            .opacity(0.35)
                    )
                Text(holiday.holiday.name)
                    .foregroundColor(.white)
                    .font(.footnote)
                    .lineLimit(0)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
                    .opacity(0.4)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(holiday.holidayStyle.cor)
            )
        
    }
}

