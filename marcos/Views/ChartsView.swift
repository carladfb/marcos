//
//  ChartsView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI
import Charts

struct ChartsView: View {
    
    @State var vetor: [GraficoTeste] = [
        GraficoTeste(algo: "coisa1" , porcentagem: 10),
        GraficoTeste(algo: "coisa2" , porcentagem: 13),
        GraficoTeste(algo: "coisa3" , porcentagem: 16),
        GraficoTeste(algo: "coisa4" , porcentagem: 18),
        GraficoTeste(algo: "coisa5" , porcentagem: 5),
        GraficoTeste(algo: "coisa6" , porcentagem: 5),
        GraficoTeste(algo: "coisa7" , porcentagem: 15),
        GraficoTeste(algo: "coisa8" , porcentagem: 5),
        GraficoTeste(algo: "coisa9" , porcentagem: 5),
        GraficoTeste(algo: "coisa10" , porcentagem: 5),
        GraficoTeste(algo: "coisa11" , porcentagem: 5),
        GraficoTeste(algo: "coisa12" , porcentagem: 25)
        
    ];
    
    var body: some View {
        GeometryReader {
            geometry in
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        Chart {
                            ForEach (vetor) {
                                dado in
                                BarMark(x: .value("coisa1", dado.algo),
                                        y: .value("coisa2", dado.porcentagem))
                                .annotation {
                                    Text(String(Int(dado.porcentagem))).font(.caption2)
                                }
                            }
                            
                            
                        }
                        .padding(.vertical)
                        .foregroundColor(.pink)
                        
                    }.frame(width: geometry.size.width * 2, height: 300)
                    
                }
                
                
            }
        }
    }
    
}
    
    struct GraficoTeste: Identifiable {
        let id = UUID();
        let algo: String;
        let porcentagem: Double;
    }

#Preview {
    ChartsView()
}
