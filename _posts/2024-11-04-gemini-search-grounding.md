---
layout: single
title: "[Gemini] Search Grounding tutorial"
categories: coding
tag: [python, gemini]
toc: true
author_profile: false
sidebar:
    nav: "counts"
# search: false   # 검색해도 이 포스팅이 걸리지 않게 함.    
---

# [Made by PARK JOON](https://bio.link/joonpark)

---
# [Gemini API 발급 방법](https://llm-project-joon.site/API_KEY_%E1%84%87%E1%85%A1%E1%86%AF%E1%84%80%E1%85%B3%E1%86%B8_%E1%84%87%E1%85%A1%E1%86%BC%E1%84%87%E1%85%A5%E1%86%B8)

---
# 필요한 라이브러리 설치


```
!pip install -U google-generativeai>=0.8.3
```

# API KEY 설정

요금제가 유료로 설정되어있는 API KEY만 search-grounding 기능이 활성화가 됨.  ➡️   [이미지 참고](https://i.ibb.co/sP6cQKn/f954c8e4e818.png)  |  [링크 참고](https://ai.google.dev/pricing#1_5flash)


```
import google.generativeai as genai
from IPython.display import Markdown, HTML
```


```
from google.colab import userdata
GEMINI_API_KEY=userdata.get('GEMINI_API_KEY')
genai.configure(api_key=GEMINI_API_KEY)
```

## 참고 이미지

[코랩 환경 변수 설정 참고 이미지](https://i.imghippo.com/files/nkS8F1729430186.png)

⚠️ 참고 이미지에서는 OpenAI API KEY를 예시로 들어 설명하고 있습니다.

2️⃣의 "OPENAI_API_KEY" 를 "GEMINI_API_KEY" 로 변경해주세요.

# 튜토리얼

- `GoogleSearchRetrieval`은 Google이 제공하는 공개 웹 데이터를 검색하기 위한 도구

- 주요 기능:
 - `GoogleSearchRetrieval`의 동적 검색 검색을 통해 실시간 데이터로 질의 답변을 생성함

- 사용 방법:
 - `GoogleSearchRetrieval`에 문자열 또는 딕셔너리를 필드에 전달함
 - `generate_content`의 `tools` 매개변수에 `google_search_retrieval`을 전달함


```
model = genai.GenerativeModel('models/gemini-1.5-pro-002')
user_input = input("메시지를 입력하세요: ")

response = model.generate_content(contents=user_input,
                                  tools='google_search_retrieval')


print("\nGemini 답변: \n")
Markdown(response.candidates[0].content.parts[0].text)
```
```
    메시지를 입력하세요: 흑백요리사 식당
    
    Gemini 답변: 
    





넷플릭스 예능 프로그램 "흑백요리사: 요리 계급 전쟁"에 출연하는 백수저와 흑수저 요리사들의 식당 정보에 대해 문의하셨네요.  출연하는 셰프들의 식당은 매우 다양하며, 한식, 일식, 중식, 양식, 디저트 등 다양한 종류의 요리를 선보입니다. 

백수저 셰프들의 식당으로는 최강록 셰프의 '식당 네오', 정지선 셰프의 '티엔미미', 최지형 셰프의 '리북방', 조셉 리저우드 셰프의 '에빗', 김도운 셰프의 '윤서울', 여경래 셰프의 '홍보각', 최현석 셰프의 '쵸이닷', '중앙감속기', 박준우 셰프의 '오쁘띠베르', 오세득 셰프의 '친밀', '오팬파이어', 장호준 셰프의 '네기', 남정석 셰프의 '로컬릿', 파브리 셰프의 '파브리키친', 김승민 셰프의 '모리노 아루요', 방기수 셰프의 '깃든', 선경 롱기스트 셰프의 식당, 안유성 셰프의 '가매일식', 이영숙 셰프의 '나경버섯', 조은주 셰프의 '터치더 스카이' 등이 있습니다.

흑수저 셰프들의 식당 정보는 프로그램 진행 상황에 따라 추가적으로 공개되고 있으니 참고 바랍니다.  예를 들어, '이야이야앤프렌즈'는 변성현 셰프와 박태윤 크리에이티브 디렉터가 운영하는 곳으로, 그리스 지중해 요리를 선보입니다.


더 자세한 정보는 "흑백요리사" 관련 기사나 블로그, 식신 앱 등을 참고하시면 셰프들의 식당 위치, 메뉴, 특징 등을 더욱 상세하게 확인할 수 있습니다. (2024년 11월 1일 기준 정보)




---

이번엔 Gemini API를 통해 수집된 렌더링된 HTML 콘텐츠를 살펴볼 것.

> 중요: 검색 그라운딩 사용 시 다음의 [요구사항](https://googledevai.devsite.corp.google.com/gemini-api/docs/grounding/search-suggestions?hl=en#requirements)을 **반드시** 준수해야 함:

- 검색 제안을 제공된 그대로 표시해야 함
- 사용자가 검색 제안과 상호작용할 때 Google 검색결과 페이지(SRP)로 직접 이동시켜야 함
```

```
HTML(response.candidates[0].grounding_metadata.search_entry_point.rendered_content)
```




<style>
.container {
  align-items: center;
  border-radius: 8px;
  display: flex;
  font-family: Google Sans, Roboto, sans-serif;
  font-size: 14px;
  line-height: 20px;
  padding: 8px 12px;
}
.chip {
  display: inline-block;
  border: solid 1px;
  border-radius: 16px;
  min-width: 14px;
  padding: 5px 16px;
  text-align: center;
  user-select: none;
  margin: 0 8px;
  -webkit-tap-highlight-color: transparent;
}
.carousel {
  overflow: auto;
  scrollbar-width: none;
  white-space: nowrap;
  margin-right: -12px;
}
.headline {
  display: flex;
  margin-right: 4px;
}
.gradient-container {
  position: relative;
}
.gradient {
  position: absolute;
  transform: translate(3px, -9px);
  height: 36px;
  width: 9px;
}
@media (prefers-color-scheme: light) {
  .container {
    background-color: #fafafa;
    box-shadow: 0 0 0 1px #0000000f;
  }
  .headline-label {
    color: #1f1f1f;
  }
  .chip {
    background-color: #ffffff;
    border-color: #d2d2d2;
    color: #5e5e5e;
    text-decoration: none;
  }
  .chip:hover {
    background-color: #f2f2f2;
  }
  .chip:focus {
    background-color: #f2f2f2;
  }
  .chip:active {
    background-color: #d8d8d8;
    border-color: #b6b6b6;
  }
  .logo-dark {
    display: none;
  }
  .gradient {
    background: linear-gradient(90deg, #fafafa 15%, #fafafa00 100%);
  }
}
@media (prefers-color-scheme: dark) {
  .container {
    background-color: #1f1f1f;
    box-shadow: 0 0 0 1px #ffffff26;
  }
  .headline-label {
    color: #fff;
  }
  .chip {
    background-color: #2c2c2c;
    border-color: #3c4043;
    color: #fff;
    text-decoration: none;
  }
  .chip:hover {
    background-color: #353536;
  }
  .chip:focus {
    background-color: #353536;
  }
  .chip:active {
    background-color: #464849;
    border-color: #53575b;
  }
  .logo-light {
    display: none;
  }
  .gradient {
    background: linear-gradient(90deg, #1f1f1f 15%, #1f1f1f00 100%);
  }
}
</style>
<div class="container">
  <div class="headline">
    <svg class="logo-light" width="18" height="18" viewBox="9 9 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M42.8622 27.0064C42.8622 25.7839 42.7525 24.6084 42.5487 23.4799H26.3109V30.1568H35.5897C35.1821 32.3041 33.9596 34.1222 32.1258 35.3448V39.6864H37.7213C40.9814 36.677 42.8622 32.2571 42.8622 27.0064V27.0064Z" fill="#4285F4"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M26.3109 43.8555C30.9659 43.8555 34.8687 42.3195 37.7213 39.6863L32.1258 35.3447C30.5898 36.3792 28.6306 37.0061 26.3109 37.0061C21.8282 37.0061 18.0195 33.9811 16.6559 29.906H10.9194V34.3573C13.7563 39.9841 19.5712 43.8555 26.3109 43.8555V43.8555Z" fill="#34A853"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M16.6559 29.8904C16.3111 28.8559 16.1074 27.7588 16.1074 26.6146C16.1074 25.4704 16.3111 24.3733 16.6559 23.3388V18.8875H10.9194C9.74388 21.2072 9.06992 23.8247 9.06992 26.6146C9.06992 29.4045 9.74388 32.022 10.9194 34.3417L15.3864 30.8621L16.6559 29.8904V29.8904Z" fill="#FBBC05"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M26.3109 16.2386C28.85 16.2386 31.107 17.1164 32.9095 18.8091L37.8466 13.8719C34.853 11.082 30.9659 9.3736 26.3109 9.3736C19.5712 9.3736 13.7563 13.245 10.9194 18.8875L16.6559 23.3388C18.0195 19.2636 21.8282 16.2386 26.3109 16.2386V16.2386Z" fill="#EA4335"/>
    </svg>
    <svg class="logo-dark" width="18" height="18" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
      <circle cx="24" cy="23" fill="#FFF" r="22"/>
      <path d="M33.76 34.26c2.75-2.56 4.49-6.37 4.49-11.26 0-.89-.08-1.84-.29-3H24.01v5.99h8.03c-.4 2.02-1.5 3.56-3.07 4.56v.75l3.91 2.97h.88z" fill="#4285F4"/>
      <path d="M15.58 25.77A8.845 8.845 0 0 0 24 31.86c1.92 0 3.62-.46 4.97-1.31l4.79 3.71C31.14 36.7 27.65 38 24 38c-5.93 0-11.01-3.4-13.45-8.36l.17-1.01 4.06-2.85h.8z" fill="#34A853"/>
      <path d="M15.59 20.21a8.864 8.864 0 0 0 0 5.58l-5.03 3.86c-.98-2-1.53-4.25-1.53-6.64 0-2.39.55-4.64 1.53-6.64l1-.22 3.81 2.98.22 1.08z" fill="#FBBC05"/>
      <path d="M24 14.14c2.11 0 4.02.75 5.52 1.98l4.36-4.36C31.22 9.43 27.81 8 24 8c-5.93 0-11.01 3.4-13.45 8.36l5.03 3.85A8.86 8.86 0 0 1 24 14.14z" fill="#EA4335"/>
    </svg>
    <div class="gradient-container"><div class="gradient"></div></div>
  </div>
  <div class="carousel">
    <a class="chip" href="https://vertexaisearch.cloud.google.com/grounding-api-redirect/AZnLMfzHdme-PvwPEL7T7ONidaRDUWDxwpjp-B6R658YsDPzNbBhrRvO2Rg-kw7Zu9-QvtiqrnNd5Najum1fFgSIRVypPSErYqkFn2P67-JIwjSs15_6101G01aGptWedr9eEwC2r0W6CJDMh2tgxDi96scwQHJ9-wt5wAbPkGTSFGcApb9OPg0J3oGFNhnL9hbWMbSD0a8S_t7zo17KCQZXrh0vzCHBzNJerkqejFyaBqXqpkX112LToGotdW78gM_oornmRJ62">흑백요리사 식당</a>
  </div>
</div>




또한 검색 쿼리에 사용된 소스로 연결되는 링크를 받게 될 것.


```
response.candidates[0].grounding_metadata.grounding_chunks
```



```
    [web {
      uri: "https://vertexaisearch.cloud.google.com/grounding-api-redirect/AZnLMfzjg_4DcUKhQJ9CMb9lo-5rDqqGFkDgwigumO_P6cKdCArZblq-MxCbBDzkFgnI4tI75dQMt9HNh3uwaD65n9gHSJEAtAapMt2BfLKNQO1T4Gx-FMcZplfBg3cSckbiwhTsviXlb8KzPw=="
      title: "naver.com"
    }
    , web {
      uri: "https://vertexaisearch.cloud.google.com/grounding-api-redirect/AZnLMfz7L_1KKs4ix4TOpp7qYYa0CMyhBj6r0mXGSKlq2f9hfbn-76vcH-AJZpE5WjH9vSpS3UiHOhNHOWrVZuWJ24hA20xEkMPzTt3LRJ5iQKhElHw4De18W3Gld4MZXLD6trguv8aY2g=="
      title: "etoday.co.kr"
    }
    ]
```

그리고 어떤 부분이 어떤 소스에서 인용되었는지 보여주는 참조 구간도 제공받게 될 것.


```
grounding_supports = response.candidates[0].grounding_metadata.grounding_supports
```


```
import re
import codecs

for i, grounding_support in enumerate(grounding_supports):
    # 객체를 문자열로 변환
    grounding_support_str = str(grounding_support)
    print(f"=== Sequence {i+1} ===")

    # start_index 추출
    start_index = re.search(r'start_index: (\d+)', grounding_support_str)
    print("start_index:", start_index.group(1))

    # end_index 추출
    end_index = re.search(r'end_index: (\d+)', grounding_support_str)
    print("end_index:", end_index.group(1))

    # text 추출
    match = re.search(r'text: "(.*?)"', grounding_support_str)
    text = match.group(1)
    # 이스케이프된 시퀀스를 디코딩
    decoded_text = codecs.escape_decode(text)[0].decode('utf-8')
    print("text:", decoded_text)

    # grounding_chunk_indices 추출 및 형식 변경
    grounding_indices = re.findall(r'grounding_chunk_indices: (\d+)', grounding_support_str)
    grounding_indices_str = ', '.join(grounding_indices)
    print("grounding_chunk_indices:", grounding_indices_str)

    # confidence_scores 추출 및 형식 변경
    confidence = re.findall(r'confidence_scores: (\d+\.\d+)', grounding_support_str)
    confidence_str = ', '.join(confidence)
    print("confidence_scores:", confidence_str)
    print()
```

    === Sequence 1 ===
    start_index: 1761
    end_index: 2082
    text: * **프로그램 개요**: '흑백요리사'는  숨은 실력을 가진 흑수저 셰프들이  유명 스타 셰프인 백수저들에게 도전하는 요리 서바이벌 프로그램입니다. 100인의 셰프들이 펼치는 요리 대결을 통해  다양한 요리와 셰프들의 이야기를 볼 수 있습니다.
    grounding_chunk_indices: 0
    confidence_scores: 0.7067956328392029
    
    === Sequence 2 ===
    start_index: 2084
    end_index: 2165
    text: * **심사위원**: 백종원, 안성재 셰프가 심사를 맡고 있습니다.
    grounding_chunk_indices: 0, 1
    confidence_scores: 0.9411308765411377, 0.9411308765411377
    
    === Sequence 3 ===
    start_index: 2167
    end_index: 2340
    text: * **방영 정보**: 넷플릭스에서 시청 가능합니다.  2024년 9월 17일 첫 방송을 시작했고 매주 화요일에 새로운 에피소드가 공개됩니다.
    grounding_chunk_indices: 0
    confidence_scores: 0.6000968217849731
    


### search grounding parameter 사용자 정의

딕셔너리 구현의 경우, `mode` 또는 `dynamic_threshold` 키-값 쌍을 전달할 필요가 없음. 값을 전달하지 않으면 기본값이 생성됨. 다음 코드 셀에서 이를 확인할 수 있음. `mode` 값에는 다음 두 가지 사양 중 하나를 전달할 수 있음:

1. `unspecified`: 항상 검색을 실행함
2. `dynamic`: 시스템이 필요하다고 판단할 때만 검색을 실행함

`dynamic_threshold`는 반환된 답변의 관련성을 결정하는 임계값 역할을 하는 float 값임. 답변의 변동 폭을 원하는 정도에 따라 이 매개변수를 조정할 수 있음

- mode : "unspecified"
- dynamic_threshold : 0.5


```
model = genai.GenerativeModel('models/gemini-1.5-pro-002')

user_input = input("메시지를 입력하세요: ")

response = model.generate_content(
    contents=user_input,
    tools={
        "google_search_retrieval": {
            "dynamic_retrieval_config": {
                "mode": "unspecified",
                "dynamic_threshold": 0.5
            }
        }
    }
)

print("\nGemini 답변: \n")
Markdown(response.candidates[0].content.parts[0].text)
```

```
    메시지를 입력하세요: 흑백요리사 식당
    
    Gemini 답변: 
    





넷플릭스 예능 프로그램 "흑백요리사: 요리 계급 전쟁"에 출연하는 백수저와 흑수저 셰프들의 식당 정보를 정리해 드리겠습니다.  출연진이 많아 모든 식당을 다룰 순 없지만, 대표적인 셰프들의 식당을 소개하고, 프로그램 관련 정보도 함께 안내합니다.

**백수저 셰프들의 식당**

* **최현석:** 쵸이닷, 중앙감속기 등. 한때 여러 요리 프로그램 심사위원으로 활동했고, 양식 요리의 선구자로 알려져 있습니다.
* **오세득:** 친밀, 오팬파이어. 제주도에서 모던 한식 요리를 선보이는 셰프입니다. '친밀'에서는 전통 한식을, '오팬파이어'에서는 퓨전 한식을 제공합니다.
* **김승민:** 모리노 아루요. 마스터셰프 코리아 시즌 1 우승자로, 덮밥 요리를 전문으로 합니다.
* **최강록:** 식당 네오. 일식 기반의 코스 요리를 선보입니다.
* **정지선:** 티엔미미. 딤섬 전문점으로 "딤섬 여왕"으로 불립니다.
* **김도운:** 윤서울, 면서울. 독창적인 한식 요리를 만드는 셰프로, 전통 발효 및 저장 음식에 다국적 조리 기법을 접목한 새로운 미식 경험을 제공합니다. 특히 윤서울은 미슐랭 스타 레스토랑입니다.
* **여경래:** 홍보각. 중식 요리의 대가로 중국에서도 유명합니다.

**흑수저 셰프들의 식당**

* **이영숙:** 나경버섯농가. 한식대첩 2 우승자 출신으로, 한식 명인으로 불립니다. 쇼핑몰을 통해 김치, 장, 장아찌 등의 제철 식재료를 판매하기도 합니다.
* **박태윤 & 변성현:** 이야이야앤프렌즈. 그리스 지중해 감성을 담은 5층 규모의 플래그십 스토어입니다. 변성현 셰프는 브런치 메뉴 개발을, 박태윤 크리에이티브 디렉터는 F&B 메뉴 구성을 담당하며, 올리브 오일 등을 판매하는 쇼룸도 운영합니다.

**프로그램 정보**

* "흑백요리사: 요리 계급 전쟁"은 백수저 셰프들에게 흑수저 셰프들이 도전하는 요리 서바이벌 프로그램입니다.
* 심사위원은 백종원과 안성재 셰프입니다.
* 총 12부작으로 구성되어 있으며, 넷플릭스에서 시청할 수 있습니다. (2024년 9월 17일 첫 방송, 매주 화요일 새로운 에피소드 공개)

**참고사항:** 위 정보는 2024년 11월 1일 기준으로 작성되었으며, 변동될 수 있습니다.  각 식당의 자세한 정보(위치, 메뉴, 가격 등)는 인터넷 검색을 통해 확인하실 수 있습니다.
```



- mode : "unspecified"


```
model = genai.GenerativeModel('models/gemini-1.5-pro-002')

user_input = input("메시지를 입력하세요: ")

response = model.generate_content(
    contents=user_input,
    tools={
        "google_search_retrieval": {
            "dynamic_retrieval_config": {
                "mode": "unspecified"
            }
        }
    }
)

print("\nGemini 답변: \n")
Markdown(response.candidates[0].content.parts[0].text)
```

```
    메시지를 입력하세요: 흑백요리사 식당
    
    Gemini 답변: 
    





넷플릭스 예능 프로그램 "흑백요리사: 요리 계급 전쟁"에 출연하는 요리사들의 식당 정보에 대해 문의하셨네요.  요청하신 정보를 정리해 드리겠습니다.

**백수저 셰프들의 식당**

* **최강록**: 식당 네오 (일식 기반 코스 요리)
* **정지선**: 티엔미미 (딤섬 전문)
* **최지형**: 리북방 (이북 코스 요리)
* **조셉 리저우드**: 에빗 (한식, 미슐랭 1스타)
* **김도운**: 윤서울 (한식, 미슐랭 1스타)
* **여경래**: 홍보각 (중식)
* **최현석**: 쵸이닷, 중앙감속기 등 (양식)
* **박준우**: 오쁘띠베르 (디저트 카페)
* **오세득**: 친밀, 오팬파이어 (제주 모던 한식)
* **장호준**: 네기 (네기다이닝라운지 총괄 셰프)
* **남정석**: 로컬릿 (채소 요리 전문)
* **파브리**: 파브리키친 (이탈리아 음식, 미슐랭 1스타)
* **김승민**: 모리노 아루요 (덮밥)
* **방기수**: 깃든 (고기 요리)
* **선경 롱기스트**: 미국 음식
* **안유성**: 가매일식 (일식)
* **이영숙**: 나경버섯 (한식)
* **조은주**: 터치더 스카이 (양식)

**흑수저 셰프들의 식당**

프로그램에서 '흑수저' 셰프들의 식당 정보도 확인할 수 있다고 합니다. 하지만 출처에서 제공된 정보에는 흑수저 셰프들의 식당 이름이 명시적으로 나와 있지 않네요. 흑수저 셰프들의 정보는 프로그램을 통해 확인하시거나, 다른 경로를 통해 찾아보셔야 할 것 같습니다.

**기타 관련 정보**

* '이야이야앤프렌즈'라는 그리스 지중해 감성의 레스토랑은 "흑백요리사" 출연진 중 박태윤(크리에이티브 디렉터), 변성현(셰프)과 관련이 있습니다.
* 프로그램 레스토랑 미션에서 최현석 팀은 '억수르 기사식당'이라는 이름으로 '랍스터 마라 크림 짬뽕'을, 트리플스타 팀은 '트리플 반점'이라는 이름으로 '마라 크림 새우 딤섬'을, 에드워드 리 팀은 'Jang 아저씨 식당'이라는 이름으로 '캐비아 모둠전'을 선보였습니다.

**참고:** 위 정보는 제공된 출처를 바탕으로 정리한 내용이며, 2024년 11월 1일 현재를 기준으로 합니다.  프로그램 진행 상황에 따라 변동될 수 있다는 점 유의해 주세요.  더 자세한 정보는 프로그램 공식 웹사이트나 관련 기사를 참고하시는 것이 좋겠습니다.
```



- mode : "dynamic"
- dynamic_threshold : 0.5


```
model = genai.GenerativeModel('models/gemini-1.5-pro-002')

user_input = input("메시지를 입력하세요: ")

response = model.generate_content(
    contents=user_input,
    tools={
        "google_search_retrieval": {
            "dynamic_retrieval_config": {
                "mode": "dynamic",
                "dynamic_threshold": 0.5
            }
        }
    }
)

print("\nGemini 답변: \n")
Markdown(response.candidates[0].content.parts[0].text)
```
```
    메시지를 입력하세요: 흑백요리사 식당





넷플릭스 예능 프로그램 "흑백요리사: 요리 계급 전쟁"에 출연하는 백수저와 흑수저 셰프들의 식당 정보에 대해 문의하셨네요.  출연 셰프들의 식당과 요리 종류를 정리해 드리겠습니다.  (2024년 11월 1일 기준 정보입니다. 셰프들의 식당 운영 정보는 변동될 수 있습니다.)

**백수저 셰프들의 식당**

* **최강록**: 식당 네오 (일식 기반 코스 요리)
* **정지선**: 티엔미미 (딤섬 전문)
* **최지형**: 리북방 (이북 코스 요리)
* **조셉 리저우드**: 에빗 (한식)
* **김도윤**: 윤서울, 면서울 (한식, 특히 발효 및 저장 음식에 다국적 조리 기법을 응용한 요리)
* **여경래**: 홍보각 (중식)
* **최현석**: 쵸이닷, 중앙감속기 등 (양식)
* **박준우**: 오쁘띠베르 (디저트 카페)
* **오세득**: 친밀 (전통 한식), 오팬파이어 (퓨전 한식)
* **장호준**: 네기 (일식)
* **남정석**: 로컬릿 (채소 요리)
* **파브리**: 파브리키친 (이탈리아 요리)
* **김승민**: 모리노 아루요 (덮밥)
* **방기수**: 깃든 (고기 요리)
* **선경 롱기스트**:  미국 음식
* **안유성**: 가매일식 (일식)
* **이영숙**: 나경버섯 (한식,  제철 식재료 김치, 장, 장아찌 등 판매)
* **조은주**: 터치더 스카이 (다양한 요리)


**흑수저 셰프들의 식당**

흑수저 셰프들의 경우, 프로그램 내에서 소개된 정보 외에 정확한 식당 정보를 찾기 어려운 경우가 많습니다. 프로그램의 진행에 따라 추가 정보가 공개될 수 있습니다. 현재까지 확인된 정보는 다음과 같습니다.

* **이야이야앤프렌즈**: 박태윤 (크리에이티브 디렉터), 변성현 (셰프) - 그리스 지중해식 브런치, 올리브 오일 등 판매


**식당 위치 및 추가 정보 확인 방법**

* 식신, 중앙일보 등의 웹사이트나 앱에서 "흑백요리사"를 검색하면 출연 셰프들의 식당 정보를 확인할 수 있습니다.
* 식신 앱의 "저장" 기능을 활용하면 원하는 식당 목록을 만들고 공유할 수도 있습니다.
*  블로그나 기사 등을 통해 셰프들의 식당 정보, 위치,  추천 메뉴 등을 찾아볼 수 있습니다.


**참고 사항**

* 위 정보는 현재까지 공개된 정보를 바탕으로 정리한 것이며,  변경될 가능성이 있습니다.
* 모든 셰프의 식당 정보가 공개된 것은 아니며,  프로그램 진행에 따라  더 많은 정보가 나올 수 있습니다.
```





- mode : "dynamic"


```
model = genai.GenerativeModel('models/gemini-1.5-pro-002')

user_input = input("메시지를 입력하세요: ")

response = model.generate_content(
    contents=user_input,
    tools={
        "google_search_retrieval": {
            "dynamic_retrieval_config": {
                "mode": "dynamic"
            }
        }
    }
)

print("\nGemini 답변: \n")
Markdown(response.candidates[0].content.parts[0].text)
```
```
    메시지를 입력하세요: 흑백요리사 식당





넷플릭스 예능 프로그램 "흑백요리사: 요리 계급 전쟁"에 출연하는 백수저와 흑수저 셰프들의 식당 정보에 대해 문의하셨네요.  출연 셰프들의 식당과 요리 종류를 정리해 드리겠습니다. 최현석 셰프의 '쵸이닷', '달리아 다이닝', 황진선 셰프의 '진진', 오세득 셰프의 '오팬파이어', '친밀' 등 다양한 셰프들의 식당 정보를 확인할 수 있습니다. '흑수저' 셰프들의 식당 정보도 포함되어 있습니다.  김도윤 셰프의 '윤서울', '면서울'에서는 독창적인 한식 요리를, 이영숙 셰프의 '나경버섯농가'에서는 전통 한식을 맛볼 수 있습니다. 김승민 셰프는 '모리노 아루요'에서 덮밥을 전문으로 하고 있습니다.

더 자세한 정보는 인터넷 검색을 통해 '흑백요리사 식당' 또는 '흑백요리사 출연진 식당' 등의 키워드로 검색하시면 위치, 메뉴, 가격 등을 포함한 더 많은 정보를 얻으실 수 있습니다. 식신, 중앙일보, 헤이팝, 네이버 블로그 등에서 관련 정보를 제공하고 있습니다.  프로그램에 소개된 식당들은 많은 사람들의 관심을 받아 예약이 어려울 수 있으니, 방문 전에 예약하는 것이 좋습니다.
```




- dynamic_threshold : 0.5


```
model = genai.GenerativeModel('models/gemini-1.5-pro-002')

user_input = input("메시지를 입력하세요: ")

response = model.generate_content(
    contents=user_input,
    tools={
        "google_search_retrieval": {
            "dynamic_retrieval_config": {
                "dynamic_threshold": 0.5
            }
        }
    }
)

print("\nGemini 답변: \n")
Markdown(response.candidates[0].content.parts[0].text)
```
```
    메시지를 입력하세요: 흑백요리사 식당





넷플릭스 예능 프로그램 "흑백요리사: 요리 계급 전쟁"에 출연하는 백수저와 흑수저 요리사들의 식당 정보를 정리해 드리겠습니다.  아래 목록은 프로그램에 출연하는 셰프들의 식당들을 포함하고 있으며, 모든 셰프의 식당이 아닐 수도 있고, 프로그램 방영 이후 변동 사항이 있을 수 있다는 점 참고 부탁드립니다 (2024년 11월 1일 기준).


**백수저 셰프들의 식당**

* **최강록:** 식당 네오 (일식 기반 코스 요리)
* **정지선:** 티엔미미 (딤섬 전문)
* **최지형:** 리북방 (이북 코스 요리)
* **조셉 리저우드:** 에빗 (한식)
* **김도운:** 윤서울, 면서울 (한식)
* **여경래:** 홍보각 (중식)
* **최현석:** 쵸이닷, 중앙감속기 등 (양식)
* **박준우:** 오쁘띠베르 (디저트 카페)
* **오세득:** 친밀, 오팬파이어 (제주 모던 한식)
* **장호준:** 네기 (네기다이닝라운지)
* **남정석:** 로컬릿 (채소 요리)
* **파브리:** 파브리키친 (이탈리아 요리)
* **김승민:** 모리노 아루요 (덮밥)
* **방기수:** 깃든 (고기 요리)
* **선경 롱기스트:** (미국 음식)
* **안유성:** 가매일식 (일식)
* **이영숙:** 나경버섯 (한식, 식재료 판매)
* **조은주:** 터치더 스카이


**흑수저 셰프들의 식당**

* 프로그램에서는 흑수저 셰프들의 식당 정보가 백수저 셰프들보다 덜 공개되었습니다. 하지만 식신(siksinhot.com)과 같은 웹사이트를 통해 흑수저 셰프들의 식당 정보를 찾아볼 수 있습니다.


**기타 출연진 관련 식당**

* **이야이야앤프렌즈:** 박태윤 (크리에이티브 디렉터), 변성현 (셰프) - 그리스 지중해식 브런치 카페


**식당 정보 찾는 팁**

* 식신, 중앙일보, 네이버 블로그 등의 웹사이트나 앱에서 "흑백요리사 식당"을 검색하면 더 많은 정보를 얻을 수 있습니다.
* 프로그램 공식 웹사이트나 SNS 계정에서도 관련 정보가 업데이트 될 수 있습니다.



**참고:** 위 정보는 현재까지 공개된 정보를 바탕으로 정리된 것이며,  변동될 가능성이 있습니다.  정확한 정보는 각 식당에 직접 문의하는 것이 가장 좋습니다.




빈 딕셔너리를 전달할 수도 있음. 이 경우 `mode`와 `dynamic_threshold`에 대한 기본값이 사용될 것임
```

```
model = genai.GenerativeModel('models/gemini-1.5-pro-002')

user_input = input("메시지를 입력하세요: ")

response = model.generate_content(
    contents=user_input,
    tools={
        "google_search_retrieval": {
            "dynamic_retrieval_config": {}
        }
    }
)

print("\nGemini 답변: \n")
Markdown(response.candidates[0].content.parts[0].text)
```
```
    메시지를 입력하세요: 흑백요리사 식당
    
    Gemini 답변: 
    





넷플릭스 예능 프로그램 "흑백요리사: 요리 계급 전쟁"에 출연하는 백수저와 흑수저 셰프들의 식당 정보에 대해 문의하셨네요.  요청하신 정보를 정리해 드리겠습니다.

**프로그램 정보:**

* "흑백요리사: 요리 계급 전쟁"은 백수저(유명 셰프)와 흑수저(무명 셰프)로 나뉜 셰프들이 요리 대결을 펼치는 프로그램입니다.
* 심사위원은 백종원, 안성재 셰프입니다.
* 2024년 9월 17일 첫 방송을 시작했고, 매주 화요일에 새로운 에피소드가 공개됩니다. 총 12부작입니다. (2024년 10월 8일 종영 예정)


**셰프 및 식당 정보:**

각종 기사와 블로그를 통해 공개된 정보들을 바탕으로 현재까지 알려진 셰프와 식당 목록을 정리했습니다.  프로그램 진행 상황에 따라 추가 정보가 공개되면 내용이 달라질 수 있습니다. (2024년 11월 1일 기준)

**백수저 셰프:**

* 최강록 - 식당 네오 (일식 기반 코스 요리)
* 정지선 - 티엔미미 (딤섬)
* 최지형 - 리북방 (이북 코스 요리)
* 조셉 리저우드 - 에빗 (한식)
* 김도운 - 윤서울 (한식)
* 여경래 - 홍보각 (중식)
* 최현석 - 쵸이닷, 중앙감속기 등 (양식)
* 박준우 - 오쁘띠베르 (디저트 카페)
* 오세득 - 친밀, 오팬파이어 (모던 한식)
* 장호준 - 네기 (네기다이닝라운지 총괄 셰프)
* 남정석 - 로컬릿 (채소 요리)
* 파브리 - 파브리키친 (이탈리아 요리)
* 김승민 - 모리노 아루요 (덮밥)
* 방기수 - 깃든 (고기 요리)
* 선경 롱기스트 - 레스토랑 (미국 음식)
* 안유성 - 가매일식 (일식)
* 이영숙 - 나경버섯 (한식,  쇼핑몰 운영 - 제철 식재료, 김치, 장, 장아찌 등 판매)
* 조은주 - 터치더 스카이 (한식)
* 황진선 - 진진 (한식)

**흑수저 셰프:**

* 출연 셰프가 많아 모든 셰프의 정보가 공개되지는 않았습니다.
* 일부 셰프는 개인 식당을 운영하지 않고 있습니다.
* 프로그램 진행에 따라 추가 정보가 공개될 것으로 예상됩니다.

**기타:**

* 변성현, 박태윤 - 이야이야앤프렌즈 (브런치 카페, 그리스 지중해 음식) -  변성현 셰프는 브런치 메뉴 담당, 박태윤은 크리에이티브 디렉터로  전반적인 F&B 메뉴 개발 및 구성 담당.

위 정보 외에도 "흑백요리사" 관련 기사나 블로그를 참고하시면 더 많은 정보를 얻으실 수 있을 겁니다.  궁금한 점이 있다면 언제든지 다시 문의해 주세요.
```



## With chat

`google_search_retrieval` 도구를 모델에 연결하면 채팅의 모든 턴에서 사용할 수 있음


```
model = genai.GenerativeModel('models/gemini-1.5-pro-002', tools="google_search_retrieval")
chat = model.start_chat()
user_input = input("메시지를 입력하세요: ")
result = chat.send_message(user_input)
```
```
    메시지를 입력하세요: 흑백요리사 식당
```


```
display(Markdown(result.text))

display(HTML(result.candidates[0].grounding_metadata.search_entry_point.rendered_content))
```

```
넷플릭스 예능 프로그램 "흑백요리사: 요리 계급 전쟁"에 출연하는 백수저와 흑수저 요리사들의 식당 정보에 대해 정리해 드리겠습니다.  프로그램은 요리 실력은 뛰어나지만 인지도가 낮은 '흑수저' 셰프들이 유명 스타 셰프인 '백수저' 셰프들에게 도전하는 형식으로 진행됩니다. 심사위원은 백종원과 안성재 셰프입니다.


**백수저 셰프들의 식당**

* **최강록:** 식당 네오 (일식 기반 코스 요리)
* **정지선:** 티엔미미 (딤섬 전문)
* **최지형:** 리북방 (이북 코스 요리)
* **조셉 리저우드:** 에빗 (한식)
* **김도운:** 윤서울 (한식, *미슐랭 1스타*)
* **여경래:** 홍보각 (중식)
* **최현석:** 쵸이닷, 중앙감속기 등 (양식)
* **박준우:** 오쁘띠베르 (디저트 카페)
* **오세득:** 친밀, 오팬파이어 (제주 모던 한식)
* **장호준:** 네기 (네기다이닝라운지 총괄 셰프)
* **남정석:** 로컬릿 (채소 요리 전문)
* **파브리:** 파브리키친 (이탈리아 요리, *미슐랭 1스타*)
* **김승민:** 모리노 아루요 (덮밥)
* **방기수:** 깃든 (고기 요리)
* **선경 롱기스트:** (미국 음식)
* **안유성:** 가매일식 (일식, 대한민국 16대 조리 명장)
* **이영숙:** 나경버섯 (한식, 한식대첩 1 우승자)
* **조은주:** 터치더 스카이 (양식)


**흑수저 셰프들의 식당 정보**는 프로그램 진행 상황에 따라 공개되고 있으며, 아직 모든 셰프의 정보가 알려진 것은 아닙니다. 현재까지 공개된 정보와 더불어 추가 정보는 식신, 중앙일보, 헤이팝 등의 매체를 통해 확인할 수 있습니다. 또한, 흑수저 셰프 중 일부는 개인 식당을 운영하지 않는 경우도 있습니다.


**그 외 흑백요리사 관련 식당**

* **이야이야앤프렌즈:** 박태윤 (풀메 요리사, 크리에이티브 디렉터), 변성현 (스페인 모델, 셰프) - 그리스 지중해식 브런치 카페, 올리브 오일 판매


**참고:** 위 정보는 2024년 11월 1일 기준으로, 프로그램 방영과 함께 변동될 수 있습니다. 더 자세한 내용은 흑백요리사 공식 웹사이트 또는 관련 기사를 참조하시기 바랍니다.
```



<style>
.container {
  align-items: center;
  border-radius: 8px;
  display: flex;
  font-family: Google Sans, Roboto, sans-serif;
  font-size: 14px;
  line-height: 20px;
  padding: 8px 12px;
}
.chip {
  display: inline-block;
  border: solid 1px;
  border-radius: 16px;
  min-width: 14px;
  padding: 5px 16px;
  text-align: center;
  user-select: none;
  margin: 0 8px;
  -webkit-tap-highlight-color: transparent;
}
.carousel {
  overflow: auto;
  scrollbar-width: none;
  white-space: nowrap;
  margin-right: -12px;
}
.headline {
  display: flex;
  margin-right: 4px;
}
.gradient-container {
  position: relative;
}
.gradient {
  position: absolute;
  transform: translate(3px, -9px);
  height: 36px;
  width: 9px;
}
@media (prefers-color-scheme: light) {
  .container {
    background-color: #fafafa;
    box-shadow: 0 0 0 1px #0000000f;
  }
  .headline-label {
    color: #1f1f1f;
  }
  .chip {
    background-color: #ffffff;
    border-color: #d2d2d2;
    color: #5e5e5e;
    text-decoration: none;
  }
  .chip:hover {
    background-color: #f2f2f2;
  }
  .chip:focus {
    background-color: #f2f2f2;
  }
  .chip:active {
    background-color: #d8d8d8;
    border-color: #b6b6b6;
  }
  .logo-dark {
    display: none;
  }
  .gradient {
    background: linear-gradient(90deg, #fafafa 15%, #fafafa00 100%);
  }
}
@media (prefers-color-scheme: dark) {
  .container {
    background-color: #1f1f1f;
    box-shadow: 0 0 0 1px #ffffff26;
  }
  .headline-label {
    color: #fff;
  }
  .chip {
    background-color: #2c2c2c;
    border-color: #3c4043;
    color: #fff;
    text-decoration: none;
  }
  .chip:hover {
    background-color: #353536;
  }
  .chip:focus {
    background-color: #353536;
  }
  .chip:active {
    background-color: #464849;
    border-color: #53575b;
  }
  .logo-light {
    display: none;
  }
  .gradient {
    background: linear-gradient(90deg, #1f1f1f 15%, #1f1f1f00 100%);
  }
}
</style>
<div class="container">
  <div class="headline">
    <svg class="logo-light" width="18" height="18" viewBox="9 9 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M42.8622 27.0064C42.8622 25.7839 42.7525 24.6084 42.5487 23.4799H26.3109V30.1568H35.5897C35.1821 32.3041 33.9596 34.1222 32.1258 35.3448V39.6864H37.7213C40.9814 36.677 42.8622 32.2571 42.8622 27.0064V27.0064Z" fill="#4285F4"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M26.3109 43.8555C30.9659 43.8555 34.8687 42.3195 37.7213 39.6863L32.1258 35.3447C30.5898 36.3792 28.6306 37.0061 26.3109 37.0061C21.8282 37.0061 18.0195 33.9811 16.6559 29.906H10.9194V34.3573C13.7563 39.9841 19.5712 43.8555 26.3109 43.8555V43.8555Z" fill="#34A853"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M16.6559 29.8904C16.3111 28.8559 16.1074 27.7588 16.1074 26.6146C16.1074 25.4704 16.3111 24.3733 16.6559 23.3388V18.8875H10.9194C9.74388 21.2072 9.06992 23.8247 9.06992 26.6146C9.06992 29.4045 9.74388 32.022 10.9194 34.3417L15.3864 30.8621L16.6559 29.8904V29.8904Z" fill="#FBBC05"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M26.3109 16.2386C28.85 16.2386 31.107 17.1164 32.9095 18.8091L37.8466 13.8719C34.853 11.082 30.9659 9.3736 26.3109 9.3736C19.5712 9.3736 13.7563 13.245 10.9194 18.8875L16.6559 23.3388C18.0195 19.2636 21.8282 16.2386 26.3109 16.2386V16.2386Z" fill="#EA4335"/>
    </svg>
    <svg class="logo-dark" width="18" height="18" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
      <circle cx="24" cy="23" fill="#FFF" r="22"/>
      <path d="M33.76 34.26c2.75-2.56 4.49-6.37 4.49-11.26 0-.89-.08-1.84-.29-3H24.01v5.99h8.03c-.4 2.02-1.5 3.56-3.07 4.56v.75l3.91 2.97h.88z" fill="#4285F4"/>
      <path d="M15.58 25.77A8.845 8.845 0 0 0 24 31.86c1.92 0 3.62-.46 4.97-1.31l4.79 3.71C31.14 36.7 27.65 38 24 38c-5.93 0-11.01-3.4-13.45-8.36l.17-1.01 4.06-2.85h.8z" fill="#34A853"/>
      <path d="M15.59 20.21a8.864 8.864 0 0 0 0 5.58l-5.03 3.86c-.98-2-1.53-4.25-1.53-6.64 0-2.39.55-4.64 1.53-6.64l1-.22 3.81 2.98.22 1.08z" fill="#FBBC05"/>
      <path d="M24 14.14c2.11 0 4.02.75 5.52 1.98l4.36-4.36C31.22 9.43 27.81 8 24 8c-5.93 0-11.01 3.4-13.45 8.36l5.03 3.85A8.86 8.86 0 0 1 24 14.14z" fill="#EA4335"/>
    </svg>
    <div class="gradient-container"><div class="gradient"></div></div>
  </div>
  <div class="carousel">
    <a class="chip" href="https://vertexaisearch.cloud.google.com/grounding-api-redirect/AZnLMfyBy62YtDvZlL-gPbRo19VcMxPp-M6APqQUSY03WgUU0bhSNfd7H7tcCa4mlte5pa-1ZE4eXM0Fpys99ewgihGfN2vBTkW_pTp3ApQG1erflyMHFDw7NR-fpSBVHzdMv0rvCpirO0vO2h_d8mCWgeYseo9MQzMCxcaYeBfrm-rIYiwWb6FhhPmVpfxo5cua69XiXEmMV8D3EPWN3tbWLlT_isP5nHEb9gqPqvlKyRc4yNuamdO5FlyLahxlMmpmEIiSNN8=">흑백요리사 식당</a>
  </div>
</div>




```
user_input = input("메시지를 입력하세요: ")
result = chat.send_message(user_input)

display(Markdown(result.text))

display(HTML(result.candidates[0].grounding_metadata.search_entry_point.rendered_content))
```
```
    메시지를 입력하세요: 준랩 유튜브 채널에 대해서 소개해줘



준랩(JoonLab) 유튜브 채널은 **인공지능(AI), 특히 LLM(Large Language Model)에 관심이 많은 학생** Joon Park이 운영하는 채널입니다. 주로 AI 관련 정보, 튜토리얼, 활용법 등을 다루고 있으며, 특히 ChatGPT, Claude, GPTs 등 생성형 AI 모델에 대한 콘텐츠가 많습니다. 2024년 11월 1일 기준 구독자 수는 약 1,690명이며, 약 108개의 영상이 업로드되어 있습니다.


**주요 콘텐츠**

* **AI 활용법:** ChatGPT, Claude, GPTs 등 생성형 AI 모델을 활용한 다양한 작업 방법을 소개합니다. 예를 들어, 논문 읽기, 연구, 구글 스프레드시트 및 캘린더 관리, 카드 뉴스 제작, 녹음기 활용 등 실질적인 업무 효율 향상에 도움이 되는 내용을 다룹니다.
* **AI 튜토리얼:** Claude API 사용법, GPTs 생성 및 활용법 등 AI 도구 사용에 필요한 기술적인 내용을 자세하게 설명합니다. 초보자도 쉽게 따라 할 수 있도록 단계별로 안내하는 것이 특징입니다.
* **AI 뉴스:**  AI 분야의 최신 동향 및 주요 뉴스를 전달합니다. 새로운 AI 모델 출시, 업데이트 정보, 활용 사례 등을 빠르게 접할 수 있습니다.
* **기타:** 수학 관련 콘텐츠, 흥미로운 AI 활용 사례 등 다양한 주제를 다룹니다.


**특징**

* **실용적인 정보 제공:** 이론적인 내용보다는 실제로 AI를 활용하는 방법에 초점을 맞추고 있습니다.  바로 적용 가능한 팁과 노하우를 제공하여 시청자들이 AI를 통해 실질적인 도움을 얻을 수 있도록 돕습니다.
* **쉬운 설명:** 복잡한 AI 기술을 이해하기 쉽게 설명합니다. 전문 용어를 최소화하고, 비유와 예시를 적절히 사용하여 초보자도 쉽게 따라올 수 있도록 배려합니다.
* **빠른 정보 업데이트:** AI 분야는 빠르게 발전하고 있기 때문에 최신 정보를 제공하는 것이 중요합니다. 준랩 채널은 새로운 기술과 트렌드를 빠르게 반영하여 시청자들에게 유용한 정보를 제공합니다.
* **다양한 콘텐츠 형식:** 일반 영상뿐만 아니라 쇼츠(Shorts) 형식의 짧은 영상도 제작하여 다양한 시청자층을 확보하고 있습니다.


준랩 유튜브 채널은 AI, 특히 생성형 AI에 관심 있는 사람들에게 유용한 정보와 팁을 제공하는 채널입니다. AI 활용법을 배우고 싶거나 AI 분야의 최신 동향을 파악하고 싶은 분들에게 추천합니다.  채널 운영자 Joon Park은 bio.link/joonparkand 등 다른 링크를 통해 추가적인 정보를 제공하고 있는 것으로 보입니다.
```



<style>
.container {
  align-items: center;
  border-radius: 8px;
  display: flex;
  font-family: Google Sans, Roboto, sans-serif;
  font-size: 14px;
  line-height: 20px;
  padding: 8px 12px;
}
.chip {
  display: inline-block;
  border: solid 1px;
  border-radius: 16px;
  min-width: 14px;
  padding: 5px 16px;
  text-align: center;
  user-select: none;
  margin: 0 8px;
  -webkit-tap-highlight-color: transparent;
}
.carousel {
  overflow: auto;
  scrollbar-width: none;
  white-space: nowrap;
  margin-right: -12px;
}
.headline {
  display: flex;
  margin-right: 4px;
}
.gradient-container {
  position: relative;
}
.gradient {
  position: absolute;
  transform: translate(3px, -9px);
  height: 36px;
  width: 9px;
}
@media (prefers-color-scheme: light) {
  .container {
    background-color: #fafafa;
    box-shadow: 0 0 0 1px #0000000f;
  }
  .headline-label {
    color: #1f1f1f;
  }
  .chip {
    background-color: #ffffff;
    border-color: #d2d2d2;
    color: #5e5e5e;
    text-decoration: none;
  }
  .chip:hover {
    background-color: #f2f2f2;
  }
  .chip:focus {
    background-color: #f2f2f2;
  }
  .chip:active {
    background-color: #d8d8d8;
    border-color: #b6b6b6;
  }
  .logo-dark {
    display: none;
  }
  .gradient {
    background: linear-gradient(90deg, #fafafa 15%, #fafafa00 100%);
  }
}
@media (prefers-color-scheme: dark) {
  .container {
    background-color: #1f1f1f;
    box-shadow: 0 0 0 1px #ffffff26;
  }
  .headline-label {
    color: #fff;
  }
  .chip {
    background-color: #2c2c2c;
    border-color: #3c4043;
    color: #fff;
    text-decoration: none;
  }
  .chip:hover {
    background-color: #353536;
  }
  .chip:focus {
    background-color: #353536;
  }
  .chip:active {
    background-color: #464849;
    border-color: #53575b;
  }
  .logo-light {
    display: none;
  }
  .gradient {
    background: linear-gradient(90deg, #1f1f1f 15%, #1f1f1f00 100%);
  }
}
</style>
<div class="container">
  <div class="headline">
    <svg class="logo-light" width="18" height="18" viewBox="9 9 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M42.8622 27.0064C42.8622 25.7839 42.7525 24.6084 42.5487 23.4799H26.3109V30.1568H35.5897C35.1821 32.3041 33.9596 34.1222 32.1258 35.3448V39.6864H37.7213C40.9814 36.677 42.8622 32.2571 42.8622 27.0064V27.0064Z" fill="#4285F4"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M26.3109 43.8555C30.9659 43.8555 34.8687 42.3195 37.7213 39.6863L32.1258 35.3447C30.5898 36.3792 28.6306 37.0061 26.3109 37.0061C21.8282 37.0061 18.0195 33.9811 16.6559 29.906H10.9194V34.3573C13.7563 39.9841 19.5712 43.8555 26.3109 43.8555V43.8555Z" fill="#34A853"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M16.6559 29.8904C16.3111 28.8559 16.1074 27.7588 16.1074 26.6146C16.1074 25.4704 16.3111 24.3733 16.6559 23.3388V18.8875H10.9194C9.74388 21.2072 9.06992 23.8247 9.06992 26.6146C9.06992 29.4045 9.74388 32.022 10.9194 34.3417L15.3864 30.8621L16.6559 29.8904V29.8904Z" fill="#FBBC05"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M26.3109 16.2386C28.85 16.2386 31.107 17.1164 32.9095 18.8091L37.8466 13.8719C34.853 11.082 30.9659 9.3736 26.3109 9.3736C19.5712 9.3736 13.7563 13.245 10.9194 18.8875L16.6559 23.3388C18.0195 19.2636 21.8282 16.2386 26.3109 16.2386V16.2386Z" fill="#EA4335"/>
    </svg>
    <svg class="logo-dark" width="18" height="18" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
      <circle cx="24" cy="23" fill="#FFF" r="22"/>
      <path d="M33.76 34.26c2.75-2.56 4.49-6.37 4.49-11.26 0-.89-.08-1.84-.29-3H24.01v5.99h8.03c-.4 2.02-1.5 3.56-3.07 4.56v.75l3.91 2.97h.88z" fill="#4285F4"/>
      <path d="M15.58 25.77A8.845 8.845 0 0 0 24 31.86c1.92 0 3.62-.46 4.97-1.31l4.79 3.71C31.14 36.7 27.65 38 24 38c-5.93 0-11.01-3.4-13.45-8.36l.17-1.01 4.06-2.85h.8z" fill="#34A853"/>
      <path d="M15.59 20.21a8.864 8.864 0 0 0 0 5.58l-5.03 3.86c-.98-2-1.53-4.25-1.53-6.64 0-2.39.55-4.64 1.53-6.64l1-.22 3.81 2.98.22 1.08z" fill="#FBBC05"/>
      <path d="M24 14.14c2.11 0 4.02.75 5.52 1.98l4.36-4.36C31.22 9.43 27.81 8 24 8c-5.93 0-11.01 3.4-13.45 8.36l5.03 3.85A8.86 8.86 0 0 1 24 14.14z" fill="#EA4335"/>
    </svg>
    <div class="gradient-container"><div class="gradient"></div></div>
  </div>
  <div class="carousel">
    <a class="chip" href="https://vertexaisearch.cloud.google.com/grounding-api-redirect/AZnLMfy_W4n0EUAHUk_3jyt2YDYkUDzI_mbfvB8M5HG61c66sbPryuoobvdhroZ_yFT-Ngu0-edvDfNmYSsk7AzHPoip1LvjwsI946jtmugqxrpkPLxmFtISuaiRUAl3Dm6lrmxzJF6Sp6iKom0X--ePhoKC89_17qW6NjDy0mymDFZPx6owyf2maxz83Q1FgKSRPwE4EVRnfEESr2lyGqaxYE9LzEm9mzV1BIc-oe4K0ufKV3WtwzhDeb-g-8ZfKeq_myrnpVD2xMFxalG1BXcTscosda4FR56UFSNXkAR-8Eep_ID0F15vIyjD-LY1YFW1w8AkbBgIU_3J27w4sL_r2RPjQVKX9aneBYLEGGC2FWY=">준랩 유튜브 채널에 대해서 소개해줘</a>
  </div>
</div>



`send_message` 호출을 통해 도구를 전달할 수도 있음.


```
model = genai.GenerativeModel('models/gemini-1.5-pro-002')
chat = model.start_chat()

user_input = input("메시지를 입력하세요: ")

result = chat.send_message(user_input, tools="google_search_retrieval")

display(Markdown(result.text))

display(HTML(result.candidates[0].grounding_metadata.search_entry_point.rendered_content))
```
```
    메시지를 입력하세요: 준랩 유튜브 채널에 대해서 소개해줘



준랩(JoonLab) 유튜브 채널은 AI, 특히 LLM(Large Language Model)에 관심이 많은 학생이 운영하는 채널입니다. 2024년 11월 1일 기준, 약 1,690명의 구독자와 108개의 동영상을 보유하고 있습니다. 

이 채널에서는 ChatGPT, Claude, Gemini 등 LLM을 활용한 다양한 정보와 팁을 제공합니다. 주요 콘텐츠는 다음과 같습니다:

* **LLM 활용 튜토리얼:** Claude API 사용법, GPTs 활용법, Google Spreadsheet 및 Calendar와 GPT 연동 등 LLM을 실제로 활용하는 방법을 자세하게 안내합니다.
* **AI 관련 최신 뉴스 및 업데이트:**  Claude의 최신 업데이트, 새로운 AI 도구 소개, AI 관련 컨퍼런스(Google I/O, WWDC) 내용 요약 등 AI 분야의 최신 동향을 전달합니다.
* **연구 및 생산성 향상:** AI를 활용한 효율적인 논문 읽기, 연구 가이드, 생산성 향상 도구(Logitech 마우스, Stream Deck) 소개 등 연구자를 위한 팁을 제공합니다.
* **프로그래밍 관련:** ChatGPT, Claude, Gemini API를 활용한 웹앱 제작 방법 등 개발 관련 정보도 다룹니다.

또한, 'AI 뉴스', 'AI 활용', '수학 etc' 등의 재생목록을 통해 콘텐츠를 주제별로 분류하여 제공하고 있습니다. 짧은 영상(Shorts)을 통해 다양한 AI 활용 팁을 간략하게 소개하기도 합니다.


전반적으로 준랩 채널은 AI, 특히 LLM에 관심 있는 사람들에게 유용한 정보와 실용적인 활용법을 제공하는 채널입니다. 최신 AI 트렌드를 따라가고 싶거나, LLM을 활용하여 연구 및 업무 생산성을 높이고 싶은 분들에게 추천합니다.
```



<style>
.container {
  align-items: center;
  border-radius: 8px;
  display: flex;
  font-family: Google Sans, Roboto, sans-serif;
  font-size: 14px;
  line-height: 20px;
  padding: 8px 12px;
}
.chip {
  display: inline-block;
  border: solid 1px;
  border-radius: 16px;
  min-width: 14px;
  padding: 5px 16px;
  text-align: center;
  user-select: none;
  margin: 0 8px;
  -webkit-tap-highlight-color: transparent;
}
.carousel {
  overflow: auto;
  scrollbar-width: none;
  white-space: nowrap;
  margin-right: -12px;
}
.headline {
  display: flex;
  margin-right: 4px;
}
.gradient-container {
  position: relative;
}
.gradient {
  position: absolute;
  transform: translate(3px, -9px);
  height: 36px;
  width: 9px;
}
@media (prefers-color-scheme: light) {
  .container {
    background-color: #fafafa;
    box-shadow: 0 0 0 1px #0000000f;
  }
  .headline-label {
    color: #1f1f1f;
  }
  .chip {
    background-color: #ffffff;
    border-color: #d2d2d2;
    color: #5e5e5e;
    text-decoration: none;
  }
  .chip:hover {
    background-color: #f2f2f2;
  }
  .chip:focus {
    background-color: #f2f2f2;
  }
  .chip:active {
    background-color: #d8d8d8;
    border-color: #b6b6b6;
  }
  .logo-dark {
    display: none;
  }
  .gradient {
    background: linear-gradient(90deg, #fafafa 15%, #fafafa00 100%);
  }
}
@media (prefers-color-scheme: dark) {
  .container {
    background-color: #1f1f1f;
    box-shadow: 0 0 0 1px #ffffff26;
  }
  .headline-label {
    color: #fff;
  }
  .chip {
    background-color: #2c2c2c;
    border-color: #3c4043;
    color: #fff;
    text-decoration: none;
  }
  .chip:hover {
    background-color: #353536;
  }
  .chip:focus {
    background-color: #353536;
  }
  .chip:active {
    background-color: #464849;
    border-color: #53575b;
  }
  .logo-light {
    display: none;
  }
  .gradient {
    background: linear-gradient(90deg, #1f1f1f 15%, #1f1f1f00 100%);
  }
}
</style>
<div class="container">
  <div class="headline">
    <svg class="logo-light" width="18" height="18" viewBox="9 9 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M42.8622 27.0064C42.8622 25.7839 42.7525 24.6084 42.5487 23.4799H26.3109V30.1568H35.5897C35.1821 32.3041 33.9596 34.1222 32.1258 35.3448V39.6864H37.7213C40.9814 36.677 42.8622 32.2571 42.8622 27.0064V27.0064Z" fill="#4285F4"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M26.3109 43.8555C30.9659 43.8555 34.8687 42.3195 37.7213 39.6863L32.1258 35.3447C30.5898 36.3792 28.6306 37.0061 26.3109 37.0061C21.8282 37.0061 18.0195 33.9811 16.6559 29.906H10.9194V34.3573C13.7563 39.9841 19.5712 43.8555 26.3109 43.8555V43.8555Z" fill="#34A853"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M16.6559 29.8904C16.3111 28.8559 16.1074 27.7588 16.1074 26.6146C16.1074 25.4704 16.3111 24.3733 16.6559 23.3388V18.8875H10.9194C9.74388 21.2072 9.06992 23.8247 9.06992 26.6146C9.06992 29.4045 9.74388 32.022 10.9194 34.3417L15.3864 30.8621L16.6559 29.8904V29.8904Z" fill="#FBBC05"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M26.3109 16.2386C28.85 16.2386 31.107 17.1164 32.9095 18.8091L37.8466 13.8719C34.853 11.082 30.9659 9.3736 26.3109 9.3736C19.5712 9.3736 13.7563 13.245 10.9194 18.8875L16.6559 23.3388C18.0195 19.2636 21.8282 16.2386 26.3109 16.2386V16.2386Z" fill="#EA4335"/>
    </svg>
    <svg class="logo-dark" width="18" height="18" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
      <circle cx="24" cy="23" fill="#FFF" r="22"/>
      <path d="M33.76 34.26c2.75-2.56 4.49-6.37 4.49-11.26 0-.89-.08-1.84-.29-3H24.01v5.99h8.03c-.4 2.02-1.5 3.56-3.07 4.56v.75l3.91 2.97h.88z" fill="#4285F4"/>
      <path d="M15.58 25.77A8.845 8.845 0 0 0 24 31.86c1.92 0 3.62-.46 4.97-1.31l4.79 3.71C31.14 36.7 27.65 38 24 38c-5.93 0-11.01-3.4-13.45-8.36l.17-1.01 4.06-2.85h.8z" fill="#34A853"/>
      <path d="M15.59 20.21a8.864 8.864 0 0 0 0 5.58l-5.03 3.86c-.98-2-1.53-4.25-1.53-6.64 0-2.39.55-4.64 1.53-6.64l1-.22 3.81 2.98.22 1.08z" fill="#FBBC05"/>
      <path d="M24 14.14c2.11 0 4.02.75 5.52 1.98l4.36-4.36C31.22 9.43 27.81 8 24 8c-5.93 0-11.01 3.4-13.45 8.36l5.03 3.85A8.86 8.86 0 0 1 24 14.14z" fill="#EA4335"/>
    </svg>
    <div class="gradient-container"><div class="gradient"></div></div>
  </div>
  <div class="carousel">
    <a class="chip" href="https://vertexaisearch.cloud.google.com/grounding-api-redirect/AZnLMfzELkJJYYVRC4kYblyl3aJrl6oIs8atbJ_oUVQssHS7mdCp8MqVpdnjoVYKPh1uIz0DnKHHmLZZF5UK9ntCpdUOBld2PH7aKaH-8Tl4EE2UtRFY-zHnnBA08JFX454QcfEx9qReBW7e7E9JPExXeeozd6_LNhbQSoh4tEZMiAwjvbI89BVsp98QLSPYdOIrW3-FZnXbHkM-Fas4KnY7zx924T63tWJW4vhoRR2g6vOXAyyg3jf9RgM94QN0pQkjleEM8nJSai3YSkC04gRzQe7i2O-NP9XnWTo=">준랩 유튜브 채널 소개</a>
  </div>
</div>


