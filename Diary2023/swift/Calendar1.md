## 캘린더 1단계
```swift
struct Calendar {

    private enum Weekday: Int, CaseIterable {
        case sunday = 0
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday

        var name: String {
            switch self {
            case .sunday: return "일요일"
            case .monday: return "월요일"
            case .tuesday: return "화요일"
            case .wednesday: return "수요일"
            case .thursday: return "목요일"
            case .friday: return "금요일"
            case .saturday: return "토요일"
            }
        }
    }

    private let daysOfMonth: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private let year: Int = 2023
    private var currentMonth: Int = 1

    mutating func setCurrentMonth(month: Int) {
        self.currentMonth = month
    }

    func daysOf(month: Int) -> Int {
        return daysOfMonth.reduce(0, +)
    }

    func weekday(month: Int, day: Int) -> Weekday {
        return Weekday(rawValue: (daysOf(month: month) + day) % 7)!
    }
}
```
>이 구조체는 다음과 같이 구현됩니다.

- Weekday enum 타입은 요일을 나타내는 case를 정의합니다. 각 case는 name computed property를 통해 한글 요일을 String으로 반환합니다.
- daysOfMonth 상수는 1월부터 12월까지의 날짜 수를 저장합니다.
- year 상수는 년도를 저장합니다. 초기값은 2023입니다.
- currentMonth 변수는 현재 달을 저장합니다.
- daysOf(month: Int) 함수는 매개변수로 달을 입력받아 해당 달까지 날짜가 며칠 있는지 누적값을 반환합니다. 1월인 경우는 없으므로 0을 반환하고, 2월은 1월이 31일까지 있으므로 31을 반환하며, 3월은 1월 31 + 2월 28 = 59를 반환합니다. 12월은 1월부터 11월까지 날짜를 합쳐서 반환합니다.

- weekday(month: Int, day: Int) 함수는 매개변수로 월과 일을 입력받아 해당 월-일에 대한 요일이 무슨 요일인지 enum 타입을 반환합니다. 1월 1일은 일요일이고, 2월 1일은 수요일, 4월 1일은 토요일입니다. 위에서 구현한 daysOf() 함수가 리턴하는 날짜 개수 + day를 % 7 나머지 연산을 하면 0은 일요일, 1은 월요일, 2는 화요일 ... 6은 토요일이 됩니다.

- 예를 들어, 다음과 같이 사용합니다.
```swift
let calendar = Calendar()

// 1월 1일은 일요일입니다.
let weekday = calendar.weekday(month: 1, day: 1)
print(weekday.name) // 일요일

// 2월 1일은 수요일입니다.
weekday = calendar.weekday(month: 2, day: 1)
print(weekday.name) // 수요일

// 4월 1일은 토요일입니다.
weekday = calendar.weekday(month: 4, day: 1)
print(weekday.name) // 토요일
```

- 출력 결과는 다음과 같습니다.

일요일  
수요일  
토요일  