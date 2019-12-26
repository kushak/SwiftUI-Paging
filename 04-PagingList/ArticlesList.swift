//
//  ArticlesList.swift
//  04-PagingList
//
//  Created by Oleg Shipulin on 18.12.2019.
//  Copyright © 2019 Oleg Shipulin. All rights reserved.
//

import SwiftUI

struct ArticlesList: View {

	@EnvironmentObject private var viewModel: ArticlesViewModel
    var body: some View {

		print("triger body for: \(viewModel.language.rawValue)")
		return aaa()
    }

	private func aaa() -> some View {
		List(viewModel.articles) { article in
			VStack(alignment: .leading) {
				Text(article.title ?? "").onAppear {
					self.itemShowed(item: article)
				}
				if self.viewModel.isNewPagingLoading && self.viewModel.articles.isLast(item: article) {
					Divider()
					Text("Loading...")
				}
			}
		}
		.onTapGesture {
			print(Unmanaged.passUnretained(self.viewModel).toOpaque())
			self.viewModel.printSelf()
//			print(Unmanaged.passUnretained(self.$viewModel).toOpaque())
		}
		.listStyle(GroupedListStyle())
		.navigationBarTitle("Articles")
		.onAppear(perform: viewModel.viewDidLoad)
	}
}

private extension ArticlesList {
	func itemShowed(item: Article) {
		let index = viewModel.articles.firstIndex { $0.id == item.id }
//		print("itemShowed: \(index ?? -1) \(item.title ?? "-1")")
		if viewModel.articles.isLast(item: item) {
			self.viewModel.loadMoreData()
		}
	}
}

struct ArticlesList_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesList()
    }
}
