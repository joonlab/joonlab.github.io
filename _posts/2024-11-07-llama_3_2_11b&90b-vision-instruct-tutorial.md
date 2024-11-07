---
layout: single
title:  "Llama-3.2-11b&90b-vision-instruct 모델 튜토리얼 코드"
categories: [코딩, LLM]
tag: [python, llm, api, nvidia, llama]
toc: true
sidebar:
    nav: "counts"
author_profile: false
---

## .ipynb to .md 변환

```bash
!jupyter nbconvert --to markdown "/content/Anthropic(Claude)_PDF_processing&Token_counting_tutorial_by_PARK_JOON.ipynb"
```

## [Made by PARK JOON](https://bio.link/joonpark)

---

## 참고 링크

- [llama-3.2-11b-vision-instruct](https://build.nvidia.com/meta/llama-3.2-11b-vision-instruct)
- [llama-3.2-90b-vision-instruct](https://build.nvidia.com/meta/llama-3.2-90b-vision-instruct)

---

## NVIDIA API KEY 발급 방법

### 위의 참고 링크 중 하나에 접속한 뒤, 다음 이미지 순서대로 참고하여 API KEY 발급받기

![이미지1](https://i.ibb.co/D1YmmP9/Clean-Shot-2024-11-07-at-19-41-35-2x.png)

![이미지2](https://i.ibb.co/C0gMhR8/2.png)

![이미지3](https://i.ibb.co/TKVQy1B/3.png)

![이미지4](https://i.ibb.co/8stJ40v/4.png)

---

## API KEY 설정

```python
from google.colab import userdata

NVIDIA_API_KEY = userdata.get('NVIDIA_API_KEY')
```

### 참고 이미지

![코랩 환경 변수 설정 참고 이미지](https://i.imghippo.com/files/nkS8F1729430186.png)

⚠️ 참고 이미지에서는 OpenAI API KEY를 예시로 들어 설명하고 있습니다.

2️⃣   의 "OPENAI_API_KEY" 를 "NVIDIA_API_KEY" 로 변경해주세요.

---

## 튜토리얼 (OCR)

### 11B & 파일 업로드

```python
import requests
import base64
import httpx
from google.colab import files

def get_image_text_from_base64(image_b64, model_name):
    """
    base64 인코딩된 이미지에서 텍스트 추출함
    """
    assert len(image_b64) < 180_000, "이미지가 너무 큼. assets API 사용 필요함"

    headers = {
        "Authorization": f"Bearer {NVIDIA_API_KEY}",
        "Accept": "application/json"
    }

    invoke_url = f"https://ai.api.nvidia.com/v1/gr/{model_name}/chat/completions"

    prompt = """업로드된 이미지 파일에서 텍스트만 추출(OCR)하고, !!!추출된 텍스트 외에는 아무말도 하지 말 것!!!
    즉, "업로드된 이미지 파일에서 추출한 텍스트는 다음과 같습니다."와 같은 쓸데없는 어구는 !!절대!! 포함되면 안 됨.
    """

    payload = {
        "model": model_name,
        "messages": [
            {
                "role": "user",
                "content": f'{prompt} <img src="data:image/png;base64,{image_b64}" />'
            }
        ],
        "max_tokens": 1024,
        "temperature": 0.4,
        "top_p": 0.95,
        "stream": False
    }

    response = requests.post(invoke_url, headers=headers, json=payload)
    return response.json()['choices'][0]['message']['content']

def process_file_upload(model_name):
    """
    사용자가 업로드한 파일 처리함
    """
    print("파일을 업로드해주세요...")
    uploaded = files.upload()

    for filename in uploaded.keys():
        with open(filename, "rb") as f:
            image_b64 = base64.b64encode(f.read()).decode()
        return get_image_text_from_base64(image_b64, model_name)

def process_url_input(model_name):
    """
    사용자가 입력한 URL 처리함
    """
    url = input("이미지 URL을 입력해주세요: ")
    image_data = base64.b64encode(httpx.get(url).content).decode("utf-8")
    return get_image_text_from_base64(image_data, model_name)

MODEL_CONFIGS = {
    "1": {
        "name": "meta/llama-3.2-11b-vision-instruct",
        "description": "11B 모델 (더 빠름)"
    },
    "2": {
        "name": "meta/llama-3.2-90b-vision-instruct",
        "description": "90B 모델 (더 정확함)"
    }
}

# 모델 선택
print("사용할 모델을 선택해주세요:")
for key, model in MODEL_CONFIGS.items():
    print(f"{key}: {model['description']}")

model_choice = input("선택 (1 또는 2): ")
if model_choice not in MODEL_CONFIGS:
    print("잘못된 선택입니다. 1 또는 2를 입력해주세요.")
    exit()

selected_model = MODEL_CONFIGS[model_choice]["name"]

# 입력 방식 선택
print("\n이미지 텍스트 추출 방식을 선택해주세요:")
print("1: 파일 업로드")
print("2: 이미지 URL 입력")

input_choice = input("선택 (1 또는 2): ")

if input_choice == "1":
    result = process_file_upload(selected_model)
elif input_choice == "2":
    result = process_url_input(selected_model)
else:
    print("잘못된 선택입니다. 1 또는 2를 입력해주세요.")
    exit()

print("\n추출된 텍스트:")
print(result)
```

**Output:**

```
사용할 모델을 선택해주세요:
1: 11B 모델 (더 빠름)
2: 90B 모델 (더 정확함)
선택 (1 또는 2): 1

이미지 텍스트 추출 방식을 선택해주세요:
1: 파일 업로드
2: 이미지 URL 입력
선택 (1 또는 2): 1
파일을 업로드해주세요...
```

```
<IPython.core.display.HTML object>
```

```
Saving kakao.png to kakao (5).png

추출된 텍스트:
Your browser does not support the audio element.
```

### 11B & 이미지 URL

```python
import requests
import base64
import httpx
from google.colab import files

def get_image_text_from_base64(image_b64, model_name):
    """
    base64 인코딩된 이미지에서 텍스트 추출함
    """
    assert len(image_b64) < 180_000, "이미지가 너무 큼. assets API 사용 필요함"

    headers = {
        "Authorization": f"Bearer {NVIDIA_API_KEY}",
        "Accept": "application/json"
    }

    invoke_url = f"https://ai.api.nvidia.com/v1/gr/{model_name}/chat/completions"

    prompt = """업로드된 이미지 파일에서 텍스트만 추출(OCR)하고, !!!추출된 텍스트 외에는 아무말도 하지 말 것!!!
    즉, "업로드된 이미지 파일에서 추출한 텍스트는 다음과 같습니다."와 같은 쓸데없는 어구는 !!절대!! 포함되면 안 됨.
    """

    payload = {
        "model": model_name,
        "messages": [
            {
                "role": "user",
                "content": f'{prompt} <img src="data:image/png;base64,{image_b64}" />'
            }
        ],
        "max_tokens": 1024,
        "temperature": 0.4,
        "top_p": 0.95,
        "stream": False
    }

    response = requests.post(invoke_url, headers=headers, json=payload)
    return response.json()['choices'][0]['message']['content']

def process_file_upload(model_name):
    """
    사용자가 업로드한 파일 처리함
    """
    print("파일을 업로드해주세요...")
    uploaded = files.upload()

    for filename in uploaded.keys():
        with open(filename, "rb") as f:
            image_b64 = base64.b64encode(f.read()).decode()
        return get_image_text_from_base64(image_b64, model_name)

def process_url_input(model_name):
    """
    사용자가 입력한 URL 처리함
    """
    url = input("이미지 URL을 입력해주세요: ")
    image_data = base64.b64encode(httpx.get(url).content).decode("utf-8")
    return get_image_text_from_base64(image_data, model_name)

MODEL_CONFIGS = {
    "1": {
        "name": "meta/llama-3.2-11b-vision-instruct",
        "description": "11B 모델 (더 빠름)"
    },
    "2": {
        "name": "meta/llama-3.2-90b-vision-instruct",
        "description": "90B 모델 (더 정확함)"
    }
}

# 모델 선택
print("사용할 모델을 선택해주세요:")
for key, model in MODEL_CONFIGS.items():
    print(f"{key}: {model['description']}")

model_choice = input("선택 (1 또는 2): ")
if model_choice not in MODEL_CONFIGS:
    print("잘못된 선택입니다. 1 또는 2를 입력해주세요.")
    exit()

selected_model = MODEL_CONFIGS[model_choice]["name"]

# 입력 방식 선택
print("\n이미지 텍스트 추출 방식을 선택해주세요:")
print("1: 파일 업로드")
print("2: 이미지 URL 입력")

input_choice = input("선택 (1 또는 2): ")

if input_choice == "1":
    result = process_file_upload(selected_model)
elif input_choice == "2":
    result = process_url_input(selected_model)
else:
    print("잘못된 선택입니다. 1 또는 2를 입력해주세요.")
    exit()

print("\n추출된 텍스트:")
print(result)
```

**Output:**

```
사용할 모델을 선택해주세요:
1: 11B 모델 (더 빠름)
2: 90B 모델 (더 정확함)
선택 (1 또는 2): 1

이미지 텍스트 추출 방식을 선택해주세요:
1: 파일 업로드
2: 이미지 URL 입력
선택 (1 또는 2): 2
이미지 URL을 입력해주세요: https://pbs.twimg.com/media/FSZuTSZWQAMzlBW.jpg:large

추출된 텍스트:
Attention Is All You Need

Adept
Ashish Vaswani*
Google Brain
avaswani@google.com
Noam Shazeer*
Google Brain
noam@google.com
Niki Parmar*
Google Research
nikip@google.com
Jakob Uszkoreit*
Google Research
uszkoreit@google.com

Llion Jones*
Google Research
llion@google.com
Aidan N. Gomez*
University of Toronto
aidan@cs.toronto.edu
Illia Polosukhin*
illia.polosukhin@gmail.com
Lukasz Kaiser*
Google Brain
lukaszaiser@google.com

co:here
NEAR INCORPORATED
Character.ai
Inceptive
```

### 90B & 파일 업로드

```python
import requests
import base64
import httpx
from google.colab import files

def get_image_text_from_base64(image_b64, model_name):
    """
    base64 인코딩된 이미지에서 텍스트 추출함
    """
    assert len(image_b64) < 180_000, "이미지가 너무 큼. assets API 사용 필요함"

    headers = {
        "Authorization": f"Bearer {NVIDIA_API_KEY}",
        "Accept": "application/json"
    }

    invoke_url = f"https://ai.api.nvidia.com/v1/gr/{model_name}/chat/completions"

    prompt = """업로드된 이미지 파일에서 텍스트만 추출(OCR)하고, !!!추출된 텍스트 외에는 아무말도 하지 말 것!!!
    즉, "업로드된 이미지 파일에서 추출한 텍스트는 다음과 같습니다."와 같은 쓸데없는 어구는 !!절대!! 포함되면 안 됨.
    """

    payload = {
        "model": model_name,
        "messages": [
            {
                "role": "user",
                "content": f'{prompt} <img src="data:image/png;base64,{image_b64}" />'
            }
        ],
        "max_tokens": 1024,
        "temperature": 0.4,
        "top_p": 0.95,
        "stream": False
    }

    response = requests.post(invoke_url, headers=headers, json=payload)
    return response.json()['choices'][0]['message']['content']

def process_file_upload(model_name):
    """
    사용자가 업로드한 파일 처리함
    """
    print("파일을 업로드해주세요...")
    uploaded = files.upload()

    for filename in uploaded.keys():
        with open(filename, "rb") as f:
            image_b64 = base64.b64encode(f.read()).decode()
        return get_image_text_from_base64(image_b64, model_name)

def process_url_input(model_name):
    """
    사용자가 입력한 URL 처리함
    """
    url = input("이미지 URL을 입력해주세요: ")
    image_data = base64.b64encode(httpx.get(url).content).decode("utf-8")
    return get_image_text_from_base64(image_data, model_name)

MODEL_CONFIGS = {
    "1": {
        "name": "meta/llama-3.2-11b-vision-instruct",
        "description": "11B 모델 (더 빠름)"
    },
    "2": {
        "name": "meta/llama-3.2-90b-vision-instruct",
        "description": "90B 모델 (더 정확함)"
    }
}

# 모델 선택
print("사용할 모델을 선택해주세요:")
for key, model in MODEL_CONFIGS.items():
    print(f"{key}: {model['description']}")

model_choice = input("선택 (1 또는 2): ")
if model_choice not in MODEL_CONFIGS:
    print("잘못된 선택입니다. 1 또는 2를 입력해주세요.")
    exit()

selected_model = MODEL_CONFIGS[model_choice]["name"]

# 입력 방식 선택
print("\n이미지 텍스트 추출 방식을 선택해주세요:")
print("1: 파일 업로드")
print("2: 이미지 URL 입력")

input_choice = input("선택 (1 또는 2): ")

if input_choice == "1":
    result = process_file_upload(selected_model)
elif input_choice == "2":
    result = process_url_input(selected_model)
else:
    print("잘못된 선택입니다. 1 또는 2를 입력해주세요.")
    exit()

print("\n추출된 텍스트:")
print(result)
```

**Output:**

```
사용할 모델을 선택해주세요:
1: 11B 모델 (더 빠름)
2: 90B 모델 (더 정확함)
선택 (1 또는 2): 2

이미지 텍스트 추출 방식을 선택해주세요:
1: 파일 업로드
2: 이미지 URL 입력
선택 (1 또는 2): 1
파일을 업로드해주세요...
```

```
<IPython.core.display.HTML object>
```

```
Saving kakao.png to kakao (4).png

추출된 텍스트:
<progressBar class="progress-bar"></progress> <audio id="audioPlayer" src="https://raw.githubusercontent.com/joonlab/audio-share/main/research_paper_podcast_by_IU-Can_LLMs_Generate_Novel_Research_Ideas.mp3" type="audio/mpeg"></audio>
```

### 90B & 이미지 URL

```python
import requests
import base64
import httpx
from google.colab import files

def get_image_text_from_base64(image_b64, model_name):
    """
    base64 인코딩된 이미지에서 텍스트 추출함
    """
    assert len(image_b64) < 180_000, "이미지가 너무 큼. assets API 사용 필요함"

    headers = {
        "Authorization": f"Bearer {NVIDIA_API_KEY}",
        "Accept": "application/json"
    }

    invoke_url = f"https://ai.api.nvidia.com/v1/gr/{model_name}/chat/completions"

    prompt = """업로드된 이미지 파일에서 텍스트만 추출(OCR)하고, !!!추출된 텍스트 외에는 아무말도 하지 말 것!!!
    즉, "업로드된 이미지 파일에서 추출한 텍스트는 다음과 같습니다."와 같은 쓸데없는 어구는 !!절대!! 포함되면 안 됨.
    """

    payload = {
        "model": model_name,
        "messages": [
            {
                "role": "user",
                "content": f'{prompt} <img src="data:image/png;base64,{image_b64}" />'
            }
        ],
        "max_tokens": 1024,
        "temperature": 0.4,
        "top_p": 0.95,
        "stream": False
    }

    response = requests.post(invoke_url, headers=headers, json=payload)
    return response.json()['choices'][0]['message']['content']

def process_file_upload(model_name):
    """
    사용자가 업로드한 파일 처리함
    """
    print("파일을 업로드해주세요...")
    uploaded = files.upload()

    for filename in uploaded.keys():
        with open(filename, "rb") as f:
            image_b64 = base64.b64encode(f.read()).decode()
        return get_image_text_from_base64(image_b64, model_name)

def process_url_input(model_name):
    """
    사용자가 입력한 URL 처리함
    """
    url = input("이미지 URL을 입력해주세요: ")
    image_data = base64.b64encode(httpx.get(url).content).decode("utf-8")
    return get_image_text_from_base64(image_data, model_name)

MODEL_CONFIGS = {
    "1": {
        "name": "meta/llama-3.2-11b-vision-instruct",
        "description": "11B 모델 (더 빠름)"
    },
    "2": {
        "name": "meta/llama-3.2-90b-vision-instruct",
        "description": "90B 모델 (더 정확함)"
    }
}

# 모델 선택
print("사용할 모델을 선택해주세요:")
for key, model in MODEL_CONFIGS.items():
    print(f"{key}: {model['description']}")

model_choice = input("선택 (1 또는 2): ")
if model_choice not in MODEL_CONFIGS:
    print("잘못된 선택입니다. 1 또는 2를 입력해주세요.")
    exit()

selected_model = MODEL_CONFIGS[model_choice]["name"]

# 입력 방식 선택
print("\n이미지 텍스트 추출 방식을 선택해주세요:")
print("1: 파일 업로드")
print("2: 이미지 URL 입력")

input_choice = input("선택 (1 또는 2): ")

if input_choice == "1":
    result = process_file_upload(selected_model)
elif input_choice == "2":
    result = process_url_input(selected_model)
else:
    print("잘못된 선택입니다. 1 또는 2를 입력해주세요.")
    exit()

print("\n추출된 텍스트:")
print(result)
```

**Output:**

```
사용할 모델을 선택해주세요:
1: 11B 모델 (더 빠름)
2: 90B 모델 (더 정확함)
선택 (1 또는 2): 2

이미지 텍스트 추출 방식을 선택해주세요:
1: 파일 업로드
2: 이미지 URL 입력
선택 (1 또는 2): 2
이미지 URL을 입력해주세요: https://pbs.twimg.com/media/FSZuTSZWQAMzlBW.jpg:large

추출된 텍스트:
Attention Is All You Need
Adept
Ashish Vaswani*
Google Brain
avaswani@google.com
Noam Shazeer*
Google Brain
noam@google.com
Niki Parmar*
Google Research
nikip@google.com
Jakob Uszkoreit*
Google Research
usz@google.com
Llion Jones*
Google Research
llion@google.com
Aidan N. Gomez*
University of Toronto
aidan@cs.toronto.edu
Łukasz Kaiser*
Google Brain
lukaszkaiser@google.com
Illia Polosukhin*
illia.polosukhin@gmail.com
NEAR INCORPORATED
```