import Foundation

public extension String {
    var uppercasingFirst: String { prefix(1).uppercased() + dropFirst() }
    var lowercasingFirst: String { prefix(1).lowercased() + dropFirst() }
    var words: [String] {
        var words = [String]()
        var index = self.startIndex
        var temporaryString = [Character]()
        
        let addWordFromTemporaryString = {
            guard temporaryString.isNotEmpty else { return }
            
            let word = String(temporaryString)
            words.append(word.lowercased())
            temporaryString.removeAll()
        }
        
        while index < self.endIndex {
            let char = self[index]
            if char.isUppercase {
                addWordFromTemporaryString()
            }
            temporaryString.append(char)
            index = self.index(after: index)
        }
        addWordFromTemporaryString()
        
        return words
    }
    
    var doubleValue: Double? {
        let formatter = NumberFormatter.default
        guard let number = formatter.number(from: self), number.doubleValue >= 1E-2 else { return nil }
        return number.doubleValue
    }
    
    init?(double: Double?) {
        guard let double = double else {return nil}
        let formatter = NumberFormatter.default
        guard let string = formatter.string(from: NSNumber(value: double)) else { return nil }
        self.init(string)
    }
}

private extension NumberFormatter {
    static var `default`: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.numberStyle = .decimal
        return formatter
    }
}
