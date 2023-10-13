//
//  QuoteView.swift
//  BB Quotes
//
//  Created by David Laczkovits on 09.10.23.
//

import SwiftUI

struct QuoteView: View {
    
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    let show : String
    @State private var showCharacterInfo = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowercased().filter { $0 != " " } )
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack {
                    VStack {
                        Spacer(minLength: 140)
                        
                        switch viewModel.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success(let data):
                            Text("\"\(data.quote.quote)\"")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .cornerRadius(25)
                                .padding(.horizontal)
                                .minimumScaleFactor(0.5)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: data.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }.frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                    .onTapGesture {
                                        showCharacterInfo.toggle()
                                    }
                                    .sheet(isPresented: $showCharacterInfo, content: {
                                        CharacterView(show: show, character: data.character)
                                    })
                                /*Image(.jessepinkman)
                                    .resizable()
                                    .scaledToFill()*/
                                
                                Text(data.character.name)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                            .cornerRadius(80)
                            
                        case .failed(_):
                            EmptyView()
                        }
                        Spacer()
                }
                    Button {
                        Task {
                            await viewModel.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("\(show.lowerNoSpaces)button"))
                            .cornerRadius(7)
                            .shadow(color: Color("\(show.lowerNoSpaces)shadow"),radius: 2)
                    }
                    
                    Spacer(minLength: 180)
                }
                .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .onAppear {
            Task {
                await viewModel.getData(for: show)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: Constants.bcsName)
//        .preferredColorScheme(.dark)
}
