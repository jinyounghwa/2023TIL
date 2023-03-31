# 추리값을 처리하기

다음 코드를 입력해서 결과값을 확인 해 보자
```rust
use std::io;

fn main() {
    println!("Guess the number!");

    println!("Please input your guess.");

    let mut guess = String::new();

    io::stdin().read_line(&mut guess)
        .expect("Failed to read line");

    println!("You guessed: {}", guess);
}
```
- std:: io - 입/출력 작업을 위한 정의 및 기능. 이라는 걸 이전 시간에 배웠다.
- 결과값을 표기하기 위해  i/o라이브러리를 스코프로 가져와야 한다.