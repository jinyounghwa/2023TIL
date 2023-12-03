## 입력한 특수문자대로 별 찍기
### 전체 코드 
```swift
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
                print("Invalid special character. Please choose one from !@#$%^&*.")
            }
        } else {
            print("Invalid special character format. Please enter a single character.")
        }
    } else {
        print("Invalid number of lines. Please enter an odd number.")
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
```
1. 입력
- getInput() 함수는 사용자로부터 줄 수와 출력할 문자를 입력받습니다.

```swift
func getInput() -> (lines: Int, format: Character)? {
    print("Enter the number of lines (must be odd):", terminator: " ")
    if let linesString = readLine(), let lines = Int(linesString), lines % 2 == 1 {
        print("Enter a special character from !@#$%^&*:", terminator: " ")
        if let formatString = readLine(), formatString.count == 1 {
            let format = formatString.first!
            if "!@#$%^&*".contains(format) {
                return (lines, format)
            } else {
                print("Invalid special character. Please choose one from !@#$%^&*.")
            }
        } else {
            print("Invalid special character format. Please enter a single character.")
        }
    } else {
        print("Invalid number of lines. Please enter an odd number.")
    }
    return nil
}
```
>getInput() 함수는 다음과 같은 순서로 입력을 받습니다.

1) 줄 수를 입력받습니다.
2) 줄 수가 홀수인지 확인합니다.
3) 특수 문자를 입력받습니다.
4) 특수 문자가 지정된 집합에 있는지 확인합니다.
5) 줄 수와 특수 문자를 튜플로 반환합니다.

2. 점검
- checkInput() 함수는 입력의 유효성을 검사합니다.
```swift
func checkInput(input: (lines: Int, format: Character)) -> Bool {
    return input.lines % 2 == 1 && "!@#$%^&*".contains(input.format)
}
```
>checkInput() 함수는 다음과 같은 조건을 사용하여 입력의 유효성을 검사합니다.

1) 줄 수가 홀수여야 합니다.
2) 특수 문자가 지정된 집합에 있어야 합니다.

3. 처리

- processInput() 함수는 원하는 패턴을 생성합니다.

```swift
func processInput(input: (lines: Int, format: Character)) -> [String] {
    var output = [String]()
    for i in 1...input.lines {
        let spaces = String(repeating: " ", count: input.lines - i)
        let characters = String(repeating: "\(input.format)", count: i)
        output.append(spaces + characters)
    }
    return output
}
```
>processInput() 함수는 다음과 같은 순서로 패턴을 생성합니다.

1) 줄 수만큼 반복합니다.
2) 현재 줄의 위치에 따라 패딩 공백과 반복 문자를 구성합니다.
3) 구성된 패턴을 문자열로 변환하여 출력 배열에 추가합니다.

4. 변환

- convertOutput() 함수는 출력을 생성합니다.

```swift
func convertOutput(output: [String]) -> Void {
    for line in output {
        print(line)
    }
}
```
- convertOutput() 함수는 출력 배열에 있는 각 줄을 출력합니다.

5. 출력

- main() 함수는 위의 네 가지 단계를 실행합니다.
```swift
func main() {
    guard let input = getInput() else { return }
    if checkInput(input: input) {
        let output = processInput(input: input)
        convertOutput(output: output)
    }
}
```
- main() 함수는 다음과 같은 순서로 위의 네 가지 단계를 실행합니다.

1) getInput() 함수를 사용하여 입력을 가져옵니다.
2) checkInput() 함수를 사용하여 입력의 유효성을 검사합니다.
3) processInput() 함수를 사용하여 패턴을 생성합니다.
4) convertOutput() 함수를 사용하여 출력을 생성합니다.