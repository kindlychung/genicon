


import Foundation

let s = jsonify(pair: ("name", "Julia"), quoteValue: true)
print(s)


enum Fruit {
    case apple, pear, banana
}

enum Drink {
    case beer, whisky, vodka
}

enum FruitPlusDrink {
    case fruit(Fruit)
    case drink(Drink)
}

enum FruitTimesDrink1 {
    case value(fruit: Fruit, drink: Drink)
}

struct FruitTimesDrink {
    let fruit: Fruit
    let drink: Drink
}

// composition
let content = "10,20,40,30,80,60"
func extractElements(_ content: String) -> [String] {
    return content.characters.split(separator: ",").map {String($0)}
}
func formatWithCurrency(content: [String]) -> [String] {
    return content.map {"€" + $0}
}
let composedFunciton = { data in
    formatWithCurrency(content: extractElements(data))
}
print(composedFunciton(content))

infix operator |> : MultiplicationPrecedence
func |> <T, V>(f: @escaping (T) -> V, g: @escaping (V) -> V) -> (T) -> V {
    return {
        x in
        g(f(x))
    }
}

var res = (extractElements |> formatWithCurrency)(content)
print(res)

res = extractElements(content).sorted(by: {
    (a, b) in
    a > b
})
print(res)
// if the only param is a closure, then the syntax can be simplified as:
res = extractElements(content).sorted {
    (a, b) in
    a > b
}
print(res)
// this can be simplified further
res = extractElements(content).sorted {
    $0 > $1
}
print(res)

func opOnNumber(number: Int, op: (Int) -> Bool) -> Bool {
    return op(number)
}
// if the last param is a closure, you can write it this way (similar to scala):
// looks like functions are automatically curried.
var boolRes = opOnNumber(number: 3) {
    $0 > 5
}
print(boolRes)

// tail recursion 
func factorial(n: Int, accumulator: Int) -> Int {
    return n == 0 ? accumulator : factorial(n: n-1, accumulator: n * accumulator)
}
print(factorial(n: 4, accumulator: 1))


class MemoizedPower2 {
    var memo: [Int: Int] = [:]
    func power2(n: Int) -> Int {
        assert(n >= 0, "Negative power not supported!")
        if let result = memo[n] {
            return result
        } else {
            var result = 1
            for _ in 1...n {
                result *= 2
            }
            memo[n] = result
            return result
        }
    }
    init(memo: [Int:Int]) {
        self.memo = memo
    }
    static let sharedInstance: MemoizedPower2 = {
        let obj = MemoizedPower2(memo: [0:1, 1:2])
        return obj
    }()
}

func printTimeElapsedWhenRunningCode(title:String, operation:()->()) {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Time elapsed for \(title): \(timeElapsed) s")
}

printTimeElapsedWhenRunningCode(title: "power2") {
    for _ in 1...200 {
        let _ = MemoizedPower2.sharedInstance.power2(n: 55)
    }
}
printTimeElapsedWhenRunningCode(title: "power2") {
    for _ in 1...200 {
        var x = 1
        for i in 1...55 {
            x *= 2
        }
    }
}

//func memoize<T: Hashable, U>(fn: ((T) -> U, T) -> U) -> (T) -> U {
//    
//}




