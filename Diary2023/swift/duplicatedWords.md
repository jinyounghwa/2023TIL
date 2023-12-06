## 중복 찾기에서 for in 을 두번 써야 하는 이유
```swift
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
```
- 위 코드에서 for in을 두 번 쓰는 이유는 다음과 같습니다.

- 첫 번째 for in은 입력 배열을 순회하면서 각 단어의 등장 횟수를 세기 위해 사용됩니다. 이때 딕셔너리를 사용하여 단어의 등장 횟수를 저장합니다.

- 두 번째 for in은 딕셔너리를 순회하면서 등장 횟수가 2 이상인 단어를 결과 배열에 추가하기 위해 사용됩니다.

- 만약 두 번째 for in을 사용하지 않으면 어떻게 될까요?

- 첫 번째 for in을 통해 단어의 등장 횟수를 세었지만, 결과 배열에는 단어가 한 번만 추가됩니다. 따라서 count >= 2 조건을 만족하지 못하여 중복된 단어가 없는 경우에도 빈 배열이 아닌 중복된 단어 하나가 포함된 배열이 반환됩니다.

- 따라서 중복된 단어를 한 번만 포함하는 배열을 반환하려면 두 번째 for in을 사용하여 딕셔너리의 각 단어-등장 횟수 쌍을 순회하면서 등장 횟수가 2 이상인 단어를 결과 배열에 추가해야 합니다.

- 구체적으로, 첫 번째 for in은 다음과 같이 작동합니다.
```swift
for word in inputWords {
    // 딕셔너리에 해당 단어가 이미 있다면 등장 횟수를 증가시키고
    // 없다면 1로 초기화
    wordCountDict[word, default: 0] += 1
}
```
- 이 코드는 입력 배열의 각 단어를 순회하면서 다음과 같은 작업을 수행합니다.

- 딕셔너리에 해당 단어가 있는지 확인합니다.
- 해당 단어가 있다면 딕셔너리에서 해당 단어의 등장 횟수를 증가시킵니다.
- 해당 단어가 없다면 딕셔너리에 해당 단어를 추가하고 등장 횟수를 1로 설정합니다.
- 예제1에서 위 코드는 다음과 같이 동작합니다.
```swift
inputArray = ["가을", "우주", "너굴", "우주", "겨울", "봄봄", "너굴", "너굴"]

wordCountDict = [String: Int]()

for word in inputArray {
    // 딕셔너리에 해당 단어가 이미 있다면 등장 횟수를 증가시키고
    // 없다면 1로 초기화
    wordCountDict[word, default: 0] += 1
}

// wordCountDict = ["가을": 1, "우주": 3, "너굴": 4, "겨울": 1, "봄봄": 1]
```
- 두 번째 for in은 다음과 같이 작동합니다.

```siwft
for (word, count) in wordCountDict {
    if count >= 2 {
        resultArray.append(word)
    }
}
```
- 이 코드는 딕셔너리를 순회하면서 다음과 같은 작업을 수행합니다.

- 각 단어-등장 횟수 쌍을 순회합니다.
- 등장 횟수가 2 이상인 경우 해당 단어를 결과 배열에 추가합니다.
- 예제1에서 위 코드는 다음과 같이 동작합니다.

```swift
resultArray = []

for (word, count) in wordCountDict {
    if count >= 2 {
        resultArray.append(word)
    }
}

// resultArray = ["우주", "너굴"]
```

- 따라서 위 코드는 다음과 같은 결과를 반환합니다.

```swift
["우주", "너굴"]
```