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
