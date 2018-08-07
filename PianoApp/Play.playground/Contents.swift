import UIKit

class Person {
    var isTransvestite = false
    
    var name = "" {
        didSet {
            isTransvestite = isGirlsName(name: name) && !isGirlsName(name: oldValue)
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    func isGirlsName(name: String) -> Bool {
        return name.suffix(3) == "ine"
    }
}

let ole = Person(name: "Ole")
ole.name = "oline"

print(ole.isTransvestite)
