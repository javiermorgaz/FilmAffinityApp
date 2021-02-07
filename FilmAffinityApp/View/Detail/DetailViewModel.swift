//
//  DetailViewModel.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 25/12/20.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let restClient = MockRest()//RestClient()
    private var cancellable = Set<AnyCancellable>()
    
    @Published var detailModel: DetailModel?
    
    private func getMovie() ->AnyPublisher<MovieResponse, Error> {
        restClient.perform(FilmAffinityAPI.detail(id: "750283", lang: .es))
    }
    
    func movieDetail() {
        getMovie()
            .receive(on: DispatchQueue.main)
            .map { $0.movie}
            .sink(receiveCompletion: { error in
                switch error {
                case .finished:
                    break
                case .failure:
                    print("FAILURE: \(error)")
                }
            }, receiveValue: { movie in
                self.detailModel = DetailModel(movie)
                print(movie)
            })
            .store(in: &cancellable)
    }
}
