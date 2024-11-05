---
layout: single
title: "코드 블록 테스트"
categories: test
tags: [code, test, Python, JSON, JavaScript, YAML]
toc: true
author_profile: false
sidebar:
    nav: "counts"
---

# 코드 블록 및 인라인 코드 테스트

이 문서에서는 다양한 코드 언어와 포맷을 Markdown 파일 내에서 테스트합니다. 주어진 설정에 따라 코드가 제대로 렌더링되는지 확인할 수 있습니다.

## 1. 인라인 코드

텍스트 내에서 `` `print("Hello, World!")` ``와 같은 인라인 코드 블록을 사용하려면 백틱(`)을 이용해 감싸줍니다. 아래에 몇 가지 인라인 코드 예제를 더 추가해보겠습니다.

- Python 예제: `` `for i in range(10): print(i)` ``
- JavaScript 예제: `` `console.log("Hello, JavaScript!");` ``
- YAML 예제: `` `version: '3.8'` ``

## 2. Python 코드 블록

Python 코드를 코드블록으로 작성하여 가독성을 높일 수 있습니다. 예:

````python
def fibonacci(n):
    """Returns the Fibonacci sequence up to n terms."""
    sequence = [0, 1]
    for i in range(2, n):
        sequence.append(sequence[-1] + sequence[-2])
    return sequence

print(fibonacci(10))
````

위의 코드에서는 피보나치 수열을 출력하는 간단한 Python 함수를 정의했습니다.

## 3. JSON 코드 블록

JSON 데이터를 코드블록으로 작성하여 구조가 잘 보이게 합니다. 예:

````json
{
    "name": "John Doe",
    "age": 30,
    "is_student": false,
    "courses": [
        "Math",
        "Science",
        "Literature"
    ]
}
````

위 JSON 데이터는 사용자 정보를 저장하는 데 사용될 수 있습니다.

## 4. JavaScript 코드 블록

JavaScript 코드를 코드블록으로 작성하여 웹 개발 코드가 깔끔하게 보이도록 합니다. 예:

````javascript
function greet(name) {
    console.log(`Hello, ${name}!`);
}

greet("JavaScript");
````

위의 JavaScript 코드에서는 `greet`라는 함수를 통해 이름을 받아 출력하는 기능을 보여줍니다.

## 5. YAML 코드 블록

YAML 파일 구문도 코드블록으로 작성할 수 있습니다. YAML은 특히 구성 파일을 작성하는 데 유용합니다. 예:

````yaml
version: '3.8'
services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    environment:
      - NGINX_HOST=localhost
      - NGINX_PORT=80
````

위의 YAML 예제는 Docker Compose 파일을 작성할 때 자주 사용되는 설정 예시입니다.

## 6. Bash 스크립트 코드 블록

Bash 스크립트 코드는 코드블록으로 작성하여 쉘 명령어가 잘 보이도록 합니다. 예:

````bash
#!/bin/bash
echo "Hello, Bash!"

for i in {1..5}
do
   echo "Loop $i"
done
````

위의 Bash 코드에서는 간단한 반복문과 출력 명령어를 보여줍니다.

## 7. HTML 코드 블록

HTML 코드도 코드블록으로 작성할 수 있습니다. 웹 요소를 설명하는 데 유용합니다. 예:

````html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HTML Test</title>
</head>
<body>
    <h1>Hello, HTML!</h1>
    <p>This is a paragraph in HTML.</p>
</body>
</html>
````

위 HTML 코드는 간단한 웹 페이지를 생성하는 기본 요소를 포함하고 있습니다.

## 8. CSS 코드 블록

CSS 코드 블록으로 스타일을 적용하는 예제를 보여줍니다.

```css
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    color: #333;
}

h1 {
    color: #0073e6;
}
```

위 CSS 코드는 HTML 요소의 스타일을 지정하는 간단한 예입니다.

이로써 다양한 언어의 코드 블록 테스트를 완료했습니다. 이 페이지에서 각 코드 블록이 잘 렌더링되는지 확인하시기 바랍니다.