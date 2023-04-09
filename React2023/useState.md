# useState
- useState는 React Hook으로 컴포넌트에 state 변수를 추가할 수 있게 해줍니다.

## 레퍼런스
- useState(initialState) 
- 컴포넌트의 상단에서 useState를 호출하여 state 변수를 선언합니다.

```js
import { useState } from 'react';

function MyComponent() {
  const [age, setAge] = useState(28);
  const [name, setName] = useState('Taylor');
  const [todos, setTodos] = useState(() => createTodos());
  // ...
```
- state 변수는 [something, setSomething]와 같이 array destructuring를 이용해 이름을 짓는 것이 컨벤션입니다.
## 인자값들 

- initialState: state를 초기값으로 설정합니다. 어떤 타입의 값이든 초기값이 될 수 있지만, 함수의 경우 특별한 동작을 합니다. 이 인자는 초기 렌더링 이후에는 무시됩니다.  
- initialState로 함수를 전달하면 초기화 함수 로 취급됩니다. 이 함수는 순수해야 하며, 인자를 가져서는 안 되며, 어떤 타입이든 값을 반환해야 합니다. React는 컴포넌트를 초기화할 때 초기화 함수를 호출하고 반환 값을 최초 state로 저장합니다. 

## 반환값들

- useState 는 두 개의 값이 들어있는 배열을 반환합니다:

1. 현재의 state. 최초 렌더링 중에는 당신이 전달한 initialState와 일치합니다.
2. set 함수는 상태를 다른 값으로 업데이트하고 리렌더링을 할 수 있게 해줍니다.

### 주의사항
- useState는 훅이기 때문에 컴포넌트의 최상위 레벨이나 컴포넌트 자체의 훅에서만 호출할 수 있습니다. 루프나 조건문 안에서 호출할 수 없습니다. 만약 필요하다면, 새 컴포넌트를 추출하여 상태를 그 안에 이동시켜야 합니다.

- Strict Mode에서는 React가 적용중인 부수효과를 우연한 부작용을 찾기 위해 initializer 함수를 두 번 호출합니다. 이는 개발환경에서만 작동하며, 프로덕션에는 영향을 주지 않습니다. 만약 initializer 함수가 순수 함수이면(그렇게 되어야 합니다), 이러한 동작은 동작에 영향을 미치지 않을 것입니다. 두 번째 호출의 결과는 무시됩니다.

## set 함수를 사용할 수 있습니다(예: setSomething(nextState)). 

- useState가 반환하는 set 함수를 사용하면 상태를 다른 값으로 업데이트하고 렌더링을 다시 트리거할 수 있습니다. 다음 상태를 직접 전달하거나 이전 상태에서 계산하는 함수를 전달할 수 있습니다.

```js
const [name, setName] = useState('Edward');

function handleClick() {
  setName('Taylor');
  setAge(a => a + 1);
  // ...
```
## 매개변수(Parameters)

- nextState: 상태가 되길 원하는 값입니다. 모든 유형의 값일 수 있지만 함수에 대한 특별한 동작이 있습니다.

- 함수를 nextState로 전달하면 업데이터 함수로 취급됩니다. 이 함수는 순수해야 하고, 보류 중인 상태를 유일한 인수로 사용해야 하며, nextState를 return해야 합니다. React는 업데이터 함수를 대기열에 넣고 컴포넌트를 다시 렌더링합니다. 다음 렌더링 중에 React는 대기열에 있는 모든 업데이터를 이전 상태에 적용하여 다음 상태를 계산합니다.

### Returns
- set 함수에는 반환값이 없습니다.

## 주의 사항 
- set 함수는 다음 렌더링에 대한 상태 변수만 업데이트합니다. set 함수를 호출한 후 state 변수를 읽으면 호출 전 화면에 있던 이전 값을 계속 가져옵니다.

- Object.is 비교에 의해 결정된 새 값이 현재 상태와 동일한 경우, React는 컴포넌트와 그 자식들을 다시 렌더링하는 것을 건너뜁니다. 이것은 최적화입니다. 경우에 따라 React가 자식을 건너뛰기 전에 컴포넌트를 호출해야 할 수도 있지만, 코드에 영향을 미치지는 않습니다.

- React는 상태 업데이트를 일괄 처리합니다. 모든 이벤트 핸들러가 실행되고 설정된 함수를 호출한 후에 화면을 업데이트합니다. 이렇게 하면 단일 이벤트 중에 여러 번 다시 렌더링하는 것을 방지할 수 있습니다. 드물지만 DOM에 접근하기 위해 React가 화면을 더 일찍 업데이트하도록 해야 하는 경우, flushSync를 사용할 수 있습니다.

- 렌더링 도중 set 함수를 호출하는 것은 현재 렌더링 중인 컴포넌트 내에서만 허용됩니다. React는 해당 출력을 버리고 즉시 새로운 상태로 다시 렌더링을 시도합니다. 이 패턴은 거의 필요하지 않지만 이전 렌더링의 정보를 저장하는 데 사용할 수 있습니다. 아래 예시를 참고하세요.

- Strict 모드에서 React는 실수로 발생한 불순물을 찾기 위해 업데이터 함수를 두 번 호출합니다. 이는 개발 전용 동작이며 프로덕션에는 영향을 미치지 않습니다. 만약 업데이터 함수가 순수하다면(그래야만 하는 것처럼), 이것은 동작에 영향을 미치지 않습니다. 호출 중 하나의 결과는 무시됩니다.

---
## 사용법 

### 컴포넌트에 상태 추가하기 
- 컴포넌트의 최상위 레벨에서 useState를 호출하여 하나 이상의 상태 변수를 선언하세요.

```js
import { useState } from 'react';

function MyComponent() {
  const [age, setAge] = useState(42);
  const [name, setName] = useState('Taylor');
  // ...
```
- 배열 파괴를 사용하여 [something, setSomething]과 같은 상태 변수의 이름을 지정하는 것이 관례입니다.

- useState는 정확히 두 개의 항목이 있는 배열을 반환합니다:

1. 이 상태 변수의 현재 상태(처음에 제공한 초기 상태로 설정됨).
2. 상호작용에 대한 응답으로 다른 값으로 변경할 수 있는 set 함수를 사용할 수 있습니다.

- 화면의 내용을 업데이트하려면 다음 상태로 set 함수를 호출합니다

```js
function handleClick() {
  setName('Robin');
}
```
- React는 다음 상태를 저장하고 새로운 값으로 컴포넌트를 다시 렌더링한 후 UI를 업데이트합니다.

## 함정
- 설정 함수를 호출해도 이미 실행 중인 코드의 현재 상태는 변경되지 않습니다.
```js
function handleClick() {
  setName('Robin');
  console.log(name); // Still "Taylor"!
}
```
- 다음 렌더링부터 반환할 useState에만 영향을 줍니다.

### 기본적인 useState 예시
- 이 예제에서 카운트 상태 변수는 숫자를 보유합니다. 버튼을 클릭하면 숫자가 증가합니다.
https://codesandbox.io/s/e52bbn?file=%2FApp.js&utm_medium=sandpack

- 이 예제에서 텍스트 상태 변수는 문자열을 보유합니다. 입력하면 handleChange는 브라우저 입력 DOM 요소에서 최신 입력 값을 읽고 setText를 호출하여 상태를 업데이트합니다. 이렇게 하면 아래에 현재 텍스트를 표시할 수 있습니다.
https://codesandbox.io/s/4t6pqy?file=/App.js&utm_medium=sandpack

- 이 예제에서 좋아요 상태 변수는 부울을 보유합니다. 입력을 클릭하면 setLiked는 브라우저 확인란 입력이 선택되어 있는지 여부에 따라 좋아요 상태 변수를 업데이트합니다. 좋아요 변수는 체크박스 아래의 텍스트를 렌더링하는 데 사용됩니다.
https://codesandbox.io/s/56ohpg?file=%2FApp.js&utm_medium=sandpack

- 동일한 컴포넌트에 둘 이상의 상태 변수를 선언할 수 있습니다. 각 상태 변수는 완전히 독립적입니다.
https://codesandbox.io/s/ppw3vj?file=/App.js&utm_medium=sandpack

## 이전 state 기준으로 state 업데이트하기
- 나이가 42세라고 가정합니다. 이 핸들러는 setAge(age + 1)를 세 번 호출합니다
```js
function handleClick() {
  setAge(age + 1); // setAge(42 + 1)
  setAge(age + 1); // setAge(42 + 1)
  setAge(age + 1); // setAge(42 + 1)
}
```
- 그러나 한 번만 클릭하면 나이는 45세가 아니라 43세가 됩니다! 이는 set 함수를 호출해도 이미 실행 중인 코드에서 나이 상태 변수가 업데이트되지 않기 때문입니다. 따라서 각 setAge(age + 1) 호출은 setAge(43)이 됩니다.

- 이 문제를 해결하려면 다음 상태 대신 업데이터 함수를 setAge에 전달할 수 있습니다

```js
function handleClick() {
  setAge(a => a + 1); // setAge(42 => 43)
  setAge(a => a + 1); // setAge(43 => 44)
  setAge(a => a + 1); // setAge(44 => 45)
}
```
- 여기서 a => a + 1은 업데이터 함수입니다. 이 함수는 보류 중인 상태를 가져와서 다음 상태를 계산합니다.

- React는 업데이터 함수를 대기열에 넣습니다. 그리고 다음 렌더링 중에 같은 순서로 호출합니다:

1. a => a + 1은 42를 보류 상태로 받고 다음 상태로 43을 반환합니다.
2. a => a + 1은 43을 보류 중인 상태로 수신하고 다음 상태로 44를 반환합니다.
3. a => a + 1은 44를 보류 중인 상태로 수신하고 다음 상태로 45를 반환합니다.
4. 대기 중인 다른 업데이트가 없으므로 React는 결국 45를 현재 상태로 저장합니다.

- 일반적으로 보류 중인 상태 인수의 이름을 state 변수 이름의 첫 글자로 정하는 것이 일반적입니다(예: for age). 하지만 더 명확하다고 생각되는 prevAge 또는 다른 이름으로 부를 수도 있습니다.

- React는 개발 과정에서 업데이트가 순수한지 확인하기 위해 업데이터를 두 번 호출할 수 있습니다.

### 업데이터를 전달하는 것과 다음 상태를 직접 전달하는 것의 차이점
- 업데이터 함수 전달하기 : 이 예제는 업데이터 함수를 전달하므로 "+3" 버튼이 작동합니다.
https://codesandbox.io/s/tyz40q?file=%2FApp.js&utm_medium=sandpack

- 다음 상태로 직접 전달하기 : 이 예제에서는 업데이터 함수를 전달하지 않으므로 "+3" 버튼이 의도한 대로 작동하지 않습니다.
https://codesandbox.io/s/zsq3nl?file=%2FApp.js&utm_medium=sandpack

## 상태의 개체 및 배열 업데이트하기 
- 객체와 배열을 state에 넣을 수 있습니다. React에서 state는 읽기 전용으로 간주되므로 기존 객체를 변경하지 말고 대체해야 합니다. 예를 들어, state에 폼 객체가 있는 경우 이를 변경하지 마세요:
```js
// 🚩 Don't mutate an object in state like this:
form.firstName = 'Taylor';
```
- 대신 새 개체를 생성하여 전체 개체를 교체합니다:
```js
// ✅ Replace state with a new object
setForm({
  ...form,
  firstName: 'Taylor'
});
```
### state의 객체 및 배열 예시
1. 폼(객체) : Form (object) 
- 이 예제에서 양식 상태 변수는 객체를 보유합니다. 각 입력에는 전체 양식의 다음 상태로 setForm을 호출하는 변경 핸들러가 있습니다. 스프레드 구문 { ...form }은 상태 객체가 변경되지 않고 대체되도록 합니다.
https://codesandbox.io/s/1cp3sh?file=/App.js&utm_medium=sandpack

2. 양식(중첩된 개체) : Form (nested object) 
- 이 예제에서는 상태가 더 중첩되어 있습니다. 중첩된 상태를 업데이트할 때는 업데이트하려는 개체의 복사본을 만들어야 하며, 그 위에 있는 개체를 "포함하는" 모든 개체도 복사본을 만들어야 합니다. 자세히 알아보려면 중첩된 개체 업데이트하기를 참조하세요.
https://codesandbox.io/s/geo3mo?file=%2FApp.js&utm_medium=sandpack

3. 목록(배열) : List (array) 
- 이 예제에서 할일 상태 변수는 배열을 보유합니다. 각 버튼 핸들러는 해당 배열의 다음 버전으로 setTodos를 호출합니다. `[...todos]`스프레드 구문인 todos.map() 및 todos.filter()는 상태 배열이 변경되지 않고 대체되도록 합니다.
https://codesandbox.io/s/shp8w8?file=/App.js&utm_medium=sandpack

4. Immer로 간결한 업데이트 로직 작성 : Writing concise update logic with Immer 
- 변경 없이 배열과 객체를 업데이트하는 것이 지루하게 느껴진다면 Immer와 같은 라이브러리를 사용해 반복적인 코드를 줄일 수 있습니다. Immer를 사용하면 객체를 변경하는 것처럼 간결한 코드를 작성할 수 있지만, 내부적으로는 변경 불가능한 업데이트를 수행합니다:
https://codesandbox.io/s/mclx2n?file=%2FApp.js&utm_medium=sandpack
