## 캘린더 3
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
            case .sunday: return "일"
            case .monday: return "월"
            case .tuesday: return "화"
            case .wednesday: return "수"
            case .thursday: return "목"
            case .friday: return "금"
            case .saturday: return "토"
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

    mutating func display() {
        print("\(year)년 \(currentMonth)월")
        print("일 월 화 수 목 금 토")
        print("---")
        for week in weeks {
            for day in week {
                if day == 0 {
                    print(" ", terminator: "")
                } else {
                    print(day, terminator: "")
                }
            }
            print()
        }
    }
}
```
>이 구조체는 다음과 같이 변경되었습니다.

- display() 메소드를 추가하여 해당 달을 주단위로 출력하는 역할을 합니다.

>display() 메소드는 다음과 같이 동작합니다.

- 첫째 줄에는 해당 년도와 월을 출력합니다.
- 둘째 줄에는 요일을 출력합니다.
- 셋째 줄에는 가로줄을 출력합니다.
- 넷째 줄부터는 달력을 출력합니다.
- 날짜가 없는 날은 공백으로 출력합니다.
- 날짜가 있는 날은 우측으로 정렬하여 출력합니다.
- 날짜와 날짜 사이는 공백으로 띄어씁니다.
  
>예를 들어, 다음과 같이 사용합니다.
```swift
let calendar = Calendar()
calendar.setCurrentMonth(month: 2)
calendar.fillWeeks()

calendar.display()
```
- 출력 결과는 다음과 같습니다.

2023년 2월
일 월 화 수 목 금 토
----------------
1  2  3  4  5  6
7  8  9 10 11 12
13 14 15 16 17 18
19 20 21 22 23 24