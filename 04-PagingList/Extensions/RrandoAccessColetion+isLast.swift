//
//  RrandoAccessColetion+isLast.swift
//  04-PagingList
//
//  Created by Oleg Shipulin on 14.12.2019.
//  Copyright © 2019 Oleg Shipulin. All rights reserved.
//

import Foundation

extension RandomAccessCollection where Element: Identifiable {

	public func isLast(item: Element) -> Bool {
		guard
			!isEmpty,
			let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) })
		else { return false }

		let distance = self.distance(from: itemIndex, to: endIndex)

		return distance == 1
	}
}
