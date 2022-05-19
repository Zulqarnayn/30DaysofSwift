//
//  TrieNode.swift
//  AutoComplete
//
//  Created by Asif Mujtaba on 28/12/21.
//

import Foundation

class TrieNode<T: Hashable> { // 1
	var value: T? // 2
	weak var parentNode: TrieNode?
	var children: [T: TrieNode] = [:] // 3
	var isTerminating = false // 4
	var isLeaf: Bool {
		return children.count == 0
	}
	
	init(value: T? = nil, parentNode: TrieNode? = nil) {
		self.value = value
		self.parentNode = parentNode
	}
	
	func add(value: T) {
		guard children[value] == nil else {
			return
		}
		children[value] = TrieNode(value: value, parentNode: self)
	}
}
