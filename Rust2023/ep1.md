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

# 루프

loop , while, for 등이 있다.

```rust
loop {
    println!("Loop forever!");
}
```

무한루프를 이렇게 짤 수 있다.
while 는 일반적이다.

```rust
let mut x = 5; // mut x: i32
let mut done = false; // mut done: bool

while !done {
    x += x - 3;

    println!("{}", x);

    if x % 5 == 0 {
        done = true;
    }
}
```

Rust의 제어 흐름 분석은 이 구조를 a 와 다르게 취급합니다 while true. 이는 항상 반복된다는 것을 알고 있기 때문입니다. 일반적으로 우리가 컴파일러에 제공할 수 있는 정보가 많을수록 안전 및 코드 생성과 관련하여 더 나은 작업을 수행할 수 있으므로 loop무한 루프를 계획할 때 항상 선호해야 합니다.

for 루프

```rust
for (x = 0; x < 10; x++) {
    printf( "%d\n", x );
}
for x in 0..10 {
    println!("{}", x); // x: i32
}
for var in expression {
    code
}
```

expression 은 IntoIterator를 사용하여 반복자로 변환할 수 있는 항목입니다. 반복자는 일련의 요소를 반환합니다. 각 요소는 루프의 한 반복입니다. 그런 다음 해당 값은 루프 본문에 유효한 이름 var에 바인딩됩니다. 본문이 끝나면 반복자에서 다음 값을 가져오고 다른 시간을 반복합니다. 더 이상 값이 없으면 for 루프가 종료됩니다.

이 예에서 0..10은 시작 위치와 끝 위치를 취하고 해당 값에 대한 반복자를 제공하는 표현식입니다. 그러나 상한은 배타적이므로 루프는 10이 아닌 0에서 9까지 인쇄합니다.

Rust에는 일부러 "C 스타일" for 루프가 없습니다. 루프의 각 요소를 수동으로 제어하는 것은 숙련된 C 개발자에게도 복잡하고 오류가 발생하기 쉽습니다.

이미 반복한 횟수를 추적해야 하는 경우 .enumerate() 함수를 사용할 수 있습니다.

- 범위들

```rust
for (i,j) in (5..10).enumerate() {
    println!("i = {} and j = {}", i, j);
}
```

- 반복자

```rust
for (linenumber, line) in lines.enumerate() {
    println!("{}: {}", linenumber, line);
}
```

- 루프레이블
  중첩된 루프가 있고 break 또는 continue 문을 지정해야 하는 상황이 발생할 수도 있습니다. 대부분의 다른 언어와 마찬가지로 기본적으로 중단 또는 계속이 가장 안쪽 루프에 적용됩니다. 외부 루프 중 하나를 중단하거나 계속하려는 경우 레이블을 사용하여 중단 또는 계속 문이 적용되는 루프를 지정할 수 있습니다. 이것은 x와 y가 모두 홀수인 경우에만 인쇄됩니다.

```rust
'outer: for x in 0..10 {
    'inner: for y in 0..10 {
        if x % 2 == 0 { continue 'outer; } // continues the loop over x
        if y % 2 == 0 { continue 'inner; } // continues the loop over y
        println!("x: {}, y: {}", x, y);
    }
}
```
