```swift

func linesToNumbers(lines: [String]) -> [Int] {
  var numbers = [Int]()
  for line in lines {
    numbers.append(Int(line)!)
  }
  return numbers
}

func filterNumbers(numbers: [Int]) -> [String] {
  var filteredNumbers = [String]()
  for number in numbers {
    if number % 3 == 0 {
      filteredNumbers.append("👏🏼")
    } else if number % 5 == 0 {
      filteredNumbers.append("🙏")
    } else if number % 15 == 0 {
      filteredNumbers.append("👏🏼🙏")
    } else {
      filteredNumbers.append(String(number))
    }
  }
  return filteredNumbers
}

func printNumbers(numbers: [String]) {
  for number in numbers {
    print(number)
  }
}

let lines = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
let numbers = linesToNumbers(lines: lines)
let filteredNumbers = filterNumbers(numbers: numbers)
printNumbers(numbers: filteredNumbers)
```
-  linesToNumbers 함수는 문자열 배열을 정수 배열로 변환하는 함수입니다. 함수의 이름은 linesToNumbers이고, 매개변수는 문자열 배열 lines입니다. 반환값은 정수 배열입니다.

- 함수의 본문은 다음과 같습니다.
```swift
var numbers = [Int]()
```
- 먼저, 정수 배열을 생성합니다. 이 배열은 함수의 반환값이 됩니다.
```swift
for line in lines {
  numbers.append(Int(line)!)
}
```
- 다음으로, lines 배열의 각 요소를 순회하면서 정수로 변환합니다. Int(line)!은 line을 정수로 변환하는 연산자입니다. ! 연산자는 nil이 아닌지 확인합니다. line이 nil이면 Int(line)!은 nil을 반환합니다.
```swift
return numbers
```
- 마지막으로, 변환된 정수 배열을 반환합니다.

- 예를 들어, 다음과 같은 문자열 배열이 있다고 가정해 보겠습니다.

```swift
let lines = ["1", "2", "3"]
```
- 이 배열을 linesToNumbers() 함수에 전달하면 다음과 같은 정수 배열을 반환합니다.

```swift
[1, 2, 3]
```
- 파일에서 읽은 문자열을 정수로 변환할 수 있습니다.
- 사용자 입력으로부터 정수를 입력받아 정수 배열로 변환할 수 있습니다.
- 다른 함수에서 반환된 문자열 배열을 정수 배열로 변환할 수 있습니다.

- filterNumbers 함수:filterNumbers 함수는 정수 배열 numbers를 입력으로 받아 문자열 배열을 반환합니다. numbers 배열을 순회하면서 각 정수에 대해 다음과 같은 조건을 적용합니다. 조건에 따라 filteredNumbers 배열에 해당하는 문자열을 추가합니다.

- 3의 배수: 정수가 3의 배수인 경우 filteredNumbers 배열에 "👏🏼"를 추가합니다.
- 5의 배수: 정수가 5의 배수인 경우 filteredNumbers 배열에 "🙏"를 추가합니다.
- 15의 배수: 정수가 3과 5의 배수인 경우(즉, 15의 배수인 경우) filteredNumbers 배열에 "👏🏼🙏"를 추가합니다.
- 기본값: 위의 조건을 만족하지 않는 정수의 경우 정수 자체의 문자열 표현을 filteredNumbers 배열에 추가합니다.

- printNumbers 함수:printNumbers 함수는 문자열 배열 numbers를 입력으로 받아 각 문자열을 콘솔에 출력합니다. numbers 배열을 순회하면서 각 요소를 print 함수를 사용하여 출력합니다.