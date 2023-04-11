## 반복문을 이용하여 여러 번의 추리 허용

loop 키워드는 무한루프를 제공합니다. 이것을 이용하여 사용자들에게 숫자를 추리할 기회를 더 줍니다.
```rust
extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1.. 101);

    println!("The secret number is: {}", secret_number);

    loop {
        println!("Please input your guess.");

        let mut guess = String::new();

        io::stdin().read_line(&mut guess)
            .expect("Failed to read line");

        let guess: u32 = guess.trim().parse()
            .expect("Please type a number!");

        println!("You guessed: {}", guess);

        match guess.cmp(&secret_number) {
            Ordering::Less    => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal   => println!("You win!"),
        }
    }
}
```
- 우리는 추리값을 입력 받는 코드부터 모든 코드들을 반복문 내로 옮겼습니다. 각각의 라인이 4간격 더 들여쓰기 되어 있음을 확실히 하고 프로그램을 다시 실행 해 보세요. 프로그램이 우리가 지시에 정확히 따르다보니 새로운 문제가 생긴 것을 확인하세요. 이제 프로그램이 영원히 다른 추리값을 요청합니다! 사용자가 이 프로그램을 종료할 수 없어요!

- 사용자는 ctrl-C 단축키를 이용하여 프로그램을 멈출 수 있습니다. 하지만 "비밀번호를 추리값과 비교하기"에서 parse 메소드에 대해 논의할 때 언급한 방법으로 이 만족할 줄 모르는 괴물에게서 빠져나올 수 있습니다. 만약 사용자가 숫자가 아닌 답을 적는다면 프로그램이 멈춥니다. 사용자는 프로그램 종료를 위해 다음처럼 이 장점을 활용할 수 있습니다.
```
$ cargo run
   Compiling guessing_game v0.1.0 (file:///projects/guessing_game)
     Running `target/guessing_game`
Guess the number!
The secret number is: 59
Please input your guess.
45
You guessed: 45
Too small!
Please input your guess.
60
You guessed: 60
Too big!
Please input your guess.
59
You guessed: 59
You win!
Please input your guess.
quit
thread 'main' panicked at 'Please type a number!: ParseIntError { kind: InvalidDigit }', src/libcore/result.rs:785
note: Run with `RUST_BACKTRACE=1` for a backtrace.
error: Process didn't exit successfully: `target/debug/guess` (exit code: 101)
```

- quit를 입력하면 게임은 확실히 끝나지만 다른 입력값들 또한 마찬가지 입니다. 하지만 이것은 최소한의 차선책입니다. 우리는 정답을 입력할 경우 자동으로 게임이 끝나도록 하고 싶습니다.

## 정답 이후에 종료하기
- 사용자가 정답을 맞췄을 때 게임이 종료되도록 break문을 추가합니다.
```rust
extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1, 101);

    println!("The secret number is: {}", secret_number);

    loop {
        println!("Please input your guess.");

        let mut guess = String::new();

        io::stdin().read_line(&mut guess)
            .expect("Failed to read line");

        let guess: u32 = guess.trim().parse()
            .expect("Please type a number!");

        println!("You guessed: {}", guess);

        match guess.cmp(&secret_number) {
            Ordering::Less    => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal   => {
                println!("You win!");
                break;
            }
        }
    }
}
```