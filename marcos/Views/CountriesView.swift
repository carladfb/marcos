//
//  CountriesView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI

struct CountriesView: View {
    
    @State var countryName:String = ""
    
    var body: some View {
        
        NavigationStack{
            List {
                LazyVStack {
                    ForEach(1...10, id: \.self) { count in
                        
                        Button(action: {
                            print(count)
                        }, label: {
                            RoundedRectangle(cornerRadius: 15)
                                .overlay {
                                    Text("botao numero " + String(count)).foregroundColor(.white)
                                }
                                .frame(width: 330, height: 75)
                                
                                
                        })
                        
                   
                    }
                }           
            }
        }.searchable(text: $countryName)
    }
}

#Preview {
    CountriesView()
}
