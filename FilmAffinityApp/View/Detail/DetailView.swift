//
//  DetailView.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 12/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import DailymotionPlayerSDK

struct DetailView: View {
    
    @ObservedObject private var viewModel: DetailViewModel
    @State private var showingVideoPlayer: Bool = false
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group{
            if let detailModel = viewModel.detailModel {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32){
                        WebImage(url: detailModel.image)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300, alignment: .top)
                            .clipped()
                        VStack(alignment: .leading, spacing: 16){
                            Text(detailModel.title)
                                .font(.title)
                                .fontWeight(.semibold)
                            section(text: detailModel.year, image: "calendar")
                            section(text: detailModel.director.first ?? "", image: "video")
                            section(text: detailModel.duration, image: "clock")
                            HStack(spacing: 8, content: {
                                Image(systemName: "play.rectangle")
                                    .frame(width: 30, height: 30, alignment: .center)
                                Button("Trailer") {
                                    showingVideoPlayer = true
                                }
                            })
                            Text(detailModel.excerpt)
                            Spacer()
                        }
                        .padding(.horizontal, 32)
                        
                    }
                }.edgesIgnoringSafeArea(.top)
                .sheet(isPresented: $showingVideoPlayer) {
                    PlayerView(videoURL: detailModel.trailer)
                        .ignoresSafeArea()
                }
            }
        }.onAppear(perform: {
            viewModel.movieDetail()
        })
    }
    
    private func section(text: String, image: String) -> some View {
        HStack(spacing: 8, content: {
            Image(systemName: image)
                .frame(width: 30, height: 30, alignment: .center)
            Text(text)
                .font(.subheadline)
        })
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            return DetailView(viewModel: DetailViewModel())
        }
    }
}
