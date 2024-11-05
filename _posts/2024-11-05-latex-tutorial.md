---
layout: single
title: "라텍스 수식 테스트"
categories: test
tags: [latex, 수식, 테스트]
toc: true
author_profile: false
sidebar:
    nav: "counts"
use_math: true
---

# LaTeX 수식 테스트

이 문서에서는 다양한 라텍스 수식을 Markdown 파일 내에서 테스트합니다. 주어진 설정에 따라 수식이 제대로 렌더링되는지 확인할 수 있습니다.

## 1. 인라인 수식

텍스트와 함께 인라인 수식을 사용하려면 `$...$` 문법을 사용합니다.

예: 이차 방정식의 해는 $x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$ 입니다.

## 2. 블록 수식

블록 수식을 사용하려면 `$$...$$` 문법을 사용하여 수식을 별도의 줄에 배치합니다.

예:

$$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$

## 3. 행렬 표현

행렬은 `\begin{matrix} ... \end{matrix}` 구문을 사용하여 표현할 수 있습니다.

예:

$$
\begin{bmatrix}
    a & b \\
    c & d
\end{bmatrix}
$$

또는 더 복잡한 행렬 표현:

$$
\begin{pmatrix}
    1 & 2 & 3 \\
    4 & 5 & 6 \\
    7 & 8 & 9
\end{pmatrix}
$$

## 4. 함수와 기호

미적분 함수와 다양한 수학 기호도 사용할 수 있습니다.

예:

- 사인 함수: $\sin(\theta)$
- 코사인 함수: $\cos(\theta)$
- 적분: $\int_{a}^{b} x^2 \,dx$
- 무한급수: $\sum_{n=1}^{\infty} \frac{1}{n^2}$

블록으로 표현하면 다음과 같습니다.

$$
\int_{a}^{b} x^2 \,dx
$$

$$
\sum_{n=1}^{\infty} \frac{1}{n^2}
$$

## 5. 미분 및 적분

미분과 적분을 포함한 다양한 연산을 표현할 수 있습니다.

예:

- 미분: $\frac{d}{dx} f(x)$
- 두 번째 미분: $\frac{d^2}{dx^2} f(x)$
- 정적분: $\int_{a}^{b} f(x) \,dx$
- 부분적분: $\int u \, dv = uv - \int v \, du$

블록으로 표현하면 다음과 같습니다.

$$
\frac{d}{dx} f(x) = \lim_{\Delta x \to 0} \frac{f(x + \Delta x) - f(x)}{\Delta x}
$$

$$
\int_{a}^{b} f(x) \,dx
$$

## 6. 케이스 분할

수식을 여러 케이스로 나누어 표현할 수도 있습니다.

예:

$$
f(x) = 
\begin{cases} 
    x^2 & \text{if } x \geq 0 \\
    -x & \text{if } x < 0 
\end{cases}
$$

## 7. 수열 및 급수

수열과 급수를 수식으로 나타낼 수 있습니다.

예:

- 등차수열: $a_n = a + (n-1)d$
- 기하수열: $a_n = a \cdot r^{n-1}$

급수 표현:

$$
\sum_{n=1}^{\infty} \frac{1}{n^2} = \frac{\pi^2}{6}
$$

## 8. 복소수 및 오일러 공식

복소수와 오일러 공식도 라텍스로 표현할 수 있습니다.

예:

$$
e^{i\theta} = \cos \theta + i \sin \theta
$$

그리고 오일러의 유명한 공식:

$$
e^{i\pi} + 1 = 0
$$

이로써 다양한 수식 테스트를 완료했습니다. 이 페이지에서 수식이 제대로 렌더링되는지 확인하시기 바랍니다.