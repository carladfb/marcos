//
//  DaysToView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 29/08/24.
//

import SwiftUI

struct DaysToView: View {
    
    let date: String;
    let space: Int;
    
    
    var body: some View {
        Text(date)
            .font(.footnote)
            .padding(.vertical, CGFloat(space))
            .padding(.horizontal, 5)
            .frame(maxWidth: 120)
            .background(
                Capsule()
                    .fill(Color.fundinho)
            )
    }
}

