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

