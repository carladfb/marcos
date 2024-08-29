//
//  ButtonCountries.swift
//  marcos
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 28/08/24.
//

import SwiftUI

struct ButtonCountries: View {
    @State private var isSheetPresented = false
    @ObservedObject var holidaysDAO: HolidaysDAO;
    
    var body: some View {
        Button(action: {
            isSheetPresented.toggle()
        }) {
            HStack(spacing: 4) {
                Text(holidaysDAO.actualCountry?.flag_unicode ?? "🏳️")
                    .frame(width: 20, height: 20)
                Text(holidaysDAO.actualCountry?.iso3166 ?? "BR")
                    .foregroundColor(.black)
                Image(systemName: "chevron.down")
                    .foregroundColor(.vermeiTchan)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .background(Color.white)
            .cornerRadius(10)
        }
        .sheet(isPresented: $isSheetPresented) {
            CountriesView(holidaysDAO: holidaysDAO)
        }
    }
}

#Preview {
    ButtonCountries(holidaysDAO: HolidaysDAO())
}
