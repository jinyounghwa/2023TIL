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
  
- ::new 에 있는 :: 는 new 가 String 타입의 연관함수임을 나타낸다. 연관함수는 하나의 타입을 위한 함수이며 이 경우에는 하나의 String인스턴스가 아니라 String타입을 위한 함수입니다. 몇몇 언어에서는 이것을 정적 메소드라고 부른다.
- new 함수는 새로운 빈 String을 생성합니다. new 함수는 새로운 값을 생성하기 위한 일반적인 이름이므로 많은 타입에서 찾아볼 수 있습니다.
- 요약하자면 `let mut guess = String::new();`라인은 새로운 빈 String인스턴스와 연결된 가변변수를 생성합니다.
- 프로그램의 첫번째 라인에 `use std::io`를 이용하여 표준 라이브러리의 input/output 기능을 포함한 것을 떠올려 보세요 이제 우리는 io의 연관함수인 stdin을 호출합니다.
```rust
io::stdin().read_line(&mut guess)
    .expect("Fail to read line");
```
- 만약 프로그램의 시작점에 `use std::io`가 없다면 함수 호출 시 `std::io::stdin`처럼 작성해야 합니다. stdin 함수 터미널의 표준 입력의 핸들(handle)의 타입인 `std::io::Stdin`의 인스턴스를 돌려줍니다.
- 코드의 다음 부분인 `read_line(&mut guess)`는 사용자로부터 입력을 받기 위해 표준 입력 핸들에서 `.read_line(&mut guess)`메소드를 호출합니다. 또한`read_line`에 &mut guess를 인자로 하나 남깁니다.
- read_line은 사용자가 표준 입력에 입력할 때마다 입력된 문자륻을 하나의 문자열에 저장하므로 인자로 값을 저장할 문자열이 필요합니다. 그 문자열 인자는 사용자 입력을 추가하면서 변경되므로 가변이어야 합니다.
- & 는 코드의 여러 부분에서 데이터를 여러 번 메모리로 복사하지 않고 접근하기 위한 방법을 제공하는 참조자임을 나타냅니다. 참조자는 복잡한 특성으로서 러스트의 큰 이점 중 하나가 참조자를 사용함으로써 얻는 안전성과 용이성이다. 이 프로그램을 작성하기 위해 참조자의 자세한 내용을 알 필요는 없습니다. 4장에서 참조자에 대해 전체적으로 설명할 것입니다. 지금 당장은 참조자가 변수처럼 기본적으로 불면임을 알기만 하면 됩니다. 따라서 가변으로 바꾸기 위해 &guess가 아니라 &mut guess 로 작성해야 합니다.
- 아직 이 라인에 대해 다 설명하지 않았습니다. 한 라인처럼 보이지만 사실은 이 라인과 논리적으로 연결된 라인이 더 있습니다. 두번째 라인은 다음 메소드입니다.

```rust
.expect("Failed to read line");
```
- .foo() 형태의 문법으로 메소드를 호출할 경우 긴 라인을 나누기 위해 다음 줄과 여백을 넣는 것이 바람직합니다. 위 코드를 아래처럼 쓸 수도 있습니다.

```rust
io::stdin().read_line(&mut guess).expect("Failed to read line");
```
하지만 하나의 긴 라인은 가독성이 떨어지므로 두 개의 메소드 호출을 위한 라인으로 나누는것이 좋습니다. 이제 이 라인이 무엇인지 대해 이야기 해봅시다.  

## Result 타입으로 잠재된 실패 다루기
- 이전에 언급한 것처럼 `read_line`은 우리가 인자로 넘긴 문자열에 사용자가 입력을 저장할 뿐 아니라 하나의 값을 돌려 줍니다. 여기서 돌려준 값은 `io::Result`입니다. 러스트는 표둔 라이브러리에 여러 종류의 `Result`타입을 가지고 있습니다. 제네릭`Result`이나 `io::Result`가 그 예시입니다.  
- Result 타입은 열거형(enumerations)로써 enums 라고 부르기도 합니다. 열거형은 정해진 값들만을 가질 수 있으며 이러한 값들은 열거형의 variants 라고 부릅니다. 6장에서 열거형에 대해 더 자세히 다룹니다.

- Result의 variants는 Ok와 Err입니다. Ok는 처리가 성공했음을 나타내며 내부적으로 성공적으로 생성된 결과를 가지고 있습니다. Err는 처리가 실패했음을 나타내고 그 이유에 대한 정보를 가지고 있습니다.

- 이러한 Result는 에러 처리를 위한 정보를 표현하기 위해 사용됩니다. Result 타입의 값들은 다른 타입들처럼 메소드들을 가지고 있습니다. `io::Result` 인스턴스는 expect 메소드를 가지고 있습니다. 만약 `io::Result` 인스턴스가 Err일 경우 expect 메소드는 프로그램이 작동을 멈추게 하고 expect에 인자로 넘겼던 메세지를 출력하도록 합니다. 만약 `read_line` 메소드가 Err를 돌려줬다면 그 에러는 운영체제로부터 생긴 에러일 경우가 많습니다. 만약 `io::Result`가 Ok 값이라면 expect는 Ok가 가지고 있는 결과값을 돌려주어 사용할 수 있도록 합니다. 이 경우 결과값은 사용자가 표준 입력으로 입력했던 바이트의 개수입니다.

- 만약 expect를 호출하지 않는다면 컴파일은 되지만 경고가 나타납니다.  

```
$ cargo build
   Compiling guessing_game v0.1.0 (file:///projects/guessing_game)
warning: unused `std::result::Result` which must be used
  --> src/main.rs:10:5
   |
10 |     io::stdin().read_line(&mut guess);
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: #[warn(unused_must_use)] on by default
```
- 러스트는 read_line가 돌려주는 Result 값을 사용하지 않았음을 경고하며 일어날 수 있는 에러를 처리하지 않았음을 알려줍니다. 이 경고를 없애는 옳은 방법은 에러를 처리하는 코드를 작성하는 것이지만 만약 문제가 발생했을 때 프로그램이 멈추길 바란다면 expect를 사용할 수 있습니다. 9장에서 에러가 발생했을 때 이를 처리하는 방법에 대해 배웁니다.

## println! 변경자(placeholder)를 이용한 값 출력

- 지금까지 작성한 코드에서 닫는 중괄호 말고도 살펴봐야 하는 코드가 하나 더 있습니다. 내용은 아래와 같습니다.

```rust
println!("You guessed: {}", guess);
```
- 이 라인은 사용자가 입력한 값을 저장한 문자열을 출력합니다. {}는 변경자로써 값이 표시되는 위치를 나타냅니다. {}를 이용하여 하나 이상의 값을 표시할 수도 있습니다. 첫번째 {}는 형식 문자열(format string) 이후의 첫번째 값을 표시하며, 두번째 {}는 두번째 값을 나타내며 이후에도 비슷하게 작동합니다. 다음 코드는 println!을 이용하여 여러 값을 표시하는 방법을 보여줍니다.

```rust
let x = 5;
let y = 10;

println!("x = {} and y = {}", x, y);
```
- 이 코드는 x = 5 and y = 10 을 출력합니다.

## 첫번째 부분을 테스트 하기
- 추리 게임의 처음 부분을 테스트 해봅시다. cargo run 을 통해 실행 할 수 있습니다.

```
$ cargo run
   Compiling guessing_game v0.1.0 (file:///projects/guessing_game)
    Finished dev [unoptimized + debuginfo] target(s) in 2.53 secs
     Running `target/debug/guessing_game`
Guess the number!
Please input your guess.
6
You guessed: 6
```
  
- 지금까지 게임의 첫번째 부분을 작성했습니다. 우리는 입력값을 받고 그 값을 출력했습니다.
---
## 비밀번호를 생성하기
- 다음으로 사용자가 추리하기 위한 비밀번호를 생성해야 합니다. 게임을 다시 하더라도 재미있도록 비밀번호는 매번 달라야 합니다. 게임이 너무 어렵지 않도록 1에서 100 사이의 임의의 수를 사용합시다. 러스트는 아직 표준 라이브러리에 임의의 값을 생성하는 기능이 없습니다. 하지만 러스트 팀에서는 rand 크레이트를 제공합니다.

### 크레이트(Crate)를 사용하여 더 많은 기능 가져오기
- 크레이트는 러스트 코드의 묶음(package)임을 기억하세요. 우리가 만들고 있는 프로젝트는 실행이 가능한 binary crate 입니다. rand crate는 다른 프로그램에서 사용되기 위한 용도인 library crate 입니다.

- Cargo에서 외부 크레이트의 활용이 정말 멋진 부분입니다. rand를 사용하는 코드를 작성하기 전에 Cargo.toml 을 수정하여 rand 크레이트를 의존 리스트에 추가해야 합니다. 파일을 열고 Cargo가 여러분을 위해 생성한 [dependencies] 절의 시작 바로 아래에 다음 내용을 추가하세요.

- Filename: Cargo.toml

```
[dependencies]

rand = "0.3.14"
```
- 여러분은 다른 버전명이나 라인의 순서가 다르게 보일 수 있습니다. 버전명이 다르더라도 SemVer 덕분에 현재 코드와 호환될 것입니다.

- 이제 우리는 외부 의존성을 가지게 되었고, Cargo는 Crates.io 데이터의 복사본인 레지스트리(registry) 에서 모든 것들을 가져옵니다. Crates.io는 러스트의 생태계의 개발자들이 다른 사람들도 이용할 수 있도록 러스트 오픈소스를 공개하는 곳입니다.

- 레지스트리를 업데이트하면 Cargo는 [dependencies] 절을 확인하고 아직 여러분이 가지고 있지 않은 것들을 다운 받습니다. 이 경우 우리는 rand만 의존한다고 명시했지만 rand는 libc에 의존하기 때문에 libc도 다운 받습니다. 러스트는 이것들을 다운받은 후 컴파일 하여 의존성이 해결된 프로젝트를 컴파일합니다.

- 만약 아무것도 변경하지 않고 cargo build를 실행한다면 어떠한 결과도 얻지 못합니다. Cargo는 이미 의존 패키지들을 다운받고 컴파일했음을 알고 있고 여러분이 Cargo.toml 를 변경하지 않은 것을 알고 있습니다. 또한 Cargo는 코드가 변경되지 않은 것도 알고 있기에 코드도 다시 컴파일하지 않습니다. 아무것도 할 일이 없기에 그냥 종료될 뿐입니다. 만약 여러분이 src/main.rs 파일을 열어 사소한 변경을 하고 저장한 후 다시 빌드를 한다면 한 라인이 출력됨을 확인할 수 있습니다.

```
$ cargo build
   Compiling guessing_game v0.1.0 (file:///projects/guessing_game)
```
- 이 라인은 Cargo가 src/main.rs 의 사소한 변경을 반영하여 빌드를 업데이트 했음을 보여줍니다. 의존 패키지가 변경되지 않았으므로 Cargo는 이미 다운받고 컴파일된 것들을 재사용할 수 있음을 알고 있습니다. 따라서 Cargo는 여러분의 코드에 해당하는 부분만을 다시 빌드합니다.

## 재현 가능한 빌드를 보장하는 Cargo.lock
- Cargo는 여러분뿐만이 아니라 다른 누구라도 여러분의 코드를 빌드할 경우 같은 산출물이 나오도록 보장하는 방법을 가지고 있습니다. Cargo는 여러분이 다른 의존성을 추가하지 전까지는 여러분이 명시한 의존 패키지만을 사용합니다. 예로 rand 크레이트의 다음 버전인 v0.3.15에서 중요한 결함이 고쳐졌지만 당신의 코드를 망치는 변경점(regression) 이 있다면 어떻게 될까요?

- 이 문제의 해결책은 여러분이 처음 cargo build를 수행할 때 생성되어 이제 guessing_game 디렉토리 내에 존재하는 Cargo.lock 입니다. 여러분이 처음 프로젝트를 빌드할 때 Cargo는 기준을 만족하는 모든 의존 패키지의 버전을 확인하고 Cargo.lock 에 이를 기록합니다. 만약 여러분이 미래에 프로젝트를 빌드할 경우 Cargo는 모든 버전들을 다시 확인하지 않고 Cargo.lock 파일이 존재하는지 확인하여 그 안에 명시된 버전들을 사용합니다. 이는 여러분이 재현가능한 빌드를 자동으로 가능하게 합니다. 즉 여러분의 프로젝트는 Cargo.lock 덕분에 당신이 명시적으로 업그레이드하지 않는 이상 0.3.14를 이용합니다.

## 크레이트를 새로운 버전으로 업그레이드하기
- 만약 당신이 정말 크레이트를 업데이트하고 싶은 경우를 위해 Cargo는 update 명령어를 제공합니다. 이것은 Cargo.lock 파일을 무시하고 Cargo.toml 에 여러분이 명시한 요구사항에 맞는 최신 버전을 확인합니다. 만약 이 버전들로 문제가 없다면 Cargo는 해당 버전을 Cargo.lock 에 기록합니다.

- 하지만 Cargo는 기본적으로 0.3.0보다 크고 0.4.0보다 작은 버전을 찾을 것입니다. 만약 rand 크레이트가 새로운 두 개의 버전인 0.3.15와 0.4.0을 릴리즈했다면 여러분이 cargo update를 실행했을 때 다음의 메세지를 볼 것입니다.

```
$ cargo update
    Updating registry `https://github.com/rust-lang/crates.io-index`
    Updating rand v0.3.14 -> v0.3.15
```
- 이 시점에 여러분은 Cargo.lock 파일에서 변경이 일어난 것과 앞으로 사용될 rand 크레이트의 버전이 0.3.15임을 확인할 수 있습니다.

- 만약 여러분이 0.4.0이나 0.4.x에 해당하는 모든 버전을 받고 싶다면 Cargo.toml 을 다음과 같이 업데이트해야 합니다.
```
[dependencies]

rand = "0.4.0"
```
- 다음번에 여러분이 cargo build를 실행하면 Cargo는 가용 가능한 크레이트들의 레지스트리를 업데이트할 것이고 여러분의 rand 요구사항을 새롭게 명시한 버전에 따라 재계산할 것입니다.

- Cargo와 그의 생태계에 대해 더 많은 것들은 14장에서 다뤄지지만 지금 당장은 이 정도만 알면 됩니다. Cargo는 라이브러리의 재사용을 쉽게 하여 러스트 사용자들이 많은 패키지들과 결합된 더 작은 프로젝트들을 작성할 수 있도록 도와줍니다.

## 임의의 숫자를 생성하기
- 이제 rand를 사용 해 봅시다. 다음 단계는 src/main.rs 를 Listing 2-3처럼 업데이트하면 됩니다.

- Filename: src/main.rs
```rust
extern crate rand;

use std::io;
use rand::Rng;

fn main() {
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1.. 101);

    println!("The secret number is: {}", secret_number);

    println!("Please input your guess.");

    let mut guess = String::new();

    io::stdin().read_line(&mut guess)
        .expect("Failed to read line");

    println!("You guessed: {}", guess);
}
```
- 우리는 extern crate rand;을 추가하여 러스트에게 우리가 외부에 의존하는 크레이트가 있음을 알립니다. 이 라인은 use rand으로도 표기할 수 있으며 이제 우리는 rand::를 앞에 붙여 rand내의 모든 것을 호출할 수 있습니다.

- 다음으로 우리는 또 다른 use 라인인 use rand::Rng를 추가합니다. Rng는 정수 생성기가 구현한 메소드들을 정의한 trait이며 해당 메소드들을 이용하기 위해서는 반드시 스코프 내에 있어야 합니다. 10장에서 trait에 대해 더 자세히 다룰 것입니다.

- 또한 우리는 중간에 두 개의 라인을 추가합니다. rand::thread_rng 함수는 OS가 시드(seed)를 정하고 현재 스레드에서만 사용되는 특별한 정수생성기를 돌려 줍니다. 다음으로 우리는 get_range 메소드를 호출합니다. 이 메소드는 Rng trait에 정의되어 있으므로 use rand::Rng 문을 통해 스코프로 가져올 수 있습니다. gen_range 메소드는 두 개의 숫자를 인자로 받고 두 숫자 사이에 있는 임의의 숫자를 생성합니다. 하한선은 포함되지만 상한선은 제외되므로 1부터 100 사이의 숫자를 생성하려면 1과 101을 넘겨야 합니다.

- 크레이트에서 어떤 trait를 사용하고 어떤 함수나 메소드들을 호출하는 것을 아는 것은 단순히 아는 것 이 아닙니다. 각각의 크레이트의 문서에서 사용 방법을 제공합니다. Cargo의 또다른 멋진 특성은 cargo doc --open 명령어로써 로컬에서 여러분의 모든 의존 패키지들이 제공하는 문서들을 빌드해서 브라우저에 표시해 줍니다. 만약 rand 크레이트의 다른 기능들에 흥미가 있다면 cargo doc --open을 실행하고 왼쪽의 사이드바에 rand를 클릭하세요.

- 코드에 추가한 두 번째 라인은 비밀번호를 표시합니다. 이 라인은 우리가 프로그램을 개발 중일 때 테스트를 할 수 있도록 하지만 최종 버전에서는 삭제할 것입니다. 게임을 시작하자마자 정답을 출력하는 게임은 그다지 많지 않으니까요!

- 이제 프로그램을 몇 번 실행해 봅시다.
```
$ cargo run
   Compiling guessing_game v0.1.0 (file:///projects/guessing_game)
    Finished dev [unoptimized + debuginfo] target(s) in 2.53 secs
     Running `target/debug/guessing_game`
Guess the number!
The secret number is: 7
Please input your guess.
4
You guessed: 4
$ cargo run
     Running `target/debug/guessing_game`
Guess the number!
The secret number is: 83
Please input your guess.
5
You guessed: 5
```
# 비밀번호와 추리값을 비교하기
- 이제 우리는 입력값과 임의의 정수를 가지고 있음으로 비교가 가능합니다. Listing 2-4는 그 단계를 보여주고 있습니다.

- Filename: src/main.rs
```rust
extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1.. 101);

    println!("The secret number is: {}", secret_number);

    println!("Please input your guess.");

    let mut guess = String::new();

    io::stdin().read_line(&mut guess)
        .expect("Failed to read line");

    println!("You guessed: {}", guess);

    match guess.cmp(&secret_number) {
        Ordering::Less    => println!("Too small!"),
        Ordering::Greater => println!("Too big!"),
        Ordering::Equal   => println!("You win!"),
    }
}
```
- Listing 2-4: 두 숫자를 비교한 결과 처리하기

- 처음으로 나타난 새로운 요소는 표준 라이브러리로부터 std::cmp::Ordering을 스코프로 가져오는 또다른 use입니다. Ordering은 Result와 같은 열거형이지만 Ordering의 값은 Less, Greater, Equal입니다. 이것들은 여러분이 두 개의 값을 비교할 때 나올 수 있는 결과들입니다.

- 그리고 나서 우리는 Ordering 타입을 이용하는 다섯 줄을 마지막에 추가 했습니다.

```rust
match guess.cmp(&secret_number) {
    Ordering::Less    => println!("Too small!"),
    Ordering::Greater => println!("Too big!"),
    Ordering::Equal   => println!("You win!"),
}
```
- cmp 메소드는 두 값을 비교하며 비교 가능한 모든 것들에 대해 호출할 수 있습니다. 이 메소드는 비교하고 싶은 것들의 참조자를 받습니다. 여기서는 guess와 secret_number를 비교하고 있습니다. cmp는 Ordering 열거형을 돌려줍니다. 우리는 match 표현문을 이용하여 cmp가 guess와 secret_number를 비교한 결과인 Ordering의 값에 따라 무엇을 할 것인지 결정할 수 있습니다.

- match 표현식은 arm 으로 이루어져 있습니다. 하나의 arm은 하나의 패턴 과 match 표현식에서 주어진 값이 패턴과 맞는다면 실행할 코드로 이루어져 있습니다. 러스트는 match에게 주어진 값을 arm의 패턴에 맞는지 순서대로 확인합니다. match 생성자와 패턴들은 여러분의 코드가 마주칠 다양한 상황을 표현할 수 있도록 하고 모든 경우의 수를 처리했음을 확신할 수 있도록 도와주는 강력한 특성들입니다. 이 기능들은 6장과 18장에서 각각 더 자세히 다뤄집니다.

- 예제서 사용된 match 표현식에 무엇이 일어날지 한번 따라가 봅시다. 사용자가 50을 예측했다고 하고 비밀번호가 38이라 합시다. 50과 38을 비교하면 cmp 메소드의 결과는 Ordering::Greater 입니다. match 표현식은 Ordering::Greater를 값으로 받을 것입니다. 처음으로 마주하는 arm의 패턴인 Ordering::Less는 Ordering::Greater와 매칭되지 않으므로 첫번째 arm은 무시하고 다음으로 넘어갑니다. 다음 arm의 패턴인 Ordering::Greater는 확실히 Ordering::Greater와 매칭합니다! arm과 연관된 코드가 실행될 것이고 Too big가 출력될 것입니다. 이 경우 마지막 arm은 확인할 필요가 없으므로 match 표현식은 끝납니다.
- 하지만 Listing 2-4의 코드는 컴파일되지 않습니다. 한번 시도해 봅시다.

```
$ cargo build
   Compiling guessing_game v0.1.0 (file:///projects/guessing_game)
error[E0308]: mismatched types
  --> src/main.rs:23:21
   |
23 |     match guess.cmp(&secret_number) {
   |                     ^^^^^^^^^^^^^^ expected struct `std::string::String`, found integral variable
   |
   = note: expected type `&std::string::String`
   = note:    found type `&{integer}`

error: aborting due to previous error
Could not compile `guessing_game`.

```
- 에러의 핵심은 일치하지 않는 타입 이 있다고 알려 주는 것입니다. 러스트는 강한 정적 타입 시스템을 가지고 있습니다. 하지만 타입 추론도 수행합니다. 만약 let guess = String::new()를 작성한다면 러스트는 guess가 String타입이어야 함을 추론할 수 있으므로 타입을 적으라고 하지 않습니다. 반대로 secret_number는 정수형입니다. 몇몇 숫자 타입들이 1과 100 사이의 값을 가질 수 있습니다. i32는 32비트 정수, u32는 32비트의 부호없는 정수, i64는 64비트의 정수이며 그 외에도 비슷합니다. 러스트는 기본적으로 우리가 다른 정수형임을 추론할 수 있는 다른 타입 정보를 제공하지 않는다면 숫자들을 i32으로 생각합니다. 이 에러의 원인은 러스트가 문자열과 정수형을 비교하지 않기 때문입니다.

- 최종적으로 우리는 추리값을 정수형으로 비교하기 위해 입력으로 받은 String을 정수로 바꾸고 싶을 것입니다. 이것은 main 함수 내에 다음 두 라인을 넣어서 할 수 있습니다.

```rust
extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1, 101);

    println!("The secret number is: {}", secret_number);

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
```
- 두 라인은 다음과 같습니다.
- 우리는 guess 변수를 생성했습니다. 잠깐, 이미 프로그램에서 guess라는 이름의 변수가 생성되지 않았나요? 그렇긴 하지만 러스트는 이전에 있던 guess의 값을 가리는(shadow) 것을 허락합니다. 이 특징은 종종 하나의 값을 현재 타입에서 다른 타입으로 변환하고 싶을 경우에 사용합니다. Shadowing은 우리들이 guess_str과 guess처럼 고유의 변수명을 만들도록 강요하는 대신 guess를 재사용 가능하도록 합니다. (3장에서 더 자세한 이야기를 다룹니다)

- 우리는 guess를 guess.trim().parse() 표현식과 묶습니다. 표현식 내의 guess는 입력값을 가지고 있던 String을 참조합니다. String 인스턴스의 trim 메소드는 처음과 끝 부분의 빈칸을 제거합니다. u32는 정수형 글자만을 가져야 하지만 사용자들은 read_line을 끝내기 위해 enter키를 반드시 눌러야 합니다. enter키가 눌리는 순간 개행문자가 문자열에 추가됩니다. 만약 사용자가 5를 누르고 enter키를 누르면 guess는 5\n처럼 됩니다. \n은 enter키, 즉 개행문자를 의미합니다. trim 메소드는 \n을 제거하고 5만 남도록 처리합니다.

- 문자열의 parse 메소드는 문자열을 숫자형으로 파싱합니다. 이 메소드는 다양한 종류의 정수형을 변환하므로 우리는 let guess: u32처럼 정확한 타입을 명시해야 합니다. guess 뒤의 콜론(:)은 변수의 타입을 명시했음을 의미합니다. 러스트는 몇몇 내장된 정수형을 가지고 있습니다. u32은 부호가 없는 32비트의 정수입니다. 이 타입은 작은 양수를 표현하기에는 좋은 선택입니다. 3장에서 다른 숫자형에 대해 배울 것입니다. 추가로 이 예시에서 명시했던 u32과 secret_number와의 비교는 러스트가 secret_number의 타입을 u32로 유추해야 함을 의미합니다. 이제 이 비교는 같은 타입의 두 값의 비교가 됩니다.

- parse 메소드의 호출은 에러가 발생하기 쉽습니다. 만약 A👍%과 같은 문자열이 포함되어 있다면 정수로 바꿀 방법이 없습니다. "Result 타입으로 잠재된 실패 다루기"에서 read_line와 비슷하게 parse 메소드는 실패할 경우를 위해 Result 타입을 결과로 돌려 줍니다. 만약 parse 메소드가 문자열에서 정수로 파싱을 실패하여 Err Result variant를 돌려준다면 expect 호출은 게임을 멈추고 우리가 명시한 메세지를 출력합니다. 만약 parse 메소드가 성공적으로 문자열을 정수로 바꾸었다면 Result의 Ok variant를 돌려 받으므로 expect에서 Ok에서 얻고 싶었던 값을 결과로 받게 됩니다.

이제 프로그램을 실행해 봅시다!
```
$ cargo run
   Compiling guessing_game v0.1.0 (file:///projects/guessing_game)
    Finished dev [unoptimized + debuginfo] target(s) in 0.43 secs
     Running `target/guessing_game`
Guess the number!
The secret number is: 58
Please input your guess.
  76
You guessed: 76
Too big!
```
- 좋습니다! 추리값 앞에 빈칸을 넣더라도 프로그램은 추리값이 76임을 파악 했습니다. 추리값이 맞을 때나 너무 클 경우, 혹은 너무 작은 경우 등 여러 종류의 입력값으로 여러 시나리오를 검증해 봅시다.

- 우리는 게임의 대부분이 동작하도록 처리 했지만 사용자는 한 번의 추리만 가능합니다. 반복문을 추가하여 변경해 봅시다!