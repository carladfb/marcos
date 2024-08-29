//
//  HolidayView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 29/08/24.
//

import SwiftUI

struct HolidayView: View {
    
    let holidayName: String;
    let holidaySytle: HolidayStyle;
    
    var body: some View {
        HStack {
            Text(holidaySytle.emoji)
                .font(.footnote)
                .padding(4)
                .background(
                    Circle()
                        .fill(Color.black)
                        .opacity(0.35)
                )
            Text(holidayName)
                .foregroundColor(.white)
                .font(.body)
                .lineLimit(0)
            
            Spacer()
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity)
        .background(
            Capsule()
                .fill(holidaySytle.cor)
        )
    }
}


