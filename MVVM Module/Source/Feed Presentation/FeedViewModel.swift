//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

final class FeedViewModel {
	typealias Observer<T> = (T) -> Void

	private let feedLoader: FeedLoader

	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}

	var title: String {
		Localized.Feed.title
	}

	var onFeedLoad: Observer<[FeedImage]>?
	var onStateChange: Observer<State>?

	func loadFeed() {
		onStateChange?(.loading)

		feedLoader.load { [weak self] result in
			switch result {
			case .success(let feed):
				self?.onFeedLoad?(feed)
				self?.onStateChange?(.loaded)

			case .failure:
				self?.onStateChange?(.error(message: Localized.Feed.loadError))
			}
		}
	}
}

extension FeedViewModel {
	enum State {
		case loading
		case loaded
		case error(message: String)
	}
}
