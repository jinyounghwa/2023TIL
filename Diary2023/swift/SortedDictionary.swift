import Foundation

// 입력을 받아 정수형 숫자 배열을 반환하는 함수
func getInputArray() -> [Int] {
    var input: String?
    repeat {
        print("여러 정수형 숫자를 콤마로 구분해서 입력하세요:")
        input = readLine()
    } while input == nil || input!.isEmpty

    let inputArray = input!.components(separatedBy: ",").compactMap { Int($0) }
    return inputArray
}

// 정수형 숫자를 문자열로 변환하고 각 자리수 숫자의 누적 개수를 기록하는 함수
func countDigits(_ number: Int) -> [String: Int] {
    var digitCountDict: [String: Int] = [:]

    let digitString = String(number)
    for char in digitString {
        let digit = String(char)
        digitCountDict[digit, default: 0] += 1
    }

    return digitCountDict
}

// 정수형 숫자 배열을 받아 각 숫자의 누적 개수를 기록한 사전을 반환하는 함수
func processInputArray(_ inputArray: [Int]) -> [String: Int] {
    var resultDict: [String: Int] = [:]

    for number in inputArray {
        let digitCountDict = countDigits(number)

        for (digit, count) in digitCountDict {
            resultDict[digit, default: 0] += count
        }
    }

    return resultDict
}

// 사전을 받아 키값을 오름차순으로 정렬하고 출력하는 함수
func printSortedDictionary(_ dict: [String: Int]) {
    let sortedKeys = dict.keys.sorted()

    for key in sortedKeys {
        print("\"\(key)\" : \(dict[key]!)개")
    }
}

// 프로그램 실행 부분
func main() {
    let inputArray = getInputArray()
    let resultDict = processInputArray(inputArray)
    printSortedDictionary(resultDict)
}
main()

