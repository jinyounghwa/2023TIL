## 입력부터 출력까지 5단계로 
### 전체 코드
```swift
func readInput(ment:String) -> String{
    print(ment)
    return readLine() ?? ""
}

func readLines() -> Int {
    let lines = readInput(ment: "줄 개수를 입력하세요")
    return Int(lines) ?? 0
}
func isContinue(with lines:Int) -> Bool {
    if lines < 1 {return false}
    else if lines > 10 {return false}
    return true
}
func tempArray(lines:Int) -> Array<Array<Int>> {
    var resultArray = Array<Array<Int>>()
    for _ in 1...lines {
        var tempArray = Array<Int>()
        for xLoop in 1...lines {
            tempArray.append(xLoop)
        }
        resultArray.append(tempArray)
    }
    return resultArray
}

func makeFormat(array : Array<Array<Int>>) -> Array<Array<String>> {
    var formatArray = Array<Array<String>>()
    for innerArray in array {
        var tempArray = Array<String>()
        for item in innerArray {
            let two = item < 10 ? "0"+"\(item)" : "\(item)"
            tempArray.append(two)
        }
        formatArray.append(tempArray)
    }
    return formatArray
}


func printArray(array : Array<Array<String>>) {
    for innerArray in array {
        for item in innerArray {
            print(item, terminator:" ")
        }
        print()
    }
}
func main() {
    //1.입력
    let lineNumber = readLines()
    //2.점검
    guard isContinue(with: lineNumber) else {
        return
    }
    //3.처리
    let temp = tempArray(lines: lineNumber)
    //4.변환
    let result = makeFormat(array: temp)
    //5.출력
    printArray(array:result)
}

main()
```
```swift
func readInput(ment:String) -> String{
    print(ment)
    return readLine() ?? ""
}
```
### 함수 readInput(ment:String) -> String

>이 함수는 사용자에게 메시지를 표시하고 입력된 문자열을 반환합니다.

- ment 파라미터는 사용자에게 표시할 메시지를 지정합니다.
- readLine() 함수를 사용하여 사용자의 입력을 가져옵니다.
- ?? "" 연산자를 사용하여 입력된 값이 없으면 빈 문자열을 반환합니다.

```swift
func readLines() -> Int {
    let lines = readInput(ment: "줄 개수를 입력하세요")
    return Int(lines) ?? 0
}
```
### 함수 readLines() -> Int

>이 함수는 사용자에게 줄 수를 입력하도록 요청하고 입력된 값을 정수로 반환합니다.

- readInput(ment: "줄 개수를 입력하세요") 함수를 호출하여 사용자에게 줄 수를 입력하도록 요청합니다.
- Int(lines) ?? 0 연산자를 사용하여 입력된 값을 정수로 변환하고, 입력된 값이 없거나 정수로 변환할 수 없는 경우 0을 반환합니다.

```swift
func isContinue(with lines:Int) -> Bool {
    if lines < 1 {return false}
    else if lines > 10 {return false}
    return true
}
```
### 함수 isContinue(with lines:Int) -> Bool

>이 함수는 입력된 줄 수가 1보다 크고 10보다 작으면 true를 반환하고, 그렇지 않으면 false를 반환합니다.

- lines < 1 || lines > 10 연산자를 사용하여 입력된 줄 수가 1보다 크고 10보다 작은지 확인합니다.
- !lines < 1 && !lines > 10 연산자를 사용하여 입력된 줄 수가 1보다 크고 10보다 작으면 true를 반환하고, 그렇지 않으면 false를 반환합니다.
```swift
func tempArray(lines:Int) -> Array<Array<Int>> {
    var resultArray = Array<Array<Int>>()
    for _ in 1...lines {
        var tempArray = Array<Int>()
        for xLoop in 1...lines {
            tempArray.append(xLoop)
        }
        resultArray.append(tempArray)
    }
    return resultArray
}
```
### 함수 tempArray(lines:Int) -> Array<Array<Int>>

>이 함수는 입력된 줄 수에 따라 2차원 배열을 생성합니다.

- Array<Array<Int>>() 연산자를 사용하여 빈 2차원 배열을 생성합니다.
- 1...lines 루프를 사용하여 2차원 배열의 행을 반복합니다.
- 1...lines 루프를 사용하여 2차원 배열의 각 행에 정수 값을 추가합니다.
- resultArray.append(tempArray) 연산자를 사용하여 생성된 행을 2차원 배열에 추가합니다.

```swift
func makeFormat(array : Array<Array<Int>>) -> Array<Array<String>> {
    var formatArray = Array<Array<String>>()
    for innerArray in array {
        var tempArray = Array<String>()
        for item in innerArray {
            let two = item < 10 ? "0"+"\(item)" : "\(item)"
            tempArray.append(two)
        }
        formatArray.append(tempArray)
    }
    return formatArray
}
```
### 함수 makeFormat(array : Array<Array<Int>>) -> Array<Array<String>>

>이 함수는 입력된 2차원 배열을 문자열 2차원 배열로 변환합니다.

- Array<Array<String>>() 연산자를 사용하여 빈 문자열 2차원 배열을 생성합니다.
- innerArray 루프를 사용하여 입력된 2차원 배열의 행을 반복합니다.
- tempArray 루프를 사용하여 입력된 2차원 배열의 각 행의 값을 반복합니다.
- two = item < 10 ? "0"+"\(item)" : "\(item)" 연산자를 사용하여 값이 10보다 작으면 앞에 "0"을 붙여 문자열로 변환합니다.
- tempArray.append(two) 연산자를 사용하여 변환된 문자열을 문자열 2차원 배열에 추가합니다.
- formatArray.append(tempArray) 연산자를 사용하여 생성된 행을 문자열 2차원 배열에 추가합니다.

```swift
func printArray(array : Array<Array<String>>) {
    for innerArray in array {
        for item in innerArray {
            print(item, terminator:" ")
        }
        print()
    }
}
```
### 함수 printArray(array : Array<Array<String>>)

>이 함수는 입력된 2차원 배열을 출력합니다.

- innerArray 루프를 사용하여 입력된 2차원 배열의 행을 반복합니다.
- item 루프를 사용하여 입력된 2차원 배열의 각 행의 값을 반복합니다.
- print(item, terminator:" ") 연산자를 사용하여 값을 출력하고, 다음 값을 출력할 때 공백을 삽입합니다.
- print() 연산자를 사용하여 다음 행으로 이동합니다.

```swift
func main() {
    //1.입력
    let lineNumber = readLines()
    //2.점검
    guard isContinue(with: lineNumber) else {
        return
    }
    //3.처리
    let temp = tempArray(lines: lineNumber)
    //4.변환
    let result = makeFormat(array: temp)
    //5.출력
    printArray(array:result)
}

main()
```
### 프로그램은 main() 함수에서 시작합니다. main() 함수는 다음과 같은 순서로 실행됩니다.

1. readLines() 함수를 사용하여 사용자에게 줄 수를 입력합니다.
2. isContinue() 함수를 사용하여 입력된 줄 수가 1에서 10 사이인지 확인합니다.
3. 입력된 줄 수가 1에서 10 사이인 경우, tempArray() 함수를 사용하여 2차원 배열을 생성합니다.
4. makeFormat() 함수를 사용하여 2차원 배열을 문자열 2차원 배열로 변환합니다.
5. printArray() 함수를 사용하여 문자열 2차원 배열을 출력합니다.

#### main()함수의 구체적인 흐름
```swift
let lineNumber = readLines()
guard isContinue(with: lineNumber) else {
    return
}

let temp = tempArray(lines: lineNumber)
let result = makeFormat(array: temp)
printArray(array:result)
```
1. readLines() 함수를 사용하여 사용자에게 줄 수를 입력합니다.

```swift
let lineNumber = readLines()
```
- readLines() 함수는 사용자에게 "줄 개수를 입력하세요"라는 메시지를 표시하고, 사용자의 입력을 문자열로 반환합니다.

2. isContinue() 함수를 사용하여 입력된 줄 수가 1에서 10 사이인지 확인합니다.
```swift
guard isContinue(with: lineNumber) else {
    return
}
```
- isContinue() 함수는 입력된 줄 수가 1에서 10 사이인지 확인합니다. 입력된 줄 수가 1에서 10 사이가 아닌 경우, return 키워드를 사용하여 함수를 종료합니다.

3. 입력된 줄 수가 1에서 10 사이인 경우, tempArray() 함수를 사용하여 2차원 배열을 생성합니다.
```swift
let temp = tempArray(lines: lineNumber)
```
- tempArray() 함수는 입력된 줄 수에 따라 2차원 배열을 생성합니다. 생성된 2차원 배열의 각 행에는 1부터 입력된 줄 수까지의 정수 값이 순서대로 들어 있습니다.

4. makeFormat() 함수를 사용하여 2차원 배열을 문자열 2차원 배열로 변환합니다.
```swift
let result = makeFormat(array: temp)
```
- makeFormat() 함수는 입력된 2차원 배열을 문자열 2차원 배열로 변환합니다. 변환된 문자열 2차원 배열의 각 행에는 각 행의 각 값을 10보다 작으면 앞에 "0"을 붙여 문자열로 변환한 값이 들어 있습니다.

5. printArray() 함수를 사용하여 문자열 2차원 배열을 출력합니다.
```swift
printArray(array:result)
```
- printArray() 함수는 입력된 문자열 2차원 배열을 출력합니다. 출력 시 각 값 사이에 공백을 삽입합니다.

