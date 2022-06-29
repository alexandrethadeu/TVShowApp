//
//  TVShowRepositoryTests.swift
//  TVShowAppTests
//
//  Created by Alexandre Thadeu  on 29/06/22.
//

import XCTest
@testable import TVShowApp
@MainActor
final class TVShowViewModelTests: XCTestCase {
    var viewModel: TVShowViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TVShowViewModel(
            repository: MockTVShowRepository(
                remote: MockTVShowRemote()
            )
        )
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testOnAppear() async throws {
        await viewModel.action(.onAppear)
        XCTAssertEqual(viewModel.output.tvShows.count, 3)
    }
    
    func testNextPage() async throws {
        await viewModel.action(.onAppear)
        await viewModel.action(.refreshTVShow)
        XCTAssertEqual(viewModel.output.tvShows.count, 6)
    }

}
