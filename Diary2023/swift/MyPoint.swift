// MyPoint 구조체
struct MyPoint {
    var myX: Float
    var myY: Float

    // (x,y)형태로 좌표를 문자열로 리턴하는 printPoint() 메서드
    func printPoint() -> String {
        return "(\(myX), \(myY))"
    }

    // setX(x : Float) 메서드
    func setX(x: Float) {
        myX = x
    }

    // setY(y: Float) 메서드
    func setY(y: Float) {
        myY = y
    }

    // 다른 점과의 거리를 계산하기 위한 getDistanceTo(toPoint : MyPoint)->Float 메서드
    func getDistanceTo(toPoint: MyPoint) -> Float {
        // x축 간 거리
        let dx = myX - toPoint.myX
        // y축 간 거리
        let dy = myY - toPoint.myY

        // 거리 계산
        return sqrt(dx * dx + dy * dy)
    }
}

// MyPoint 구조체 인스턴스 선언
let pointA = MyPoint(myX: 2.5, myY: 15.8)

// pointA의 좌표 출력
print(pointA.printPoint())

// pointA의 x, y 값 설정
pointA.setX(x: 15.2)
pointA.setY(y: 7.4)

// pointA의 x, y 값 출력
print("pointA=(\(pointA.myX), \(pointA.myY))")

// 새로운 점 pointB 생성
let pointB = MyPoint(myX: 15, myY: 12.2)

// pointA와 pointB의 거리 계산
let distance = pointA.getDistanceTo(toPoint: pointB)

// 거리 출력
print("pointA와 pointB의 거리: \(distance)")
