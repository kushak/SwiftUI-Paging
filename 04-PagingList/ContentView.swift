//
//  ContentView.swift
//  04-PagingList
//
//  Created by Oleg Shipulin on 14.12.2019.
//  Copyright © 2019 Oleg Shipulin. All rights reserved.
//

import SwiftUI

extension String: Identifiable {
	public var id: String { return self }
}

extension Article: Identifiable {
	public var id: String? { return url }
}

struct ContentView: View {
	@State var currentLanguage: Language = Language.allCases.first ?? .ru

	var body: some View {
		NavigationView {
			VStack {
				Picker("", selection: $currentLanguage) {
					ForEach(Language.allCases) {
						Text($0.rawValue.uppercased()).tag($0)
					}
				}.pickerStyle(SegmentedPickerStyle())

				GeometryReader { geometry in
					HStack(spacing: 0) {
						ForEach(Language.allCases) {
							self.articlesList(for: $0)
								.frame(width: geometry.size.width, height: geometry.size.height)
						}
					}

					.frame(width: geometry.size.width * CGFloat(Language.allCases.count), height: geometry.size.height)
					.offset(
						x: geometry.size.width * CGFloat(Language.allCases.count - 1) / 2 -
							CGFloat(self.pageNumber(for: self.currentLanguage)) * geometry.size.width
					)
						.animation(.spring())
				}
			}
		}
	}
}

private extension ContentView {

	func articlesList(for language: Language) -> some View {
		ArticlesList()
			.environmentObject(ArticlesViewModel(language: language))
	}

	func pageNumber(for language: Language) -> Int {
		Language.allCases.firstIndex(of: language) ?? 0
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			.environmentObject(ArticlesViewModel(language: .ru))
    }
}
