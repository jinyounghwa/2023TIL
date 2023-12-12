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
