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
	var onLoadingStateChange: Observer<Bool>?
	var onErrorStateChange: Observer<String?>?

	func loadFeed() {
		onLoadingStateChange?(true)
		onErrorStateChange?(nil)

		feedLoader.load { [weak self] result in
			switch result {
			case .success(let feed):
				self?.onFeedLoad?(feed)

			case .failure:
				self?.onErrorStateChange?(Localized.Feed.loadError)
			}
			self?.onLoadingStateChange?(false)
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
