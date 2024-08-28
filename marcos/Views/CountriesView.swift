//
//  CountriesView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI

struct CountriesView: View {
    
    @ObservedObject var holidaysDAO: HolidaysDAO
    
    @State var countryName:String = ""
    let columns = Array (repeating: GridItem(.flexible()), count: 3)
    var body: some View {
        VStack {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "chevron.backward")
                    Text("Back")
                })
                .padding(.leading, -100)
                
                Text("Countries")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            }
            
            NavigationStack{
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(holidaysDAO.countries, id: \.self) { count in
                            Button(action: {
                                print(count)
                            }, label: {
                                VStack (spacing: -20){
                                    Text(String(count.flag_unicode))
                                        .font(.system(size: 100))
                                    Text(String(count.country_name))
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                                }
                            })
                            //                            Button("button") {
                            //                                print(count)
                            //                            }
                            //RoundedRectangle(cornerRadius: 10.0)
                            //    .frame(width: 100,height: 100)
                            
                            
                        }
                        
                    }
                    /*            List {
                     LazyVGrid(columns: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Columns@*/[GridItem(.fixed(200))]/*@END_MENU_TOKEN@*/) {
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
                     */
                }
                .padding()
                
                
            }.searchable(text: $countryName)
        }
    }
}
    
    #Preview {
        CountriesView(holidaysDAO: HolidaysDAO())
    }

