//
//  InThisDayAPIView.swift
//  marcos
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 27/08/24.
//

import SwiftUI

struct InThisDayView: View {
    
    @StateObject private var viewModel = InThisDayViewModel()
    @State private var rotation: Double = 0
    
    var body: some View {
        VStack {
            if let evento = viewModel.currentEvento {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Today in the past")
                            .font(.title3)
                            .padding(.bottom, 5)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.bouncy(duration: 0.5)) {
                                rotation += 360
                                viewModel.showNextEvento()
                            }
                        }, label: {
                            Image("reload2")
                                .font(.title2)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .rotationEffect(.degrees(rotation))
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    DashedLine()
                        .frame(height: 1)
                        .padding(.vertical, 5)
                    
                    
                    ScrollView {
                        Text(evento.pages.first?.extract ?? "")
                            .font(.body)
//                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxHeight: 150)
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
            } else {
                Text("Nenhum evento disponível")
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchEventos()
        }
        .padding(30)
    }
}

struct DashedLine: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
            .foregroundColor(.vermei)
        }
    }
}

#Preview {
    InThisDayView()
}
