//
//  TVShowList.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct TVShowList: View {
    @StateObject private var viewModel = TVShowViewModel(
        repository: Injector.shared.container.resolve(TVShowRepositoryProtocol.self)!
    )
    @State var characterLoopIndex: Int = -1
    let loopDuration: Double = 0.5
    var currentTVShowName: String {
        if self.viewModel.output.tvShows.isEmpty {
            return ""
        } else {
            return self.viewModel.output.tvShows[currentIndex].name.uppercased()
        }
    }
    @State var currentIndex: Int = 0
    @State var lastIndex: Bool = false
    
    var body: some View {
        ZStack {
            if self.viewModel.output.isLoading  {
                ProgressView()
            } else if self.viewModel.output.errors != .noError && self.viewModel.output.tvShows.isEmpty {
                errorView
            } else if !self.viewModel.output.tvShows.isEmpty {
                VStack {
                    hList
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.bottom)
        .task {
            await viewModel.action(.onAppear)
        }
    }
    
    private var hList: some View {
        
        ZStack {
            WebImage(url: self.viewModel.output.tvShows[currentIndex].posterURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width,
                       maxHeight: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .overlay(LinearGradient(colors: [Color.black, Color.black.opacity(0.2)], startPoint: .bottom, endPoint: .top))
                .transition(.opacity)
                .id(UUID())
            
            VStack {
                VStack(spacing: 10) {
                    HStack(alignment: .center, spacing: 3) {
                        Text("POPULAR")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                        Text("•")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                        Text("SERIE")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                    }
                    Text(currentTVShowName.uppercased())
                        .font(.title.weight(.bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                        .id(UUID())
                    HStack {
                        if(currentIndex % 4 == 0) {
                            Text("For You")
                                .font(.subheadline.weight(.medium))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(height: 45)
                                .background(Rectangle().fill(Color.black.opacity(0.8)).cornerRadius(10))
                        }
 
                        Text(self.viewModel.output.tvShows[currentIndex].date)
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(height: 45)
                            .background(Rectangle().fill(Color.black.opacity(0.8)).cornerRadius(10))
                        Text("\(self.viewModel.output.tvShows[currentIndex].voteAverageString)")
                            .font(.subheadline.weight(.bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 60, height: 45)
                            .background(Rectangle().fill(Color.yellow).cornerRadius(10))
                        
                    }.padding(.horizontal, 20)
                }
                Spacer()
                    .frame(height: 300)
            }
             
            SnapCarousel(trailingSpace: 180, index: $currentIndex, lastIndex: $lastIndex, items: self.viewModel.output.tvShows) { tvShow in
                let currentMovie = self.viewModel.output.tvShows[currentIndex].id == tvShow.id
               
                GeometryReader { proxy in
                        VStack {
                            Spacer()
                                .frame(height: proxy.size.height * 0.55)
                            
                            WebImage(url: tvShow.posterURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 250)
                                .cornerRadius(12)
                            
                            Text(tvShow.name.uppercased())
                                .font(Font.headline.weight(.bold))
                                .lineLimit(2)
                                .foregroundColor(.white)
                                .frame(width: 200)
                                .multilineTextAlignment(.center)
                                .opacity( currentMovie ? 1 : 0)
                        }
                        .offset(x: 0, y: currentMovie ? 10 : 70)
                }
            } loadMore: {
                await self.viewModel.action(.refreshTVShow)
            }
        }.task {
            if lastIndex {
                await self.viewModel.action(.refreshTVShow)
            }
        }
    }
    

    private var errorView: some View {
        Button("Retry") {
            Task {
                await viewModel.action(.onAppear)
            }
        }
    }
    
    //MARK: Previews
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            TVShowList()
        }
    }
}
