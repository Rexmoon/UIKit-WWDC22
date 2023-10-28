import UIKit

let numbers = ["1", "2", "three", "four", "5"]

let compactMapped = numbers.compactMap { string in Int(string) }

let dictionary = ["one": [23, 5, 12, 11, 2],
                  "two": [1, 2, 3, 4, 5]]

let flapMapped = dictionary.flatMap { $0.value }
