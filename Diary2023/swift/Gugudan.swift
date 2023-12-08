struct Gugudan {
    var stage: Int

    init() {
        self.stage = 2
    }

    func make(start: Int, end: Int) -> [Int] {
        var results = [Int]()
        for i in start...end {
            results.append(self.stage * i)
        }
        return results
    }
}

let a = Gugudan()
print(a.make(start:2, end:5))
