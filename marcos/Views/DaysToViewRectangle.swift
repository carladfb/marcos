//
//  DaysToViewRectangle.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 30/08/24.
//

import SwiftUI

struct DaysToViewRectangle: View {
    let date: String;
    let space: Int;
    
    
    var body: some View {
        Text(date)
            .font(.body)
            .padding(.vertical, CGFloat(space))
            .padding(.horizontal, 5)
            .frame(maxWidth: 120)
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(Color.fundinho)
            )
    }
}


