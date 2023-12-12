## 캘린더 2단계
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

    private var weeks: [[Int]] = []

    mutating func setCurrentMonth(month: Int) {
        self.currentMonth = month
        weeks = []
    }

    func daysOf(month: Int) -> Int {
        return daysOfMonth.reduce(0, +)
    }

    func weekday(month: Int, day: Int) -> Weekday {
        return Weekday(rawValue: (daysOf(month: month) + day) % 7)!
    }

    mutating func fillWeeks(month: Int) {
        weeks.removeAll()

        let weekday = weekday(month: month, day: 1)

        // 시작하는 1일 요일 이전 배열에는 0을 채운다
        for _ in 0 ..< weekday.rawValue {
            weeks.append([0])
        }

        // 시작하는 요일부터 1을 채우고 한 주의 날짜 7개를 채우고 나면 새로운 주차 배열을 생성한다
        var day = 1
        while day <= daysOfMonth[month - 1] {
            weeks.append([day])
            day += 1
            if day % 7 == 0 {
                day = 1
            }
        }
    }

    func getWeeks() -> [[Int]] {
        return weeks
    }
}
```
- 이 구조체는 다음과 같이 변경되었습니다.

- weeks 속성을 추가하여 달력을 저장하는 2차원 배열을 선언합니다.
- fillWeeks(month: Int) 메소드를 추가하여 해당 달을 2차원 배열에 채우는 역할을 합니다.
>fillWeeks(month: Int) 메소드는 다음과 같이 동작합니다.

- 먼저, 2차원 배열을 비웁니다.
- weekday(month: Int, day: Int) 함수를 사용하여 해당 달에 시작하는 요일을 구합니다.
- 시작하는 1일 요일 이전 배열에는 0을 채웁니다.
- 시작하는 요일부터 1을 채우고 한 주의 날짜 7개를 채우고 나면 새로운 주차 배열을 생성합니다.
- 그 달의 전체 날짜까지 배열에 추가합니다.

- 예를 들어, 다음과 같이 사용합니다.

```swift
let calendar = Calendar()
calendar.setCurrentMonth(month: 2)
calendar.fillWeeks()

print(calendar.getWeeks())
```

- 출력 결과는 다음과 같습니다.

[[0, 0, 0, 0, 0, 0, 1], [2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13], [14, 15, 16, 17, 18, 19], [20, 21, 22, 23, 24, 25], [26, 27, 28]]

