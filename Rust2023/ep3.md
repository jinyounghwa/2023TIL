# Enums
- Rust는 Java 또는 Kotlin과 같은 열거형을 지원하지만 더 유연합니다. Rust 열거형은 단순히 상수 목록이 아니라 공용체에 더 가깝기 때문에 C++ 또는 TypeScript보다 더 많은 것을 제공합니다.
(아래는 자바 예제)  
```java
enum UserRole {
    RO("read-only"), USER("user"),
    ADMIN("administrator");

    private final String name;

    UserRole(String name) {
        this.name = name;
    }

    String getName() {
        return name;
    }

    boolean isAccessAllowed(String httpMethod) {
        switch (httpMethod) {
            case "HEAD":
            case "GET":
                return true;

            case "POST":
            case "PUT":
                return this == USER || this == ADMIN;

            case "DELETE":
                return this == ADMIN;

            default:
                return false;
        }
    }
}

class Main {
    public static void main(String[] args) {
        UserRole role = UserRole.RO;
        if (role.isAccessAllowed("POST")) {
            System.out.println("OK: "
                + role.getName());
        } else {
            System.out.println("Access denied: "
                + role.getName());
        }
    }
}
```
```rust
[derive(PartialEq)]
enum UserRole {
    RO,
    USER,
    ADMIN,
}

impl UserRole {
    fn name(&self) -> &str {
        match *self {
            UserRole::RO => "read-only",
            UserRole::USER => "user",
            UserRole::ADMIN => "administrator",
        }
    }

    fn is_access_allowed(
        &self,
        http_method: &str,
    ) -> bool {
        match http_method {
            "HEAD" | "GET" => true,
            "POST" | "PUT" => {
                *self == UserRole::USER
                    || *self == UserRole::ADMIN
            }
            "DELETE" => *self == UserRole::ADMIN,
            _ => false,
        }
    }
}

fn main() {
    let role = UserRole::RO;
    if role.is_access_allowed("POST") {
        println!("OK: {}", role.name());
    } else {
        println!("Access denied: {}", role.name());
    }
}
```
- Rust는 열거형에서 상수를 지원하지 않으므로 name 메서드에서 mathch 항목을 사용해야 합니다. enum matches는 컴파일 타임에 확인되므로 모든 열거형 변형이 사용되면 기본 분기가 필요하지 않습니다.  
# Ownership 
- Rust의 매우 특별한 한 가지는 메모리 할당을 처리하는 방식입니다. Rust에는 가비지 컬렉터(JavaScript, Java 또는 Go와 같은)가 없지만 개발자는 명시적으로 메모리를 해제할 필요가 없습니다(C에서와 같다.). 대신 Rust는 메모리가 더 이상 사용되지 않을 때 자동으로 메모리를 해제합니다. 이 메커니즘이 작동하려면 개발자는 프로그램이 사용하는 값의 소유권에 대해 명시적으로 생각해야 합니다.  
(아래는 자바의 예시)
```java
class User {
    private String name;

    public User(String name) {
        this.name = name;
    }
}

public static void main(String[] args) {
    String name = "User";

    User user1 = new User(name);
    User user2 = new User(name);
}
```
```rust
struct User {
    name: String,
}

fn main() {
    let name = String::from("User");

    let user1 = User { name };
    let user2 = User { name }; // compile error
}
```
- Java에서 가비지 수집기는 개체 참조를 정기적으로 확인하고 더 이상 User 인스턴스를 참조하는 항목이 없으면 삭제됩니다. 두 인스턴스가 모두 사용되지 않은 것으로 감지되면 "사용자" 문자열도 삭제할 수 있습니다.  

- Rust에서 값은 한 번에 하나의 객체만 소유할 수 있습니다. user1에 대한 할당은 괜찮습니다. 값이 name 변수에서 user1로 이동되기 때문입니다. 그러나 user2를 만들면 컴파일 오류가 발생합니다. 문자열 "User"는 이제 이름이 아니라 user1이 소유하기 때문입니다.  

- C에서 개발자는 할당된 메모리가 더 이상 필요하지 않을 때 해제되었는지 확인해야 합니다. 이것은 버그(메모리 누수)로 이어질 수 있으며 Rust의 메모리 관리에 대한 다른 접근 방식의 동기 중 하나였습니다. Rust는 이에 대한 보호 기능을 제공하지만 메모리 누수가 발생하는 것이 불가능한 것은 아닙니다.  
(아래는 C++ 예시)
```c++
#include <string>

std::string* get_string() {
    std::string* string = new std::string("hello");

    delete string;

    return string;
}
```
```rust
fn get_string() -> String {
    let string = String::from("hello");

    drop(string);

    return string; // compile error!
}
```
- 이 예에서 C++ 코드는 사용 후 무료 오류가 있습니다. 이것은 예시일 뿐이며, Rust 코드에서는 drop이 거의 사용되지 않습니다(값이 범위를 벗어나면 자동으로 삭제됨)  

- Rust의 소유권 모델은 멀티스레드 코드를 다룰 때도 도움이 됩니다. 컴파일러는 프로그램이 사용하는 값을 추적하고 적절한 잠금 논리 없이 여러 스레드에서 동일한 값에 액세스하지 않도록 합니다.  
(아래는 C++ 예시)
```c++
#include <vector>
#include <thread>

int main() {
    std::vector<std::string> list;

    auto f = [&list]() {
        for (int i = 0; i < 10000; i++) {
            list.push_back("item 123");
        }
    };

    std::thread t1(f);
    std::thread t2(f);

    t1.join();
    t2.join();
}
```
```rust
use std::thread;

fn main() {
    let mut list = vec![];

    let f = move || {
        for _ in 0..10000 {
            list.push("item 123");
        }
    };

    let t1 = thread::spawn(f);
    let t2 = thread::spawn(f); // compile error!

    t1.join().unwrap();
    t2.join().unwrap();
}
```
- std::vector 클래스는 스레드로부터 안전하지 않으며 C++ 프로그램은 오류 없이 컴파일되지만 실행할 때 해제되는 포인터가 할당되지 않았거나 유사한 오류와 함께 충돌할 수 있습니다. Rust에서 클로저 f는 목록(move 키워드로 표시됨)의 소유권을 가지므로 f가 두 번 이상 사용될 때 컴파일러에서 오류가 발생합니다.  

# Strings
- Rust에는 여러 문자열 유형이 있으며 가장 중요한 유형은 str(보통 &str 형식)과 문자열입니다.  

- &str 유형은 빌린 콘텐츠만 참조하므로 정적 문자열과 문자열 조각을 참조할 때 사용되는 유형입니다. 다른 불변 참조와 마찬가지로 &str 값은 수정할 수 없습니다. 수정 가능한 문자열이 필요한 경우 문자열을 사용하십시오.  
(아래는 자바스크립트 예시)
```javascript
const FILE_DATE = "2020-01-01";

function printCopyright() {
  const year = FILE_DATE.substr(0, 4);
  const copyright = `(C) ${year}`;
  console.log(copyright);
}
```
```rust
const FILE_DATE: &str = "2020-01-01";

fn print_copyright() {
    let year: &str = &FILE_DATE[..4];
    let copyright: String = format!("(C) {}", year);
    println!("{}", copyright);
}
```
- String 유형은 동적으로 생성된 문자열에 사용되며 수정할 수 있고 길이가 컴파일 시간에 고정되지 않습니다.  
- 일반적으로 &str은 함수 매개변수로 사용되고 String은 반환 값으로 사용됩니다.
(아래는 자바의 예시)
```java
public static String repeat(String s, int count) {
    StringBuilder result = new StringBuilder();
    for (int i = 0; i < count; i++) {
        result.append(s);
    }
    return result.toString();
}
```
```rust
fn repeat(s: &str, count: u32) -> String {
    let mut result = String::new();
    for _ in 0..count {
        result += s;
    }
    result
}
```
- 구조체 필드의 경우 일반적으로 문자열을 사용해야 합니다. 특히 더 오래 사는 개체를 처리할 때 해당 구조체가 값을 소유할 가능성이 높기 때문입니다.  

- 문자열 상수의 경우 필드에 &'static str을 대신 사용할 수 있습니다.  
```kotlin
data class User(
    private val source: String,
    private val name: String,
    private val address: String
) {
    companion object {
        fun fromString(string: String): User {
            val lines = string.lines()
            return User("kotlin-v1.0", lines[0],
                lines[1])
        }
    }
}
```
```rust
pub struct User {
    source: &'static str,
    name: String,
    address: String,
}

impl User {
    pub fn new(s: &str) -> User {
        let mut lines = s.lines();
        User {
            source: "rust-v1.0",
            name: lines.next().unwrap().to_owned(),
            address: lines.next().unwrap().to_owned(),
        }
    }
}
```
- 문자열 유형의 변수 s1을 &str로 변환하려면 &s1을 사용하십시오.  

- &str 유형의 변수 s2를 문자열로 변환하려면 s2.to_owned()를 사용합니다(이는 새 메모리를 할당하고 문자열의 복사본을 생성함). 때때로 이 변환은 "문자열 리터럴".to_owned()와 같은 리터럴에도 필요합니다.  
