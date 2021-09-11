//
//  MainUseCase.swift
//  BitBucketRepo
//
//  Created by Andrey Yoshua on 11/09/21.
//

import Combine
import Foundation

enum ServiceError: Error, Equatable {
    case url(URLError)
    case urlRequest
    case decode
}

struct MainUseCase {
    var getBitBucketResponse: (_ url: String?) -> AnyPublisher<BitbucketResponse, ServiceError>
    
    static var live: MainUseCase {
        MainUseCase(
            getBitBucketResponse: { url in
                
                func getUrlRequest(urlString: String?) -> URLRequest? {
                    var components = URLComponents()
                    components.scheme = "https"
                    components.host = "api.bitbucket.org"
                    components.path = "/2.0/repositories"
                    
                    guard let url = URL(string: urlString ?? "") ?? components.url else { return nil }
                    
                    var urlRequest = URLRequest(url: url)
                    urlRequest.timeoutInterval = 10.0
                    urlRequest.httpMethod = "GET"
                    return urlRequest
                }
                
                var dataTask: URLSessionDataTask?
                
                let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
                let onCancel: () -> Void = { dataTask?.cancel() }
                
                // promise type is Result<BitbucketResponse, Error>
                return Future<BitbucketResponse, ServiceError> { promise in
                    guard let urlRequest = getUrlRequest(urlString: url) else {
                        promise(.failure(ServiceError.urlRequest))
                        return
                    }
                    
                    dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                        guard let data = data else {
                            if let error = error as? URLError {
                                promise(.failure(.url(error)))
                            }
                            return
                        }
                        do {
                            let response = try JSONDecoder().decode(BitbucketResponse.self, from: data)
                            promise(.success(response))
                        } catch {
                            print(error)
                            promise(.failure(ServiceError.decode))
                        }
                    }
                }
                .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
            }
        )
    }
}
