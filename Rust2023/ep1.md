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

# 쉐도잉

let 키워드를 남발 할 수 있다. (재선언 가능)

```rust
fn main() {
    let x = 5; // < - 1

    let x = x + 1; // < - 2

    {
        let x = x * 2; // < - 3
        println!("The value of x in the inner scope is: {x}");
    }

    println!("The value of x is: {x}");
}
```

# 변수의 타입을 보존한다.

- 변수의 기본 타입이 특별한 게 많다.
  https://www.codingame.com/playgrounds/365/getting-started-with-rust/primitive-data-types

```java
int i = 123;
long l = 456L;

float f = 0.5f;
double d = 0.5;

String string = "Hello";

int[] arr = {1, 2, 3};

List<Integer> list = Arrays.asList(1, 2, 3);
```

자바가 이런 느낌이라면

```rust
let i: i32 = 123;
let l: i64 = 456;

let f: f32 = 0.5;
let d: f64 = 0.5f64;

let string: &str = "Hello";

let arr: [i32; 3] = [1, 2, 3];

let list: Vec<i32> = vec![1, 2, 3];
```

러스트는 이런 느낌이다.  
왠지 타입스크립트 느낌도 나면서 조금 특별한것 같기도 하다.  
void 유형은 unit라고 하며 ()으로 표시된다. (나중에 더 자세히 설명하겠다.)

# 불변성

JS(const and let) , Kotlin (val and var) 과 비슷한 느낌이다. (완전히 같다는 게 아니다.)

```TS
let arr1: string[] = [];
arr1.push("123"); // OK
arr1 = ["a", "b"]; // OK

const arr2: string[] = [];
arr2.push("123"); // OK, even though arr2 is const
arr2 = []; // error, arr2 is const
```

```rust
let mut arr1 = vec![];
arr1.push("123"); // OK
arr1 = vec!["a", "b"]; // OK

let arr2 = vec![];
arr2.push("123"); // error, arr2 is not mutable
arr2 = vec![]; // error, arr2 is not mutable
```
