//
//  DaysToView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 29/08/24.
//

import SwiftUI

struct DaysToView: View {
    
    let date: String;
    
    var body: some View {
        Text(date)
            .font(.footnote)
            .padding(.vertical, 6)
            .padding(.horizontal, 5)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(Color.fundinho)
        )
    }

    
}

#Preview {
    DaysToView(date: "08-11")
}
