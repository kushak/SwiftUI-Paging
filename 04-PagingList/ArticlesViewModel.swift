//
//  ArticlesViewModel.swift
//  04-PagingList
//
//  Created by Oleg Shipulin on 18.12.2019.
//  Copyright © 2019 Oleg Shipulin. All rights reserved.
//

import SwiftUI
import Combine

enum Language: String, CaseIterable, Identifiable {
	var id: String { return rawValue }

	case en
	case ru
	case de
	case it
}

final class ArticlesViewModel: ObservableObject, Identifiable {

	@Published private(set) var isNewPagingLoading = false
	@Published private(set) var articles: [Article] = []

	// MARK: Private Propeties
	private var pageIndex = 1
	let language: Language
	private var disposeBag = Set<AnyCancellable>()

	// MARK: Lifcycle
	init(language: Language) {
		self.language = language
	}

	// MARK: Public
	func printSelf() {
		print(Unmanaged.passUnretained(self).toOpaque())
		print("articles.count: \(self.articles.count)")
	}
	func viewDidLoad() {
		loadMoreData()

		$articles.sink { articles in
			print("didPublish \(articles.count) articles for \(self.language.rawValue)")
		}.store(in: &disposeBag)
	}

	func loadMoreData() {

		print("loadMoreData for \(language.rawValue)")
		guard !isNewPagingLoading else { return }
		isNewPagingLoading = true
		ArticlesAPI.everythingGet(
			q: "bitcoin",
			from: "2019-12-10",
			sortBy: "publishedAt",
			apiKey: "e1f153e2c4ac439e8d3eff0bed7acb57",
			page: pageIndex,
			language: language.rawValue
		) { list, error in

			self.isNewPagingLoading = false
			guard let list = list else { return }
			self.pageIndex += 1
			print("articles.count: \(self.articles.count) + appended count: \(list.articles.count)")
			self.articles.append(contentsOf: list.articles)
		}
	}
}
