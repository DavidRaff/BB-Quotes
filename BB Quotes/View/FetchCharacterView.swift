//
//  FetchCharacterView.swift
//  BB Quotes
//
//  Created by David Laczkovits on 09.10.23.
//

import SwiftUI

struct FetchCharacterView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    
    let show : String
    let character : Character
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    // Character Image
                    VStack {
                        AsyncImage(url: character.images.randomElement()) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .frame(width: geo.size.width / 1.6, height: geo.size.height / 3)
                    .cornerRadius(25)
                    .padding(.top, 60)
                    
                    // Character Info
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
                        
                        Text("Portrait By: \(character.portrayedBy)")
                            .font(.subheadline)
                        
                        Divider()
                        
                    }
                    .padding(.leading, 40)
                    
                    Button {
                        Task {
                            // get random character
                        }
                    } label: {
                        Text("Get Random Character")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("\(show.lowerNoSpaces)button"))
                            .cornerRadius(7)
                            .shadow(color: Color("\(show.lowerNoSpaces)shadow"),radius: 2)
                    }
                    
                    Button {
                        Task {
                            // get random quote from character
                        }
                    } label: {
                        Text("Get Random Quote from Character")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("\(show.lowerNoSpaces)button"))
                            .cornerRadius(7)
                            .shadow(color: Color("\(show.lowerNoSpaces)shadow"),radius: 2)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FetchCharacterView(show: Constants.bbName, character: Constants.previewCharacter)
}
