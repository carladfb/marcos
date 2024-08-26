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
        GraficoTeste(algo: "Jan" , porcentagem: 5),
        GraficoTeste(algo: "coisa2" , porcentagem: 13),
        GraficoTeste(algo: "coisa3" , porcentagem: 16),
        GraficoTeste(algo: "coisa4" , porcentagem: 18),
        GraficoTeste(algo: "coisa5" , porcentagem: 5),
        GraficoTeste(algo: "coisa6" , porcentagem: 5),
        GraficoTeste(algo: "coisa7" , porcentagem: 1),
        GraficoTeste(algo: "coisa8" , porcentagem: 5),
        GraficoTeste(algo: "coisa9" , porcentagem: 5),
        GraficoTeste(algo: "coisa10" , porcentagem: 5),
        GraficoTeste(algo: "coisa11" , porcentagem: 5),
        GraficoTeste(algo: "coisa12" , porcentagem: 15)
        
    ];
    
    var body: some View {
        GeometryReader {
            geometry in
            VStack {
                //  ScrollView(.horizontal) {
                HStack {
                    Chart {
                        ForEach (vetor) {
                            dado in
                            BarMark(x: .value("", dado.algo),
                                    y: .value("", dado.porcentagem))
                            .foregroundStyle(dado.porcentagem < 6 ? .blue : .red)
                            .annotation(position: .top, alignment: .center, spacing: CGFloat(5), content: {
                                Text(String(Int(dado.porcentagem))).font(.caption2)
                            })
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            
                        }
                        
                        
                    }
                    
                    
                    .chartLegend(position: .bottom, alignment: .top, spacing: 16)
                    .chartScrollableAxes(.horizontal)
                    .chartXVisibleDomain(length: 5)
                    .padding(.vertical)
                    .frame(height: 300)
                  
                    
                    
                    
                    
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
