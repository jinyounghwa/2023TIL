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

