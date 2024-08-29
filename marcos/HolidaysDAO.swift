//
//  HolidaysDAO.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 27/08/24.
//

import Foundation
import SwiftUI

class HolidaysDAO: ObservableObject {
    
    @Published var holidays: [Holiday] = [];
    @Published var holidayWithStyle: [HolidayWithStyle] = []
    
    @Published var holidaysPerMonth = [
        HolidayChart("Jan"),
        HolidayChart("Feb"),
        HolidayChart("Mar"),
        HolidayChart("Apr"),
        HolidayChart("May"),
        HolidayChart("Jun"),
        HolidayChart("Jul"),
        HolidayChart("Aug"),
        HolidayChart("Sep"),
        HolidayChart("Oct"),
        HolidayChart("Nov"),
        HolidayChart("Dec")
    ];
    @Published var countries: [Country] = [];
    
    init() {
        
        let currentCountry = "BR"
        fetchHolydays(country: currentCountry)
        
    }
    
    func fetchHolydays(country: String) {
        
        guard let url = URL(string: "https://calendarific.com/api/v2/holidays?&api_key=IBhJ1QUdouyN8NqqLsVUSqW8OReU3xxP&country=\(country)&year=2024") else {
            print("url invalida");
            return;
        }
        
        let taskGetHolidays = URLSession.shared.dataTask(with: url) {
            data, _, error in
            guard let data = data, error == nil else {
                print("DADO INVALIDA")
                return;
            }
            
            do {
                let resposta = try JSONDecoder().decode(Resposta.self, from: data)
                DispatchQueue.main.async {
                    
                    
                    for holiday in resposta.response.holidays {
                        self.holidayWithStyle.append(HolidayWithStyle(holiday: holiday,
                                                                      holidayStyle: self.getHolidaySytle(holidayName: holiday.type[0])))
                    }
                    self.holidays = resposta.response.holidays
                    for holiday in self.holidays {
                      //  print(holiday.date.datetime.month)
                        self.holidaysPerMonth[holiday.date.datetime.month - 1].numeroDeFeriados += 1;
                    }
                    
                    for i in self.holidayWithStyle {
                       // print(i)
                    }
                }
            } catch {
                print(error)
            }
        }
        taskGetHolidays.resume()
        
        guard let url = URL(string: "https://calendarific.com/api/v2/countries?&api_key=IBhJ1QUdouyN8NqqLsVUSqW8OReU3xxP") else {
            print("url invalida");
            return;
        }
        
        let taskGetCountries = URLSession.shared.dataTask(with: url) {
            data, _, error in
            guard let data = data, error == nil else {
                print("DADO INVALIDA")
                return;
            }
            
            do {
                let resposta1 = try JSONDecoder().decode(RespostaCountries.self, from: data)
                DispatchQueue.main.async {
                    self.countries = resposta1.response.countries
                    for i in self.countries {
                        print(i)
                    }
                    

                }
            } catch {
                print(error)
            }
        }
        taskGetCountries.resume()
    }
    
    func getHolidaySytle(holidayName: String) -> HolidayStyle {
        
        for holidayStyle in holidaysStyles {
            for name in holidayStyle.nomes {
                    if (holidayName.lowercased().contains(name.lowercased())) {
                    return holidayStyle;
                }
            }
        }
        
        return HolidayStyle(["national", "local"], Color.purple, "👨🏼‍💻");
        
        
    }
}

let holidaysStyles: [HolidayStyle] = [
    HolidayStyle(["national", "local"], Color.verdinClaro, "💘"),
    HolidayStyle(["observance", "season"], Color.red, "🤍"),
    HolidayStyle(["worldwide"], Color.blue, "🌎"),
    HolidayStyle(["christian", "orthodox", "hinduis", "hebrew", "muslim"], Color.yellow, "👏")


]

struct HolidayStyle: Hashable {
    
    init(_ nomes: [String], _ cor: Color, _ emoji: String) {
        self.nomes = nomes
        self.cor = cor
        self.emoji = emoji
    }
    

    let nomes: [String];
    let cor: Color;
    let emoji: String;
    

    
}



struct HolidayWithStyle: Hashable {
    let holiday: Holiday;
    let holidayStyle: HolidayStyle;
}

struct Resposta: Codable, Hashable {
    let response: ResponseHoliday;
}

struct ResponseHoliday: Codable, Hashable {
    let holidays: [Holiday]
}

struct Holiday: Codable, Hashable {
    let name: String
    let description: String
    let type: [String]
    let primary_type: String
    let canonical_url: String
    let date: Date;
}

struct Date: Codable, Hashable {
    let iso: String
    let datetime: Datetime
}

struct Datetime: Codable, Hashable {
    let year: Int;
    let month: Int;
    let day: Int;
}

struct HolidayChart: Identifiable {
    let id = UUID();
    let monthName: String;
    var numeroDeFeriados: Int;
    
    init(_ monthName: String) {
        self.monthName = monthName
        self.numeroDeFeriados = 0;
    }
}



struct RespostaCountries: Codable, Hashable {
    let response: ResponseCountry;
}

struct ResponseCountry: Codable, Hashable {
    let countries: [Country]
}

struct Country: Codable, Hashable {
    let country_name: String;
    let iso3166: String;
    let flag_unicode: String;
    let total_holidays: Int;
    
    enum CodingKeys: String, CodingKey {
        case country_name = "country_name"
        case iso3166 = "iso-3166"
        case flag_unicode = "flag_unicode"
        case total_holidays = "total_holidays"
    }
    
}









