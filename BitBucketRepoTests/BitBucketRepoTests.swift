//
//  BitBucketRepoTests.swift
//  BitBucketRepoTests
//
//  Created by Andrey Yoshua on 11/09/21.
//

import Combine
import XCTest
@testable import BitBucketRepo

class BitBucketRepoTests: XCTestCase {
    
    func testJSONDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(BitbucketResponse.self, from: json.data(using: .utf8)!))
    }

    func testCasesWithSuccessFetching() {
        let response = try! JSONDecoder().decode(BitbucketResponse.self, from: json.data(using: .utf8)!)
        let viewModel = MainViewModel(
            mainUseCase: MainUseCase(
                getBitBucketResponse: { url in
                    return Result<BitbucketResponse, ServiceError>.Publisher(response).eraseToAnyPublisher()
                }
            )
        )
        
        XCTAssertEqual(viewModel.rows, [.loading])
        viewModel.fetchBitBucketResponse()
        XCTAssertEqual(viewModel.rows, response.repos.map { .repo($0, expanded: false) } + [.next])
        
        // Select row make expanded status to true
        viewModel.selectRow(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(viewModel.rows, response.repos.enumerated().map { .repo($0.element, expanded: $0.offset == 0) } + [.next])
        
        // Select row again make expanded status to false again
        viewModel.selectRow(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(viewModel.rows, response.repos.map { .repo($0, expanded: false) } + [.next])
        
        // Select next row
        viewModel.selectRow(at: IndexPath(row: response.repos.count, section: 0))
        XCTAssertEqual(viewModel.rows, response.repos.map { .repo($0, expanded: false) } + response.repos.map { .repo($0, expanded: false) } + [.next])
    }
    
    func testCasesWithFailureFetching() {
        let viewModel = MainViewModel(
            mainUseCase: MainUseCase(
                getBitBucketResponse: { url in
                    return Result<BitbucketResponse, ServiceError>.Publisher(.decode).eraseToAnyPublisher()
                }
            )
        )
        
        XCTAssertEqual(viewModel.rows, [.loading])
        viewModel.fetchBitBucketResponse()
        XCTAssertEqual(viewModel.rows, [.error(.decode)])
    }
}
