//
//  Trie.swift
//  AutoComplete
//
//  Created by Asif Mujtaba on 28/12/21.
//

import Foundation

class Trie { //this is the Trie itself, the root node is always empty
	
	public var count: Int {
		return wordCount
	}
	
	fileprivate let root: TrieNode<Character>
	fileprivate var wordCount: Int
	
	init() { // the initialization of the root empty node
		root = TrieNode<Character>()
		wordCount = 0
	}
}

extension Trie {
	
	func insert(word: String) {
		guard !word.isEmpty else {
			return
		}
		var currentNode = root
		for character in word.lowercased() { // 1
			if let childNode = currentNode.children[character] {
				currentNode = childNode
			} else {
				currentNode.add(value: character)
				currentNode = currentNode.children[character]!
			}
		}
		
		guard !currentNode.isTerminating else { // 2
			return
		}
		wordCount += 1
		currentNode.isTerminating = true
	}
}

extension Trie {
	
	func findWordsWithPrefix(prefix: String) -> [String] {
		var words = [String]()
		let prefixLowerCased = prefix.lowercased()
		if let lastNode = findLastNodeOf(word: prefixLowerCased) { //1
			if lastNode.isTerminating { // 1.1
				words.append(prefixLowerCased)
			}
			for childNode in lastNode.children.values { //2
				let childWords = getSubtrieWords(rootNode: childNode, partialWord: prefixLowerCased)
				words += childWords
			}
		}
		return words // 3
	}
	
	private func findLastNodeOf(word: String) -> TrieNode<Character>? { // this just check is the prefix exist in the Trie
		var currentNode = root
		for character in word.lowercased() {
			guard let childNode = currentNode.children[character] else { // traverse the Trie with each of prefix character
				return nil
			}
			currentNode = childNode
		}
		return currentNode
	}
}

extension Trie {
	fileprivate func getSubtrieWords(rootNode: TrieNode<Character>, partialWord: String) -> [String] {
		var subtrieWords = [String]()
		var previousLetters = partialWord
		if let value = rootNode.value { // 1
			previousLetters.append(value)
		}
		if rootNode.isTerminating { //2
			subtrieWords.append(previousLetters)
		}
		for childNode in rootNode.children.values { //3
			let childWords = getSubtrieWords(rootNode: childNode, partialWord: previousLetters)
			subtrieWords += childWords
		}
		return subtrieWords
	}
}
