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
- break문을 You win! 이후에 추가하여 사용자가 비밀번호를 맞췄을 때 프로그램이 반복문을 끝내도록 합니다. 반복문이 main의 마지막 부분이므로 반복문의 종료는 프로그램의 종료를 의미합니다.

## 잘못된 입력값 처리하기
- 사용자가 숫자가 아닌 값을 입력했을 때 프로그램이 종료되는 동작을 더 다듬어 숫자가 아닌 입력은 무시하여 사용자가 계속 입력할 수 있도록 해 봅시다. guess가 String에서 u32로 변환되는 라인을 수정하면 됩니다.

```rust
let guess: u32 = match guess.trim().parse() {
    Ok(num) => num,
    Err(_) => continue,
};
```
- expect 메소드 호출을 match 표현식으로 바꾸는 것은 에러 발생 시 종료에서 처리 로 바꾸는 일반적인 방법입니다. parse 메소드가 Result 타입을 돌려주는 것과 Result는 Ok나 Err variants를 가진 열거형임을 떠올리세요. cmp 메소드의 Ordering 결과를 처리했을 때처럼 여기서 match 표현식을 사용하고 있습니다.

- 만약 parse가 성공적으로 문자열에서 정수로 변환했다면 결과값을 가진 Ok 를 돌려줍니다. Ok는 첫번째 arm의 패턴과 매칭하게 되고 match 표현식은 parse 가 생성한 num값을 돌려줍니다. 그 값은 우리가 생성하고 있던 새로운 guess 과 묶이게 됩니다.

- 만약 parse가 문자열을 정수로 바꾸지 못했다면 에러 정보를 가진 Err를 돌려줍니다. Err는 첫번째 arm의 패턴인 Ok(num)과 매칭하지 않지만 두 번째 arm의 Err(_) 와 매칭합니다. _은 모든 값과 매칭될 수 있습니다. 이 예시에서는 Err내에 무슨 값이 있던지에 관계없이 모든 Err를 매칭하도록 했습니다. 따라서 프로그램은 두 번째 arm의 코드인 continue를 실행하며, 이는 loop의 다음 반복으로 가서 또 다른 추리값을 요청하도록 합니다. 효율적으로 프로그램은 parse에서 가능한 모든 에러를 무시합니다.

- 이제 우리가 원하는대로 프로그램이 작동해야 합니다. cargo run을 실행해 봅시다.

```
$ cargo run
   Compiling guessing_game v0.1.0 (file:///projects/guessing_game)
     Running `target/guessing_game`
Guess the number!
The secret number is: 61
Please input your guess.
10
You guessed: 10
Too small!
Please input your guess.
99
You guessed: 99
Too big!
Please input your guess.
foo
Please input your guess.
61
You guessed: 61
You win!
```