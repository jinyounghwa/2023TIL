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