//
//  TVShowViewModel.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import Foundation

@MainActor
class TVShowViewModel: ObservableObject {
    @Published private (set) var output = Output()
    
    private var shows: [TVShow] = []
    private var page: Int = 1
    private let repository: TVShowRepositoryProtocol
    
    init(repository: TVShowRepositoryProtocol) {
        self.repository = repository
    }
    
    func action(_ input: Input) async {
        switch input {
        case .onAppear:
            await fetchTVShow()
        case .refreshTVShow:
            await refresnTVShow()
        }
    }
    
    private func fetchTVShow() async {
        output.isLoading = true
        do {
            self.shows = try await repository.fetchTopRatedTVShow(page: page)
            output.isLoading = false
            output.tvShows = self.shows
        } catch TVShowRemote.Errors.decodeFailed {
            output.isLoading = false
            output.errors = .decodeError
        } catch {
            output.isLoading = false
            output.errors = .networkError
        }
    }
    
    private func refresnTVShow() async {
        page += 1
        output.isLoadMore = true
        do {
            output.isLoadMore = false
            self.shows += try await repository.fetchTopRatedTVShow(page: self.page)
            output.tvShows = self.shows
        } catch TVShowRemote.Errors.decodeFailed {
            output.isLoadMore = false
            output.errors = .decodeError
        } catch {
            output.isLoadMore = false
            output.errors = .networkError
        }
    }
}
