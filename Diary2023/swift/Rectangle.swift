// Rectangle 구조체
struct Rectangle {
    var leftTop: MyPoint
    var rightBottom: MyPoint

    // 초기화 함수
    init() {
        leftTop = MyPoint(x: 0, y: 0)
        rightBottom = MyPoint(x: 0, y: 0)
    }

    // 4개 꼭지점 좌표 출력
    func printPoints() -> String {
        return """
        (x=\(leftTop.myX), y=\(leftTop.myY))
        (x=\(rightBottom.myX), y=\(rightBottom.myY))
        (x=\(leftTop.myX), y=\(rightBottom.myY.myY))
        (x=\(rightBottom.myX), y=\(leftTop.myY))
        """
    }

    // 추가 초기화 함수
    init(origin: MyPoint, width: Float, height: Float) {
        leftTop = origin
        rightBottom = MyPoint(x: origin.myX + width, y: origin.myY + height)
    }

    // moveTo() 메서드
    func moveTo(delta: MyPoint) {
        leftTop.myX += delta.myX
        leftTop.myY += delta.myY
        rightBottom.myX += delta.myX
        rightBottom.myY += delta.myY
    }
}

// Rectangle 구조체 인스턴스 선언
let rectA = Rectangle()
let rectB = Rectangle(origin: MyPoint(x: 5, y: 5), width: 5, height: 10)

// Rectangle 좌표 출력
print(rectA.printPoints())
print(rectB.printPoints())

// rectB 이동
rectB.moveTo(delta: MyPoint(x: -3, y: 1.5))
print(rectB.printPoints())
