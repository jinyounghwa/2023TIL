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
