# impl 예제

```rust
// 구조체 정의
struct Rectangle {
    width: u32,
    height: u32,
}

// 구조체에 대한 메서드 구현
impl Rectangle {
    // 메서드: 구조체의 넓이를 계산하는 함수
    fn calculate_area(&self) -> u32 {
        self.width * self.height
    }

    // 메서드: 구조체의 정보를 출력하는 함수
    fn display_info(&self) {
        println!("Width: {}, Height: {}", self.width, self.height);
    }
}

fn main() {
    // 구조체 인스턴스 생성
    let my_rectangle = Rectangle {
        width: 10,
        height: 20,
    };

    // 메서드 호출
    let area = my_rectangle.calculate_area();
    println!("Area: {}", area);

    my_rectangle.display_info();
}
```
- Rust에서 impl 키워드는 구조체(Structs), 열거형(Enums), 트레이트(Traits), 또는 다른 유형에 대한 메서드(Functions)나 특성(Implementations)을 정의할 때 사용됩니다. 이는 다른 언어에서의 클래스에 대한 메서드 정의와 유사한 역할을 합니다. impl은 구조체나 트레이트에 대한 메서드를 정의하는 데 사용되며, 이를 통해 해당 유형에 대한 동작을 구체화할 수 있습니다.

- 이 예제에서는 Rectangle이라는 구조체를 정의하고, 해당 구조체에 대한 두 개의 메서드를 impl 키워드를 사용하여 구현했습니다. calculate_area 메서드는 구조체의 넓이를 계산하고, display_info 메서드는 구조체의 정보를 출력합니다.

- 이러한 메서드를 사용하면 구조체에 대한 동작을 캡슐화하고, 코드를 보다 모듈화하고 가독성 있게 만들 수 있습니다.