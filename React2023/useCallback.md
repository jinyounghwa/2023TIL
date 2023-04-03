# useCallback

- useCallback은 리렌더링 간에 함수 정의를 캐시할 수 있는 React Hook입니다.
```js
const cashedFn = useCallback(fn, dependencies)
``` 
- 참조 
  - useCallback(fn, dependencies)
- 사용 예
  - 구성요소의 다시 랜더링을 건너 뛸 때
  - 메모화된 콜백에서 상태 업데이트 할 때
  - 이펙트가 자주 발생하지 않도록 할 때
  - 직접 만든 훅을 최적화 할 때
- 문제 해결 방법
  - 내 컴포넌트가 렌더링될 때마다 useCallback은 다른 함수를 반환합니다.
  - 루프에서 각 목록 항목의 useCallback 호출해야 하지만 허용되지 않습니다.
---
## 예제 1
```js
import { useCallback } from 'react';

export default function ProductPage({ productId, referrer, theme }) {
  const handleSubmit = useCallback((orderDetails) => {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }, [productId, referrer]);
```
- 매개변수(파라미터)
  - fn: 캐시하려는 함수 값입니다. 모든 인수를 취하고 어떤 값을 반환할 수 있습니다. React는 초기 렌더링 중에 함수를 단순히 반환하고 호출하지는 않습니다. 그 다음 렌더링에서는 의존성이 마지막 렌더링 이후로 변경되지 않았다면 동일한 함수를 다시 제공합니다. 그렇지 않으면 현재 렌더링 중에 전달한 함수를 제공하고 나중에 재사용할 수 있도록 저장합니다. React는 함수를 호출하지 않습니다. 함수가 반환되기 때문에 언제 호출할지와 호출할지 여부를 결정할 수 있습니다.  
  - dependencies: fn 코드 내에서 참조하는 모든 반응형 값들의 목록입니다. 리액티브 value들은 props, state, 그리고 컴포넌트 바디 내에서 직접 선언된 모든 변수와 함수를 포함합니다. React를 위한 린터(linter)가 구성되어 있다면, 모든 반응형 값이 올바르게 의존성으로 지정되었는지 확인할 수 있습니다. 의존성 목록은 상수 개수의 항목을 가지고 [dep1, dep2, dep3]와 같이 인라인으로 작성되어야 합니다. React는 각 의존성을 이전 값과 Object.is 비교 알고리즘을 사용하여 비교합니다.  
  - 
- 리턴
- 초기 렌더링 시, useCallback은 전달한 fn 함수를 반환합니다.
- 이후 렌더링에서, 의존성이 변경되지 않았다면 이전 렌더링에서 이미 저장된 fn 함수를 반환하거나, 이번 렌더링 중 전달한 fn 함수를 반환할 것입니다.  

## 예제 2
- 구성 요소의 다시 렌더링 건너뛰기
- 렌더링 성능을 최적화할 때 자식 구성 요소에 전달하는 기능을 캐시해야 하는 경우가 있습니다. 먼저 이 작업을 수행하는 방법에 대한 구문을 살펴본 다음 어떤 경우에 유용한지 살펴보겠습니다.

- 구성 요소를 다시 렌더링하는 사이에 함수를 캐시하려면 해당 정의를 useCallback으로 래핑합니다.
```js
import { useCallback } from 'react';

function ProductPage({ productId, referrer, theme }) {
  const handleSubmit = useCallback((orderDetails) => {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }, [productId, referrer]);
  // ...
```
- useCallback에는 두 가지를 전달해야 합니다:

1. 재 렌더링 간에 캐시할 함수 정의
2. 함수 내에서 사용되는 컴포넌트 내 모든 값이 포함된 의존성 목록

- 초기 렌더링에서 useCallback으로부터 반환된 함수는 전달한 함수가 될 것입니다.

- 다음 렌더링에서 React는 이전 렌더링에서 전달한 의존성과 비교할 의존성을 비교합니다. 의존성이 변경되지 않았다면(Object.is를 사용해 비교), useCallback은 이전과 동일한 함수를 반환합니다. 그렇지 않으면, 이번 렌더링에서 전달한 함수를 반환할 것입니다.

- 즉, useCallback은 의존성이 변경될 때까지 함수를 재 렌더링 간에 캐시합니다.
- 어떤 경우에 유용한지 알아보기 위해 예시를 살펴보겠습니다.
- ProductPage에서 ShippingForm 컴포넌트로 handleSubmit 함수를 전달하는 경우를 가정해봅시다.
```js
function ProductPage({ productId, referrer, theme }) {
  // ...
  return (
    <div className={theme}>
      <ShippingForm onSubmit={handleSubmit} />
    </div>
  );
```
- theme prop을 토글하는 경우 앱이 잠시 멈추는 것을 알아챘지만, JSX에서 `<ShippingForm />`을 제거하면 빠르게 동작한다는 것을 확인할 수 있습니다. 이는 ShippingForm 컴포넌트를 최적화해보는 가치가 있다는 것을 알려줍니다.

- 기본적으로 컴포넌트가 재 렌더링되면, React는 자식 컴포넌트를 재귀적으로 모두 재 렌더링합니다. 따라서 ProductPage가 다른 테마로 재 렌더링될 때 ShippingForm 컴포넌트도 재 렌더링됩니다. 이는 재 렌더링에 많은 계산이 필요하지 않은 컴포넌트에 대해서는 괜찮습니다. 그러나 재 렌더링이 느리다고 확인된 경우, memo로 감싸서 마지막 렌더링과 동일한 props를 가지고 있는 경우 ShippingForm 컴포넌트를 재 렌더링하지 않도록 할 수 있습니다.

```js
import { memo } from 'react';

const ShippingForm = memo(function ShippingForm({ onSubmit }) {
  // ...
});
```
- 이 변경으로 인해, ShippingForm 컴포넌트는 마지막 렌더링과 동일한 props를 가지고 있는 경우 재 렌더링을 건너뛰게 됩니다. 이때 함수 캐싱이 중요해집니다! handleSubmit을 useCallback 없이 정의한 경우를 가정해 봅시다.
  
```js
function ProductPage({ productId, referrer, theme }) {
  // Every time the theme changes, this will be a different function...
  function handleSubmit(orderDetails) {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }
  
  return (
    <div className={theme}>
      {/* ... so ShippingForm's props will never be the same, and it will re-render every time */}
      <ShippingForm onSubmit={handleSubmit} />
    </div>
  );
}
```
- 자바스크립트에서 함수 () {} 또는 () => {}은 항상 새로운 함수를 생성합니다. 이는 {} 객체 리터럴이 항상 새로운 객체를 생성하는 것과 유사합니다. 보통이라면 이것이 문제가 되지 않겠지만, 이것은 ShippingForm props가 결코 같지 않을 것이라는 것을 의미하며 memo 최적화가 작동하지 않을 것입니다. 이때 useCallback이 유용합니다:
  
```js
function ProductPage({ productId, referrer, theme }) {
  // Tell React to cache your function between re-renders...
  const handleSubmit = useCallback((orderDetails) => {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }, [productId, referrer]); // ...so as long as these dependencies don't change...

  return (
    <div className={theme}>
      {/* ...ShippingForm will receive the same props and can skip re-rendering */}
      <ShippingForm onSubmit={handleSubmit} />
    </div>
  );
}
```
- handleSubmit을 useCallback으로 감싸면, 리렌더링 사이에 (의존성이 변경되기 전까지) 동일한 함수임이 보장됩니다. 특정한 이유가 없다면 함수를 useCallback으로 감싸지 않아도 됩니다. 이 예시에서의 이유는 memo로 감싸진 컴포넌트에 함수를 전달하기 때문에 이를 통해 리렌더링을 건너 뛸 수 있습니다. useCallback이 필요한 다른 이유는 이 페이지에서 더 자세하게 설명됩니다.

- 메모이제이션된 콜백으로 이전 상태를 기반으로 상태를 업데이트해야 할 때가 있습니다. 이 handleAddTodo 함수는 다음 todos를 계산하기 때문에 todos를 종속성으로 지정합니다.

```js
function TodoList() {
  const [todos, setTodos] = useState([]);

  const handleAddTodo = useCallback((text) => {
    const newTodo = { id: nextId++, text };
    setTodos([...todos, newTodo]);
  }, [todos]);
  // ...
```
- 보통 메모이제이션된 함수는 가능한 적은 종속성을 가지도록 하고 싶을 것입니다. 만약 다음 상태를 계산하기 위해서만 상태를 읽는다면, 업데이트 함수를 전달하여 해당 종속성을 제거할 수 있습니다.

```js
function TodoList() {
  const [todos, setTodos] = useState([]);

  const handleAddTodo = useCallback((text) => {
    const newTodo = { id: nextId++, text };
    setTodos(todos => [...todos, newTodo]);
  }, []); // ✅ No need for the todos dependency
  // ...
```
