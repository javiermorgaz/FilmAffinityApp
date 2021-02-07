//
//  RestClient.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 25/12/20.
//

import Foundation
import Combine

protocol RestClientProtocol {
    func perform<T: Decodable>(_ apiRouter: ApiRouter, _ decoder: JSONDecoder) -> AnyPublisher<T, Error>
}

protocol ApiRouter {
    var baseUrl: String { get }
    func asURLRequest() -> URLRequest
}

struct RestClient: RestClientProtocol {
    func perform<T: Decodable>(_ apiRouter: ApiRouter, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
        
        let request = apiRouter.asURLRequest()
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> T in
                guard let httpResponse = result.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                let value = try decoder.decode(T.self, from: result.data)
                return value }
            .mapError { error in
                return error }
            .eraseToAnyPublisher()
    }
}

struct MockRest: RestClientProtocol {
    func perform<T>(_ apiRouter: ApiRouter, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> where T : Decodable {
        if let path = Bundle.main.path(forResource: "movie", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let value = try decoder.decode(T.self, from: data)
                
                return Result.success(value).publisher.eraseToAnyPublisher()
                
            } catch {
                return Result.failure(MockError.badData).publisher.eraseToAnyPublisher()
            }
        }
        return Result.failure(MockError.badFileName).publisher.eraseToAnyPublisher()
    }
}

enum MockError: Error {
    case badFileName
    case badData
}
