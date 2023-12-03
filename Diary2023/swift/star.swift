import Foundation

func getInput() -> (lines: Int, format: Character)? {
    print("Enter the number of lines (must be odd):", terminator: " ")
    if let linesString = readLine(), let lines = Int(linesString), lines % 2 == 1 {
        print("Enter a special character from !@#$%^&*:", terminator: " ")
        if let formatString = readLine(), formatString.count == 1 {
            let format = formatString.first!
            if "!@#$%^&*".contains(format) {
                return (lines, format)
            } else {
                print("허용하지 않은 입력 양식입니다!@#$%^&*.")
            }
        } else {
            print("특수문자 하나만 입력 해 주세요")
        }
    } else {
        print("라인수는 홀수만 입력 해 주세요")
    }
    return nil
}

func checkInput(input: (lines: Int, format: Character)) -> Bool {
    return input.lines % 2 == 1 && "!@#$%^&*".contains(input.format)
}

func processInput(input: (lines: Int, format: Character)) -> [String] {
    var output = [String]()
    for i in 1...input.lines {
        let spaces = String(repeating: " ", count: input.lines - i)
        let characters = String(repeating: "\(input.format)", count: i)
        output.append(spaces + characters)
    }
    return output
}

func convertOutput(output: [String]) -> Void {
    for line in output {
        print(line)
    }
}

func main() {
    guard let input = getInput() else { return }
    if checkInput(input: input) {
        let output = processInput(input: input)
        convertOutput(output: output)
    }
}

main()

