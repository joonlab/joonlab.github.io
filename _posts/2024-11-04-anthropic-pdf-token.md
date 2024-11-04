---
layout: single
title: "Anthropic(Claude) PDF processing&Token counting tutorial"
categories: coding
tag: python, claude, anthropic
---


```python
!jupyter nbconvert --to markdown /content/Search-Grounding_tutorial_by_PARK_JOON.ipynb
```

# [Made by PARK JOON](https://bio.link/joonpark)

---
# [Claude API 발급 방법](https://llm-project-joon.site/API_KEY_%E1%84%87%E1%85%A1%E1%86%AF%E1%84%80%E1%85%B3%E1%86%B8_%E1%84%87%E1%85%A1%E1%86%BC%E1%84%87%E1%85%A5%E1%86%B8)

---
# 필요한 라이브러리 설치


```python
!pip install -q anthropic
```


```python
!pip install -q currencyconverter
```

# API KEY 설정


```python
import anthropic
from google.colab import userdata

ANTHROPIC_API_KEY = userdata.get('ANTHROPIC_API_KEY')

client = anthropic.Anthropic(api_key=ANTHROPIC_API_KEY)
```

#### 참고 이미지

[코랩 환경 변수 설정 참고 이미지](https://i.imghippo.com/files/nkS8F1729430186.png)

⚠️ 참고 이미지에서는 OpenAI API KEY를 예시로 들어 설명하고 있습니다.

2️⃣의 "OPENAI_API_KEY" 를 "ANTHROPIC_API_KEY" 로 변경해주세요.

# 튜토리얼

## Token Counting

### Count tokens in basic messages


```python
import re

response = client.beta.messages.count_tokens(
    betas=["token-counting-2024-11-01"],
    model="claude-3-5-sonnet-20241022",
    system="You are a scientist",
    messages=[{
        "role": "user",
        "content": "Hello, Claude"
    }],
)

# 정규식으로 'input_tokens' 값을 추출
match = re.search(r'"input_tokens":\s*(\d+)', response.json())
if match:
    input_tokens = match.group(1)

print(f"인풋 토큰수 : {input_tokens}")
```

    인풋 토큰수 : 14


### Count tokens in messages with tools


```python
response = client.beta.messages.count_tokens(
    betas=["token-counting-2024-11-01"],
    model="claude-3-5-sonnet-20241022",
    tools=[
        {
            "name": "get_weather",
            "description": "Get the current weather in a given location",
            "input_schema": {
                "type": "object",
                "properties": {
                    "location": {
                        "type": "string",
                        "description": "The city and state, e.g. San Francisco, CA",
                    }
                },
                "required": ["location"],
            },
        }
    ],
    messages=[{"role": "user", "content": "What's the weather like in San Francisco?"}]
)

# 정규식으로 'input_tokens' 값을 추출
match = re.search(r'"input_tokens":\s*(\d+)', response.json())
if match:
    input_tokens = match.group(1)

print(f"인풋 토큰수 : {input_tokens}")
```

    인풋 토큰수 : 403


### Count tokens in messages with images


```python
import base64
import httpx

image_url = "https://upload.wikimedia.org/wikipedia/commons/a/a7/Camponotus_flavomarginatus_ant.jpg"
image_media_type = "image/jpeg"
image_data = base64.standard_b64encode(httpx.get(image_url).content).decode("utf-8")

response = client.beta.messages.count_tokens(
    betas=["token-counting-2024-11-01"],
    model="claude-3-5-sonnet-20241022",
    messages=[
        {
            "role": "user",
            "content": [
                {
                    "type": "image",
                    "source": {
                        "type": "base64",
                        "media_type": image_media_type,
                        "data": image_data,
                    },
                },
                {
                    "type": "text",
                    "text": "Describe this image"
                }
            ],
        }
    ],
)

# 정규식으로 'input_tokens' 값을 추출
match = re.search(r'"input_tokens":\s*(\d+)', response.json())
if match:
    input_tokens = match.group(1)

print(f"인풋 토큰수 : {input_tokens}")
```

    인풋 토큰수 : 1551


### Count tokens in messages with PDFs


```python
import base64

with open("/content/claude-new-document-ocr-test.pdf", "rb") as pdf_file:
    pdf_base64 = base64.standard_b64encode(pdf_file.read()).decode("utf-8")

response = client.beta.messages.count_tokens(
    betas=["token-counting-2024-11-01", "pdfs-2024-09-25"],
    model="claude-3-5-sonnet-20241022",
    system="답변은 기본적으로 한국어로 하고, 고유명사, 전문용어 등은 원어를 그대로 사용할 것. 한국어를 사용하는 경우, 어미는 '~임','~함'과 같이 간결하레 할 것. 답변에 수식이 포함된 경우 latex 문법을 사용하고, `\[`, `\]`을 사용하지 말고, `$`혹은 `$$`으로 감쌀 것.",
    messages=[{
        "role": "user",
        "content": [
            {
                "type": "document",
                "source": {
                    "type": "base64",
                    "media_type": "application/pdf",
                    "data": pdf_base64
                }
            },
            {
                "type": "text",
                "text": "업르도된 파일의 그림과 수식에 대해서 설명해줘"
            }
        ]
    }]
)

# 정규식으로 'input_tokens' 값을 추출
match = re.search(r'"input_tokens":\s*(\d+)', response.json())
if match:
    input_tokens = match.group(1)

print(f"인풋 토큰수 : {input_tokens}")
```

    인풋 토큰수 : 4346


## PDF 파일 분석 & 토큰수 계산


```python
import anthropic
import base64
import httpx

# CASE 1 : PDF URL 입력
# pdf_url = "https://assets.anthropic.com/m/1cd9d098ac3e6467/original/Claude-3-Model-Card-October-Addendum.pdf"
# pdf_data = base64.standard_b64encode(httpx.get(pdf_url).content).decode("utf-8")

# CASE 2 : PDF 파일 업로드 입력
with open("/content/claude-new-document-ocr-test.pdf", "rb") as pdf_file:
    pdf_data = base64.standard_b64encode(pdf_file.read()).decode("utf-8")

message = client.beta.messages.create(
    model="claude-3-5-sonnet-20241022",
    betas=["pdfs-2024-09-25"],
    max_tokens=8192,
    temperature=0.65,
    system="답변은 기본적으로 한국어로 하고, 고유명사, 전문용어 등은 원어를 그대로 사용할 것. 한국어를 사용하는 경우, 어미는 '~임','~함'과 같이 간결하게 할 것. 답변에 수식이 포함된 경우 latex 문법을 사용하고, `\[`, `\]`을 사용하지 말고, `$`혹은 `$$`으로 감쌀 것.",
    messages=[
        {
            "role": "user",
            "content": [
                {
                    "type": "document",
                    "source": {
                        "type": "base64",
                        "media_type": "application/pdf",
                        "data": pdf_data
                    }
                },
                {
                    "type": "text",
                    "text": "업르도된 파일의 그림과 수식에 대해서 설명해줘. "
                }
            ]
        }
    ],
)
```


```python
claude_answer = message.content[0].text

print("Claude 답변:\n")
print(claude_answer)
```

    Claude 답변:
    
    제시된 문서는 Transformer 모델의 구조와 attention 메커니즘을 설명하는 내용을 포함하고 있음.
    
    주요 내용은 다음과 같음:
    
    1. Transformer 전체 구조 (Figure 1)
    - Encoder와 Decoder가 각각 N=6개의 동일한 층으로 구성됨
    - Encoder는 Multi-Head Attention과 Feed Forward 층으로 구성
    - Decoder는 Masked Multi-Head Attention, Multi-Head Attention, Feed Forward 층으로 구성
    - 각 층은 Add & Norm (residual connection + layer normalization) 구조를 가짐
    
    2. Attention 메커니즘 (Figure 2)
    - Scaled Dot-Product Attention:
      * Query(Q), Key(K), Value(V)를 입력으로 받음
      * 수식: $Attention(Q,K,V) = softmax(\frac{QK^T}{\sqrt{d_k}})V$
      * $\sqrt{d_k}$로 스케일링하는 이유는 dot product 값이 커지는 것을 방지하기 위함
    
    - Multi-Head Attention:
      * 여러 개의 attention을 병렬로 수행
      * Query, Key, Value를 각각 다른 학습 가능한 linear projection으로 변환
      * h개의 head를 사용하여 각각 독립적으로 attention을 계산
      * 최종적으로 모든 head의 출력을 concatenate하고 linear projection을 적용
    
    이러한 구조를 통해 Transformer는 sequence-to-sequence 태스크를 효과적으로 처리할 수 있음.



```python
cache_creation_input_tokens = message.usage.cache_creation_input_tokens or 0
cache_read_input_tokens = message.usage.cache_read_input_tokens or 0
input_tokens = message.usage.input_tokens
output_tokens = message.usage.output_tokens

print(f"캐시 생성 인풋 토큰수 : {cache_creation_input_tokens}")
print(f"캐시 읽기 인풋 토큰수 : {cache_read_input_tokens}")
print(f"인풋 토큰수 : {input_tokens}")
print(f"아웃풋 토큰수 : {output_tokens}")
```

    캐시 생성 인풋 토큰수 : 0
    캐시 읽기 인풋 토큰수 : 0
    인풋 토큰수 : 4348
    아웃풋 토큰수 : 490



```python
from currency_converter import CurrencyConverter
from IPython.display import display, HTML

# MTok당 USD 요금 정의 (1 MTok = 1,000,000 토큰)
input_rate = 3                 # 인풋 비용 (USD per MTok)
cache_creation_rate = 3.75      # 캐시 생성 비용 (USD per MTok)
cache_read_rate = 0.30          # 캐시 읽기 비용 (USD per MTok)
output_rate = 15                # 아웃풋 비용 (USD per MTok)

# 각 비용 계산
input_cost = (input_tokens / 1_000_000) * input_rate            # 인풋 비용 계산
cache_creation_cost = (cache_creation_input_tokens / 1_000_000) * cache_creation_rate  # 캐시 생성 비용 계산
cache_read_cost = (cache_read_input_tokens / 1_000_000) * cache_read_rate  # 캐시 읽기 비용 계산
output_cost = (output_tokens / 1_000_000) * output_rate         # 아웃풋 비용 계산

# 총 비용 계산
total_cost = input_cost + cache_creation_cost + cache_read_cost + output_cost

# 실시간 환율을 가져와 USD에서 KRW로 변환
currency_converter = CurrencyConverter()
usd_to_krw_rate = currency_converter.convert(1, 'USD', 'KRW')  # 1 USD를 KRW로 변환

# KRW로 비용 계산
input_cost_krw = input_cost * usd_to_krw_rate
cache_creation_cost_krw = cache_creation_cost * usd_to_krw_rate
cache_read_cost_krw = cache_read_cost * usd_to_krw_rate
output_cost_krw = output_cost * usd_to_krw_rate
total_cost_krw = total_cost * usd_to_krw_rate

# 가독성을 높이기 위한 HTML 템플릿 및 스타일 적용
html_template = f"""
<style>
    .cost-table {{
        width: 60%;  /* 테이블 너비 설정 */
        border-collapse: collapse;
        margin: 25px auto;  /* 중앙 정렬 */
        font-size: 16px;
        font-family: Arial, sans-serif;
        color: #333;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);  /* 테이블에 그림자 효과 */
    }}
    .cost-table th, .cost-table td {{
        padding: 12px 15px;  /* 셀 패딩 */
        border: 1px solid #ddd;  /* 테두리 스타일 */
        text-align: center;  /* 모든 셀 중앙 정렬로 변경 */
        background-color: #fff;  /* 모든 셀 흰색 배경 */
    }}
    .cost-table thead th {{
        background-color: #4CAF50;  /* 헤더 배경 색상 */
        color: #fff;
        font-weight: bold;
    }}
    .cost-table tbody td {{
        text-align: center;  /* 본문 셀 중앙 정렬 */
    }}
    .cost-table tbody td:first-child {{
        text-align: center;  /* 첫 번째 열도 중앙 정렬로 변경 */
    }}
    .cost-table tfoot tr {{
        background-color: #e8f5e9;  /* 푸터 배경 색상 */
        font-weight: bold;
        color: #333;
    }}
    .cost-table tfoot td {{
        font-size: 18px;  /* 총 예상 비용 폰트 크기 증가 */
        text-align: center;  /* 푸터 셀 중앙 정렬 */
    }}
    .cost-table tfoot td:first-child {{
        text-align: center;  /* 푸터의 첫 번째 열도 중앙 정렬 */
    }}
</style>

<table class="cost-table">
  <thead>
    <tr>
      <th>항목</th>
      <th>USD</th>
      <th>KRW</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>캐시 생성 비용 (Prompt caching write)</td>
      <td>${cache_creation_cost:.4f}</td>
      <td>₩{cache_creation_cost_krw:.2f}</td>
    </tr>
    <tr>
      <td>캐시 읽기 비용 (Prompt caching read)</td>
      <td>${cache_read_cost:.4f}</td>
      <td>₩{cache_read_cost_krw:.2f}</td>
    </tr>
    <tr>
      <td>Input 비용</td>
      <td>${input_cost:.4f}</td>
      <td>₩{input_cost_krw:.2f}</td>
    </tr>
    <tr>
      <td>Output 비용</td>
      <td>${output_cost:.4f}</td>
      <td>₩{output_cost_krw:.2f}</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td>총 예상 비용</td>
      <td>${total_cost:.4f}</td>
      <td>₩{total_cost_krw:.2f}</td>
    </tr>
  </tfoot>
</table>
"""

# HTML 렌더링을 통해 스타일 적용된 테이블 표시
display(HTML(html_template))
```



<style>
    .cost-table {
        width: 60%;  /* 테이블 너비 설정 */
        border-collapse: collapse;
        margin: 25px auto;  /* 중앙 정렬 */
        font-size: 16px;
        font-family: Arial, sans-serif;
        color: #333;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);  /* 테이블에 그림자 효과 */
    }
    .cost-table th, .cost-table td {
        padding: 12px 15px;  /* 셀 패딩 */
        border: 1px solid #ddd;  /* 테두리 스타일 */
        text-align: center;  /* 모든 셀 중앙 정렬로 변경 */
        background-color: #fff;  /* 모든 셀 흰색 배경 */
    }
    .cost-table thead th {
        background-color: #4CAF50;  /* 헤더 배경 색상 */
        color: #fff;
        font-weight: bold;
    }
    .cost-table tbody td {
        text-align: center;  /* 본문 셀 중앙 정렬 */
    }
    .cost-table tbody td:first-child {
        text-align: center;  /* 첫 번째 열도 중앙 정렬로 변경 */
    }
    .cost-table tfoot tr {
        background-color: #e8f5e9;  /* 푸터 배경 색상 */
        font-weight: bold;
        color: #333;
    }
    .cost-table tfoot td {
        font-size: 18px;  /* 총 예상 비용 폰트 크기 증가 */
        text-align: center;  /* 푸터 셀 중앙 정렬 */
    }
    .cost-table tfoot td:first-child {
        text-align: center;  /* 푸터의 첫 번째 열도 중앙 정렬 */
    }
</style>

<table class="cost-table">
  <thead>
    <tr>
      <th>항목</th>
      <th>USD</th>
      <th>KRW</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>캐시 생성 비용 (Prompt caching write)</td>
      <td>$0.0000</td>
      <td>₩0.00</td>
    </tr>
    <tr>
      <td>캐시 읽기 비용 (Prompt caching read)</td>
      <td>$0.0000</td>
      <td>₩0.00</td>
    </tr>
    <tr>
      <td>Input 비용</td>
      <td>$0.0130</td>
      <td>₩17.98</td>
    </tr>
    <tr>
      <td>Output 비용</td>
      <td>$0.0073</td>
      <td>₩10.13</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td>총 예상 비용</td>
      <td>$0.0204</td>
      <td>₩28.11</td>
    </tr>
  </tfoot>
</table>


