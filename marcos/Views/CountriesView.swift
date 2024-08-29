//
//  CountriesView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI

struct CountriesView: View {
    
    @ObservedObject var holidaysDAO: HolidaysDAO
    
//    @State private var searchCountry: [Country] = []
//    @State private var searchTerm = ""
    @State var countryName:String = ""
    
    
/*
    var filteredCountry: [Country] {
     //   guard !searchTerm.isEmpty else {return searchCountry}
     //   return searchCountry.filter{ $0.country_name.localizedCaseInsensitiveContains(searchTerm) }
        if searchTerm.isEmpty {
            return HolidaysDAO.country
                } else {
                    return names.filter { $0.contains(searchText) }
                }
        
    }
    */
    
    let columns = Array (repeating: GridItem(.flexible()), count: 3)
    var body: some View {
        VStack {
            HStack {


                    Button(action: {
                        
                    }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)


                })
                .padding(.leading, -100)
                
                Text("Countries")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
                
            }
            
            NavigationStack{
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(holidaysDAO.countries, id: \.self) { count in
                            Button(action: {
                                holidaysDAO.fetchHolydays(country: count.iso3166)
                            }, label: {
                                VStack (spacing: -20){
                                    Text(String(count.flag_unicode))
                                        .font(.system(size: 100))
                                    Text(String(count.country_name))
                                        .foregroundColor(.black)
                                }
                            })
                        }
                        
                    }
                }
                .padding()
                //.searchable(text: $searchTerm, prompt: "Search Country")
            }
            .searchable(text: $countryName)
        }
    }
    
    }

    



    #Preview {
        CountriesView(holidaysDAO: HolidaysDAO())
    }

