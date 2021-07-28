//
//  FeedErrorViewModel.swift
//  MVP
//
//  Created by Omar Bassyouni on 28/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

struct FeedErrorViewModel {
	let state: State

	enum State {
		case show(message: String)
		case hide
	}
}
