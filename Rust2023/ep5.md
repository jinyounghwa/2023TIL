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
io::stdin().read_line(&mut guess).expect("Fail to read line");
```
- 만약 프로그램의 시작점에 `use std::io`가 없다면 함수 호출 시 `std::io::stdin`처럼 작성해야 합니다. stdin 함수 터미널의 표준 입력의 핸들(handle)의 타입인 `std::io::Stdin`의 인스턴스를 돌려줍니다.
- 코드의 다음 부분인 `read_line(&mut guess)`는 사용자로부터 입력을 받기 위해 표준 입력 핸들에서 `.read_line(&mut guess)`메소드를 호출합니다. 또한`read_line`에 &mut guess를 인자로 하나 남깁니다.
- read_line은 사용자가 표준 입력에 입력할 때마다 입력된 문자륻을 하나의 문자열에 저장하므로 인자로 값을 저장할 문자열이 필요합니다. 그 문자열 인자는 사용자 입력을 추가하면서 변경되므로 가변이어야 합니다.
- & 는 코드의 여러 부분에서 데이터를 여러 번 메모리로 복사하지 않고 접근하기 위한 방법을 제공하는 참조자임을 나타냅니다. 참조자는 복잡한 특성으로서 러스트의 큰 이점 중 하나가 참조자를 사용함으로써 얻는 안전성과 용이성이다. 이 프로그램을 작성하기 위해 참조자의 자세한 내용을 알 필요는 없습니다. 4장에서 참조자에 대해 전체적으로 설명할 것입니다. 지금 당장은 참조자가 변수처럼 기본적으로 불면임을 알기만 하면 됩니다. 따라서 가변으로 바꾸기 위해 &guess가 아니라 &mut guess 로 작성해야 합니다.