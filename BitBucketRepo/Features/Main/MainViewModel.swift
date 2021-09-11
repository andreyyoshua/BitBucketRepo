//
//  MainViewModel.swift
//  BitBucketRepo
//
//  Created by Andrey Yoshua on 11/09/21.
//

import Combine
import Foundation

enum Row: Equatable {
    case repo(Repo, expanded: Bool)
    case loading
    case next
    case empty
    case error(ServiceError)
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default: return false
        }
    }
}

final class MainViewModel {
    @Published private(set) var rows: [Row] = [.loading]
    private var nextPage: String?
    var isNextPageAvailable: Bool {
        return nextPage != nil
    }
    
    private let mainUseCase: MainUseCase
    private var bindings = Set<AnyCancellable>()
    
    init(mainUseCase: MainUseCase = .live) {
        self.mainUseCase = mainUseCase
    }
    
    func fetchBitBucketResponse() {
        let bitBucketCompletionHandler: (Subscribers.Completion<ServiceError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.rows.removeLast()
                self?.rows.append(.error(error))
            case .finished: break
            }
        }
        
        let bitBucketValueHandler: (BitbucketResponse) -> Void = { [weak self] response in
            guard let self = self else {
                if self?.rows.isEmpty == true {
                    self?.rows = [.empty]
                }
                return
            }
            
            self.nextPage = response.next
            self.rows.removeLast()
            self.rows.append(contentsOf: response.repos.map { .repo($0, expanded: false) })
            if self.isNextPageAvailable {
                self.rows.append(.next)
            }
        }
        
        mainUseCase.getBitBucketResponse(nextPage)
            .sink(receiveCompletion: bitBucketCompletionHandler, receiveValue: bitBucketValueHandler)
            .store(in: &bindings)
    }
    
    func selectRow(at indexPath: IndexPath) {
        guard rows.count > indexPath.row else {
            return
        }
        if case let .repo(repo, expanded) = rows[indexPath.row] {
            rows[indexPath.row] = .repo(repo, expanded: !expanded)
        }
        if case .next = rows[indexPath.row] {
            self.rows.removeLast()
            self.rows.append(.loading)
            fetchBitBucketResponse()
        }
    }
    
}
