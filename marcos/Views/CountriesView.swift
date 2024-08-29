//
//  CountriesView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI

struct CountriesView: View {
    
    @ObservedObject var holidaysDAO: HolidaysDAO
    

    @State private var searchTerm = ""
    @State var countryName:String = ""
    var filteredCountry: [Country] {
        guard !searchTerm.isEmpty else { return holidaysDAO.countries }
        return holidaysDAO.countries.filter {$0.country_name.localizedStandardContains(searchTerm)}
    }
    
    
    let columns = Array (repeating: GridItem(.flexible()), count: 3)
    var body: some View {
        VStack {
            HStack {
            
                Spacer()
                                
                    Text("Countries")
                            .font(.largeTitle)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                            .padding(.trailing, -40.0)
                                Spacer()
                                
                                Button(action: {
                                }, label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.red)
                                })
                                .padding()
                            }
                            .padding()
            
            
            NavigationStack{
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(filteredCountry, id: \.self) { count in
                            Button(action: {
                                holidaysDAO.fetchHolydays(country: count.iso3166)
                            }, label: {
                                VStack (spacing: -20){
                                    Text(String(count.flag_unicode))
                                        .font(.system(size: 100))
                                    Text(String(count.country_name))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            })
                        }
                        
                    }
                }
                .padding()
                .searchable(text: $searchTerm, prompt: "Search Country")
            }
            .padding()
            .searchable(text: $countryName)
        }
    }
    
    }

    



    #Preview {
        CountriesView(holidaysDAO: HolidaysDAO())
    }

