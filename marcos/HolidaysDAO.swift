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
    
    init() {
        
        guard let url = URL(string: "https://calendarific.com/api/v2/holidays?&api_key=x6aXStVO9yKBYS1GWdOip4NUVWVtyhBE&country=CN&year=2024") else {
            print("url invalida");
            return;
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, error in
            guard let data = data, error == nil else {
                print("DADO INVALIDA")
                return;
            }
            
            do {
                let resposta = try JSONDecoder().decode(Resposta.self, from: data)
                DispatchQueue.main.async {
                    self.holidays = resposta.response.holidays
                    for holiday in self.holidays {
                        print(holiday.date.datetime.month)
                        self.holidaysPerMonth[holiday.date.datetime.month - 1].numeroDeFeriados += 1;
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
        

        
    }
}

struct Resposta: Codable, Hashable {
    let response: Response;
}

struct Response: Codable, Hashable {
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



