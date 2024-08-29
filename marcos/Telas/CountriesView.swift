//
//  CountriesView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI

struct CountriesView: View {
    
    @ObservedObject var holidaysDAO: HolidaysDAO
    @Environment(\.dismiss) var dismiss // Para fechar a view
    @State private var searchTerm = ""
    @State var countryName: String = ""
    
    var filteredCountry: [Country] {
        guard !searchTerm.isEmpty else { return holidaysDAO.countries }
        return holidaysDAO.countries.filter { $0.country_name.localizedStandardContains(searchTerm) }
    }
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        
        VStack {
            
            Capsule()
                .fill(Color.vermeiTchan)
                .frame(width: 90, height: 7)
                .padding(.top, 10)
            
            ZStack (alignment: .trailing) {
                HStack {
                    Text("Countries")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                .padding(.top, 35)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                
                
                
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.red)
                })
                .padding(.trailing)
            }
            
            SearchBar(text: $searchTerm, placeholder: "Search Country")
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredCountry, id: \.self) { count in
                        Button(action: {
                            holidaysDAO.fetchHolydays(country: count.iso3166)
                            dismiss()
                        }, label: {
                            VStack(spacing: -20) {
                                Text(String(count.flag_unicode))
                                    .font(.system(size: 100))
                                Text(String(count.country_name))
                                    .foregroundColor(.black)
                                    .lineLimit(0)
                                
                                Spacer()
                            }
                        })
                    }
                }
                .padding()
            }
        }
        
    }
}

#Preview {
    CountriesView(holidaysDAO: HolidaysDAO())
}
