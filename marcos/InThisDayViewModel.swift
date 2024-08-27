//
//  InThisDayViewModel.swift
//  marcos
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 27/08/24.
//

import Foundation
import Combine

class InThisDayViewModel: ObservableObject {
    @Published var currentEvento: Evento?
    private var eventos: [Evento] = []
    private var currentIndex: Int = 0
    
    func fetchEventos() {
        let today = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let dateString = formatter.string(from: today)
        
        guard let url = URL(string: "https://api.wikimedia.org/feed/v1/wikipedia/en/onthisday/events/\(dateString)") else {
            print("URL inválida")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Dados inválidos")
                return
            }
            
            do {
                let resposta = try JSONDecoder().decode(Resposta.self, from: data)
                DispatchQueue.main.async {
                    self.eventos = resposta.events
                    self.currentIndex = 0
                    self.showNextEvento()
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func showNextEvento() {
        guard !eventos.isEmpty else {
            self.currentEvento = nil
            return
        }
        
        if currentIndex < eventos.count {
            self.currentEvento = eventos[currentIndex]
            self.currentIndex = (currentIndex + 1) % eventos.count
        } else {
            self.currentEvento = nil
        }
    }
    
    struct Resposta: Codable, Hashable {
        var events: [Evento]
    }
    
    struct Evento: Codable, Hashable {
        var text: String
        var pages: [Detalhes]
    }
    
    struct Detalhes: Codable, Hashable {
        var extract: String
    }
}
