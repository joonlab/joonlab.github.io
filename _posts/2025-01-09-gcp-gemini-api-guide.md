---
layout: single
title: "GCP 무료체험 등록 및 Gemini API 키 발급 가이드"
excerpt: "Google Cloud Platform 무료 크레딧 $300을 활용하여 Gemini API 키를 발급받는 방법을 단계별로 안내합니다."
categories: coding
tags: [gcp, google-cloud, gemini, api, tutorial]
toc: true
toc_sticky: true
---

## 가이드 영상

{% include video id="5Mh1XlUJawQ" provider="youtube" %}

## 개요

이 가이드에서는 Google의 Gemini AI를 활용하기 위한 사전 준비 과정을 안내합니다.
**Google Cloud Platform(GCP) 등록**과 **API 키 발급**을 단계별로 진행해보겠습니다.

> **안심하세요!**
> - 신규 가입 시 제공되는 **$300 무료 크레딧**을 사용하므로, 개인 비용이 청구되지 않습니다.
> - 본인 확인을 위한 신용카드 등록 과정이 있지만, 유료 계정으로 직접 업그레이드하기 전까지는 자동 결제되지 않습니다.

---

## 1단계: Google Cloud Platform (GCP) 무료 가입

### 1. 구글 클라우드 접속

구글에 `gcp`를 검색하거나 [https://cloud.google.com/free](https://cloud.google.com/free){:target="_blank"} 에 접속하여 메인 화면의 파란색 버튼을 클릭합니다.

![구글 검색 결과 화면](/assets/images/gcp-gemini-guide/gcp-01-search.jpg)

![구글 클라우드 메인 화면](/assets/images/gcp-gemini-guide/gcp-02-main.jpg)

### 2. 국가 선택 및 약관 동의 (1/2단계)

로그인 후 나오는 첫 번째 화면입니다.

- **국가:** '대한민국' 확인 (또는 선택)
- **약관:** 서비스 약관 동의 체크 후 [계속] 클릭

![가입 1단계 화면](/assets/images/gcp-gemini-guide/gcp-03-step1.jpg)

### 3. 본인 인증 및 결제 정보 등록 (2/2단계)

계정 유형과 주소, 카드를 등록합니다.

- **계정 유형:** 개인
- **주소:** 본인 주소 입력
- **결제 수단:** 해외 결제 가능한 카드 정보 입력

![가입 2단계 화면](/assets/images/gcp-gemini-guide/gcp-04-step2-type.jpg)

![정보 입력 완료 화면](/assets/images/gcp-gemini-guide/gcp-05-step2-submit.jpg)

### 4. 가입 완료 및 콘솔 진입

설문 팝업이 뜨면 답변하거나 건너뛰세요. `My First Project`라는 문구와 함께 환영 메시지가 보이면 성공입니다.

![GCP 콘솔 환영 화면](/assets/images/gcp-gemini-guide/gcp-06-welcome.jpg)

---

## 2단계: Gemini API 키 발급 (Google AI Studio)

방금 만든 GCP 프로젝트(무료 크레딧)를 연동하여 AI 모델을 사용할 수 있는 키를 발급받습니다.

### 1. Google AI Studio 접속

주소창에 [https://aistudio.google.com/](https://aistudio.google.com/){:target="_blank"} 을 입력하여 이동합니다.

![AI Studio 접속 화면](/assets/images/gcp-gemini-guide/gcp-07-aistudio.jpg)

### 2. API 키 메뉴 선택

화면 좌측 메뉴 중 열쇠 모양 아이콘, 혹은 **[Get API key]** 버튼을 클릭합니다.

![Get API key 메뉴 화면](/assets/images/gcp-gemini-guide/gcp-08-getapikey.jpg)

### 3. API 키 생성 및 프로젝트 연결 (중요)

**[API 키 만들기]** 버튼을 누른 뒤, 반드시 **기존 프로젝트 연결**을 선택해야 합니다.

- 옵션 선택: **[프로젝트 가져오기]**
- 프로젝트 선택: `My First Project` (1단계에서 만든 프로젝트)

> **주의:** '새 프로젝트에 API 키 만들기'를 누르면 무료 크레딧이 연동되지 않을 수 있습니다.
{: .notice--warning}

![프로젝트 선택 화면](/assets/images/gcp-gemini-guide/gcp-09-select-project.jpg)

![API 키 만들기 화면](/assets/images/gcp-gemini-guide/gcp-10-create-key.jpg)

### 4. 키 복사 및 보관

잠시 로딩 후 생성된 API 키가 목록에 나타납니다.

- 생성된 키 옆의 **[Copy]** 버튼을 눌러 메모장 등에 복사해 둡니다.
- **API 키는 안전한 곳에 저장**해주세요.

![API 키 목록 화면](/assets/images/gcp-gemini-guide/gcp-11-keylist.jpg)

---

## 마무리

여기까지 완료하셨다면 모든 준비가 끝났습니다!

**$300 무료 크레딧**으로 Gemini API를 마음껏 테스트해보세요. 90일 동안 사용할 수 있으며, 유료 계정으로 업그레이드하기 전까지는 비용이 청구되지 않습니다.

### 다음 단계

- [Gemini API 공식 문서](https://ai.google.dev/docs){:target="_blank"}
- [Google AI Studio](https://aistudio.google.com/){:target="_blank"}에서 프롬프트 테스트
- Python/JavaScript SDK로 앱 개발 시작
