## 날씨 앱 MVVM 설명
```swift
class WeeklyWeatherViewModel: ObservableObject {
 @Published var city: String = ""
 @Published var dataSource: [DailyWeatherRowViewModel] = []

 private let weatherFetcher: WeatherFetchable
 private var disposables = Set<AnyCancellable>()

 init(
  weatherFetcher: WeatherFetchable,
  scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
 ) {
  self.weatherFetcher = weatherFetcher
  _ = $city
   .dropFirst(1)
   .debounce(for: .seconds(0.5), scheduler: scheduler)
   .sink(receiveValue: fetchWeather(forCity:))
 }

 func fetchWeather(forCity city: String) {
  weatherFetcher.weeklyWeatherForecast(forCity: city)
   .map { response in
    response.list.map(DailyWeatherRowViewModel.init)
   }
   .map(Array.removeDuplicates)
   .receive(on: DispatchQueue.main)
   .sink(
    receiveCompletion: { [weak self] value in
     guard let self = self else { return }
     switch value {
     case .failure:
      self.dataSource = []
     case .finished:
      break
     }
    },
    receiveValue: { [weak self] forecast in
     guard let self = self else { return }
     self.dataSource = forecast
   })
   .store(in: &disposables)
 }
}

```
### 클래스 개요

- 이름: WeeklyWeatherViewModel
- 목적: 특정 도시의 일주일 날씨 데이터를 관리하고 표시합니다.
- 주요 기능:
* Combine을 사용하여 날씨 데이터를 비동기식으로 가져오고 처리합니다.
* ObservableObject 패턴을 사용하여 뷰에 변경 사항을 알립니다.
* 드레인백을 사용하여 네트워크 요청을 최적화합니다.

### 속성

- @Published city: 날씨 데이터를 표시하는 도시의 이름을 저장합니다.
- @Published dataSource: 개별 일일 날씨 예보를 나타내는 DailyWeatherRowViewModel 개체의 배열을 보유합니다.
- weatherFetcher: 날씨 데이터를 가져올 수 있는 서비스를 나타내는 프로토콜입니다.
- disposables: 구독을 관리하기 위한 Combine 취소 가능한 집합입니다.

### 초기화

- init(weatherFetcher:, scheduler:)
* WeatherFetchable 인스턴스와 선택적 DispatchQueue를 일정에 맞추기 위해 사용합니다.
* city 속성이 변경될 때 날씨 가져오기를 트리거하기 위한 Combine 파이프라인을 설정합니다.
* - city 게시자의 첫 번째 값을 드롭하여 즉시 가져오기를 방지합니다.
* - debounce(for: .seconds(0.5))를 사용하여 타이핑이 중지된 후 0.5초 동안 가져오기를 지연하여 과도한 요청을 방지합니다.
* - 새로운 값을 수신하면 fetchWeather(forCity:) 메서드를 도시 이름으로 호출합니다.

### 메서드

- fetchWeather(forCity city:)
* weatherFetcher를 사용하여 일주일 날씨 데이터를 가져옵니다.
* 응답을 DailyWeatherRowViewModel 개체의 배열로 매핑합니다.
* 배열에서 중복 항목을 제거합니다.
* 결과를 메인 디스패치 큐에서 수신합니다.
* 결과를 dataSource 속성에 저장합니다.
* 완료를 처리합니다.
* 실패하면 dataSource를 비웁니다.