//
//  ViewController.swift
//  AutoComplete
//
//  Created by Asif Mujtaba on 28/12/21.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var tableView: UITableView!
	
	
	let serialQueue: DispatchQueue = DispatchQueue(label: "serialQueue")
	let trie = Trie()
	
	var pendingSearchWorkItem: DispatchWorkItem?
	var result: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialize()
		loadDictionaryWords()
	}
	
	func initialize() {
		tableView.delegate = self
		tableView.dataSource = self
	}

	func loadDictionaryWords() {
		serialQueue.async {
			if let path = Bundle.main.path(forResource: "words", ofType: "txt") {
				do {
					let data = try String(contentsOfFile: path, encoding: .utf8)
					let words = data.components(separatedBy: .newlines)
					self.insert(words: words)
				} catch {
					print(error)
				}
			}
		}
	}
	
	func insert(words: [String]) {
		for word in words {
			trie.insert(word: word)
		}
	}
	
	@IBAction func textFieldChanged(_ sender: UITextField) {
		guard
			let text = sender.text,
			!text.isEmpty,
			text.last != " " else {
				result = []
				tableView.reloadData()
				return
			}
		
		let latestWord = text.split(separator: " ").last ?? ""
		
		pendingSearchWorkItem?.cancel()
		
		let searchWorkItem = DispatchWorkItem { [weak self] in
			let first10Result = Array(self?.trie.findWordsWithPrefix(prefix: String(latestWord)).prefix(10) ?? [])
			DispatchQueue.main.async {
				self?.result = first10Result
				self?.tableView.reloadData()
			}
		}
		
		pendingSearchWorkItem = searchWorkItem
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: searchWorkItem)
	}
}

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		var stringWithoutLastWord = textField.text?.components(separatedBy: " ").dropLast().joined(separator: " ")
		stringWithoutLastWord?.append(" ")
		stringWithoutLastWord?.append(result[indexPath.row])
		textField.text = stringWithoutLastWord
	}
}

extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return result.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = result[indexPath.row]
		return cell
	}
}

