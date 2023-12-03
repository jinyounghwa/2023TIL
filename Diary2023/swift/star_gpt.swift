func getInput() -> (lines: Int, format: Character)? {
    print("Enter the number of lines (must be odd):", terminator: " ")
    if let lines = Int(readLine() ?? ""), lines % 2 == 1 {
        print("Enter a special character from !@#$%^&*:", terminator: " ")
        if let format = readLine()?.first, "!@#$%^&*".contains(format) {
            return (lines, format)
        } else {
            print("Invalid special character. Please choose one from !@#$%^&*.")
        }
    } else {
        print("Invalid number of lines. Please enter an odd number.")
    }
    return nil
}

func generateOutput(lines: Int, format: Character) {
    for i in 1...lines {
        let spaces = String(repeating: " ", count: lines - i)
        let characters = String(repeating: "\(format) ", count: i)
        print(spaces + characters)
    }
}

if let input = getInput() {
    let lines = input.lines
    let format = input.format
    generateOutput(lines: lines, format: format)
}

//  정답에 가까운 답안이나 간단하고 직관직이고 튜플로 받지 않고 그냥 사용함
