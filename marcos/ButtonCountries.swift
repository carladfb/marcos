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
                    .frame(width: 26, height: 20)
                    .font(.title)
                Text(holidaysDAO.actualCountry?.iso3166 ?? "BR")
                    .foregroundColor(.black)
                    .font(.title3)
                    .bold()
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
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(40)
        }
    }
}

#Preview {
    ButtonCountries(holidaysDAO: HolidaysDAO())
}
