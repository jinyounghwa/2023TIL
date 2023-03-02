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

# 내장함수 (inner function)

```js
const RE = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;

function isValidRange(start, end) {
  function isValid(date) {
    return date && date.match(RE);
  }

  return isValid(start) && isValid(end);
}
```

```rust
use regex::Regex;

const RE: &str = r"^[0-9]{4}-[0-9]{2}-[0-9]{2}$";

fn is_valid_range(start: &str, end: &str) -> bool {
    fn is_valid(date: &str) -> bool {
        !date.is_empty()
            && Regex::new(RE)
                .unwrap()
                .is_match(date)
    }

    is_valid(start) && is_valid(end)
}
```

- 자바스크립트와 달리 사용하는 선언과 타입을 명확하게 해야 한다.

# Extension methods

- 왠지 코틀린 스럽다. 이 부분은

```kotlin
typealias Range = Pair<String, String>

fun Range.isValid(): Boolean {
    val (start, end) = this
    return start.isNotEmpty() && end.isNotEmpty()
}

object Main {
    @JvmStatic
    fun main(args: Array<String>) {
        val range = Range("2020-01-01", "2020-12-31")
        if (range.isValid()) {
            println("Range is valid!")
        }
    }
}
```

```rust
type Range<'r> = (&'r str, &'r str);

trait IsValid {
    fn is_valid(&self) -> bool;
}

impl<'r> IsValid for Range<'r> {
    fn is_valid(&self) -> bool {
        let (start, end) = &self;
        !start.is_empty() && !end.is_empty()
    }
}

fn main() {
    let range = ("2020-01-01", "2020-12-31");
    if range.is_valid() {
        println!("Range is valid!");
    }
}
```

- Rust에서는 특성을 구현하여 확장 메서드를 추가합니다. 메서드가 하나뿐인 경우 메서드(IsValid)와 같이 트레이트의 이름을 지정하는 것이 일반적입니다. 'r은 수명을 나타냅니다.

# Closer

- Rust는 클로저(다른 언어에서는 Lambdas, 화살표 함수 또는 익명 함수라고도 함)를 지원합니다.

- 클로저 외부에서 변수에 액세스할 때 Rust는 JavaScript 또는 Java보다 더 엄격합니다. 자세한 내용은 캡처를 참조하세요.

```js
function findEmails(list) {
  return list.filter((s) => s && s.includes("@"));
}
```

```rust
fn find_emails(list: Vec<String>) -> Vec<String> {
    list.into_iter()
        .filter(|s| s.contains("@"))
        .collect()
}
```

# Expressions

- Rust에서는 거의 모든 것이 Kotlin과 마찬가지로 JavaScript나 Java와 다른 표현식입니다. 예를 들어 if 문의 결과를 변수에 직접 할당할 수 있습니다.

```js
function getLogLevel() {
  let level = process.env.TRACE
    ? "trace"
    : process.env.DEBUG
    ? "debug"
    : "info";

  level = level === "trace" ? 0 : level === "debug" ? 1 : 2;

  console.log("using log level", level);

  return level;
}
```

```rust
fn get_log_level() -> u32 {
    let level = if std::env::var("TRACE").is_ok() {
        "trace"
    } else if std::env::var("DEBUG").is_ok() {
        "debug"
    } else {
        "info"
    };

    let level = match level {
        "trace" => 0,
        "debug" => 1,
        _ => 2,
    };

    println!("using log level {}", level);

    level
}
```

- Rust 코드는 일치를 사용하는데, 이는 표현식이고 더 많은 유연성을 제공한다는 점을 제외하면 Java 또는 JavaScript의 스위치와 같습니다. 다른 많은 언어가 아니라면 Rust는 지역 변수(이 예에서는 레벨)에 대한 변수 섀도잉을 허용합니다.
