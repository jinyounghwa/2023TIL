# 함수

- 함수는 기본적으로 C, Java, Go 또는 TypeScript와 동일합니다. 함수에는 이름, 0개 이상의 매개변수 및 반환 유형이 있습니다.

```C
void log(char* message) {
    printf("INFO %s\n", message);
}
```

```rust
fn log(message: &str) -> () {
    println!("INFO {}", message);
}
```

- 단위 유형()(일부 언어에서는 무효)은 함수에 유형이 지정되지 않은 경우 기본 반환 유형입니다. 이 예에서는 fn log(message: &str) { ... } 와 같이 생략할 수 있습니다.

- Rust에서 함수는 표현식입니다. 즉, Ruby에서처럼 마지막 명령문이 반환 값이기도 합니다. 이것은 암시적 반환과 비슷하지만 정확히는 아닙니다. 공식 스타일은 조기 반환에만 반환을 사용하는 것입니다.

```java
public static int add(int a, int b) {
    return a + b;
}
```

```rust
fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

- Rust 함수에는 세미콜론이 없습니다. 특별하지 않다면 void를 반환합니다.

- Rust에는 현재 명명된 인수나 기본 인수(Python 및 TypeScript와 같은)가 없으며 메서드 오버로드(C++, Java 또는 TypeScript와 같은)를 허용하지 않습니다.
