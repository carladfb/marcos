//
//  HolidaysDAO.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 27/08/24.
//

import Foundation
import SwiftUI

class HolidaysDAO: ObservableObject {
    
    @Published var isLoading = true;
    @Published var holidayWithStyle: [HolidayWithStyle] = []
    @Published var actualHoliday: HolidayWithStyle?
    @Published var actualCountry: Country?
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
    @Published var recentsHolidays: [HolidayWithStyle?] = []
    @Published var pastHolidays: [HolidayWithStyle] = []
    @Published var progressHolidays: CGFloat = 0;
    
    let today = Foundation.Date()
    let formatter = DateFormatter()
    var holidaysStyles: [HolidayStyle] = [];
    
    
    
    
    init() {
        
        let currentCountry = "BR"
        fetchDays(currentCountry: currentCountry)
    }
    
    func fetchDays(currentCountry: String) {
        
        guard let url = URL(string: "https://calendarific.com/api/v2/countries?&api_key=J4E4kyWV5uFvXFYar4aA22FaFtcrGhbe") else {
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
                    self.fetchHolydays(country: currentCountry)
                    
                }
            } catch {
                print(error)
            }
        }
        taskGetCountries.resume()
        
    }
    
    func fetchHolydays(country: String) {
        
        isLoading = true;
        formatter.dateFormat = "yyyy"
        let dateString = formatter.string(from: today)
        self.actualCountry = nil;
        
        for countryI in self.countries {
            if (country == countryI.iso3166.uppercased()) {
                self.actualCountry = countryI
                break;
            }
        }
        
        holidaysStyles = [
            HolidayStyle(["worldwide"], Color.azulzinclaro, "🌎"),
            HolidayStyle(["national", "local"], Color.verdinClaro, self.actualCountry?.flag_unicode ?? "🚩"),
            HolidayStyle(["observance", "season"], Color.vermeiTchan, "🤍"),
            HolidayStyle(["christian", "orthodox", "hinduis", "hebrew", "muslim"], Color.amareloClarin, "👏")
        ]
        
        
        guard let url = URL(string: "https://calendarific.com/api/v2/holidays?&api_key=J4E4kyWV5uFvXFYar4aA22FaFtcrGhbe&country=\(country)&year=\(dateString)") else {
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
                    
                    self.holidayWithStyle.removeAll()
                    for holiday in resposta.response.holidays {
                        self.holidayWithStyle.append(HolidayWithStyle(holiday: holiday,
                                                                      holidayStyle: self.getHolidaySytle(holidayName: holiday.type[0])))
                    }
                    
                    for i in 0..<self.holidaysPerMonth.count {
                        self.holidaysPerMonth[i].numeroDeFeriados = 0;
                    }
                    for holiday in resposta.response.holidays {
                        self.holidaysPerMonth[holiday.date.datetime.month - 1].numeroDeFeriados += 1;
                    }
                    
                    self.formatter.dateFormat = "MM/dd"
                    let dateString = self.formatter.string(from: self.today)
                    
                    
                    self.recentsHolidays.removeAll()
                    self.pastHolidays.removeAll()
                    self.actualHoliday = nil
                    
                    for holiday in self.holidayWithStyle {
                        
                        if (((holiday.holiday.date.datetime.month > 9 ? "" : "0") +
                             String(holiday.holiday.date.datetime.month) + "/" +
                             (holiday.holiday.date.datetime.day > 9 ? "" : "0") +
                             String(holiday.holiday.date.datetime.day)) == dateString) {
                            self.actualHoliday = holiday;
                            
                            break;
                        }
                    }
                    
                    self.formatter.dateFormat = "MM"
                    let monthInt = Int(self.formatter.string(from: self.today))
                    self.formatter.dateFormat = "dd"
                    let dayInt = Int(self.formatter.string(from: self.today))
                    for holiday in self.holidayWithStyle {
                        
                        print("mes atual = ", monthInt, " dia atual = ", dayInt, " dia feriado ", holiday.holiday.date.datetime.day, " mes feriado ",
                              holiday.holiday.date.datetime.month, " resultado ", (Int(holiday.holiday.date.datetime.month) > monthInt! ||
                                                                                   (Int(holiday.holiday.date.datetime.month) == monthInt! && Int(holiday.holiday.date.datetime.day) >= dayInt!)))
                        
                        if (Int(holiday.holiday.date.datetime.month) > monthInt! ||
                            (Int(holiday.holiday.date.datetime.month) == monthInt! && Int(holiday.holiday.date.datetime.day) >= dayInt!)) {
                            self.pastHolidays.append(holiday)
                        } else {
                            
                            self.recentsHolidays.append(holiday)
                        }
                        
                    }
                    
                    self.progressHolidays = CGFloat((self.recentsHolidays.count / self.holidayWithStyle.count) * 100)
                    self.isLoading = false;
                }
            } catch {
                print(error)
            }
        }
        taskGetHolidays.resume()
        
        
    }
    
    func getHolidaySytle(holidayName: String) -> HolidayStyle {
        
        for holidayStyle in holidaysStyles {
            for name in holidayStyle.nomes {
                if (holidayName.lowercased().contains(name.lowercased())) {
                    return holidayStyle;
                }
            }
        }
        
        return HolidayStyle(["national", "local"], Color.verdinClaro, actualCountry!.flag_unicode);
        
        
    }
    
    
}




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









