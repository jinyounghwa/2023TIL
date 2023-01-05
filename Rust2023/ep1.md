# 러스트의 변수

```rust
fn main() {
    let mut x = 5;
    println!("The value of x is: {x}");
    x = 6;
    println!("The value of x is: {x}");
}
```

러스트의 변수는 mut 로 선언하지 않으면 immutable 하지 않다.  
Rust 는 cago run을 사용한다.
IDE는 인텔리제이를 사용한다. 윈도우에서 C++ 관련 설치 안하려고 한다.

타입스크립트 상수 선언과 다르다. 아래를 확인하자.

```rust
const THREE_HOURS_IN_SECONDS: u32 = 60 * 60 * 3;
```

rust 는 main.rs 형식의 확장자를 가지며 자바처럼 fn main() 함수로 실행한다.
