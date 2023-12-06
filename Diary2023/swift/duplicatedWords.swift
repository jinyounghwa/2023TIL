func duplicatedWords(inputWords: Array<String>) -> Array<String> {
    // 입력 배열에서 각 단어의 등장 횟수를 세기 위한 딕셔너리
    var wordCountDict = [String: Int]()

    // 결과를 저장할 배열
    var resultArray = [String]()

    // 입력 배열을 순회하면서 단어의 등장 횟수를 세기
    for word in inputWords {
        // 딕셔너리에 해당 단어가 이미 있다면 등장 횟수를 증가시키고
        // 없다면 1로 초기화
        wordCountDict[word, default: 0] += 1
    }

    // 딕셔너리를 순회하면서 등장 횟수가 2 이상인 단어를 결과 배열에 추가
    for (word, count) in wordCountDict {
        if count >= 2 {
            resultArray.append(word)
        }
    }

    // 최종 결과 반환
    return resultArray
}

// 예제1
let inputArray = ["가을", "우주", "너굴", "우주", "겨울", "봄봄", "너굴", "너굴"]
let resultArray = duplicatedWords(inputWords: inputArray)
print(resultArray)

