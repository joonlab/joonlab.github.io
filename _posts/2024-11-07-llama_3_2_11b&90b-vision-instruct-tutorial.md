# [Made by PARK JOON](https://bio.link/joonpark)

---
# 참고 링크

- [llama-3.2-11b-vision-instruct](https://build.nvidia.com/meta/llama-3.2-11b-vision-instruct)
- [llama-3.2-90b-vision-instruct](https://build.nvidia.com/meta/llama-3.2-90b-vision-instruct)

---
# NVIDIA API KEY 발급 방법

위의 참고 링크 중 하나에 접속한 뒤, 다음 이미지 순서대로 참고하여 API KEY 발급받기

![이미지1](https://i.ibb.co/D1YmmP9/Clean-Shot-2024-11-07-at-19-41-35-2x.png)

![이미지2](https://i.ibb.co/C0gMhR8/2.png)

![이미지3](https://i.ibb.co/TKVQy1B/3.png)

![이미지4](https://i.ibb.co/8stJ40v/4.png)


```python

```

---
# API KEY 설정


```python
from google.colab import userdata

NVIDIA_API_KEY = userdata.get('NVIDIA_API_KEY')
```

#### 참고 이미지

[코랩 환경 변수 설정 참고 이미지](https://i.imghippo.com/files/nkS8F1729430186.png)

⚠️ 참고 이미지에서는 OpenAI API KEY를 예시로 들어 설명하고 있습니다.

2️⃣의 "OPENAI_API_KEY" 를 "NVIDIA_API_KEY" 로 변경해주세요.

---
# 튜토리얼 (OCR)

## 11B & 파일 업로드


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

    사용할 모델을 선택해주세요:
    1: 11B 모델 (더 빠름)
    2: 90B 모델 (더 정확함)
    선택 (1 또는 2): 1
    
    이미지 텍스트 추출 방식을 선택해주세요:
    1: 파일 업로드
    2: 이미지 URL 입력
    선택 (1 또는 2): 1
    파일을 업로드해주세요...




     <input type="file" id="files-c09b0730-9949-487f-9f2d-c7f17b6be8ef" name="files[]" multiple disabled
        style="border:none" />
     <output id="result-c09b0730-9949-487f-9f2d-c7f17b6be8ef">
      Upload widget is only available when the cell has been executed in the
      current browser session. Please rerun this cell to enable.
      </output>
      <script>// Copyright 2017 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * @fileoverview Helpers for google.colab Python module.
 */
(function(scope) {
function span(text, styleAttributes = {}) {
  const element = document.createElement('span');
  element.textContent = text;
  for (const key of Object.keys(styleAttributes)) {
    element.style[key] = styleAttributes[key];
  }
  return element;
}

// Max number of bytes which will be uploaded at a time.
const MAX_PAYLOAD_SIZE = 100 * 1024;

function _uploadFiles(inputId, outputId) {
  const steps = uploadFilesStep(inputId, outputId);
  const outputElement = document.getElementById(outputId);
  // Cache steps on the outputElement to make it available for the next call
  // to uploadFilesContinue from Python.
  outputElement.steps = steps;

  return _uploadFilesContinue(outputId);
}

// This is roughly an async generator (not supported in the browser yet),
// where there are multiple asynchronous steps and the Python side is going
// to poll for completion of each step.
// This uses a Promise to block the python side on completion of each step,
// then passes the result of the previous step as the input to the next step.
function _uploadFilesContinue(outputId) {
  const outputElement = document.getElementById(outputId);
  const steps = outputElement.steps;

  const next = steps.next(outputElement.lastPromiseValue);
  return Promise.resolve(next.value.promise).then((value) => {
    // Cache the last promise value to make it available to the next
    // step of the generator.
    outputElement.lastPromiseValue = value;
    return next.value.response;
  });
}

/**
 * Generator function which is called between each async step of the upload
 * process.
 * @param {string} inputId Element ID of the input file picker element.
 * @param {string} outputId Element ID of the output display.
 * @return {!Iterable<!Object>} Iterable of next steps.
 */
function* uploadFilesStep(inputId, outputId) {
  const inputElement = document.getElementById(inputId);
  inputElement.disabled = false;

  const outputElement = document.getElementById(outputId);
  outputElement.innerHTML = '';

  const pickedPromise = new Promise((resolve) => {
    inputElement.addEventListener('change', (e) => {
      resolve(e.target.files);
    });
  });

  const cancel = document.createElement('button');
  inputElement.parentElement.appendChild(cancel);
  cancel.textContent = 'Cancel upload';
  const cancelPromise = new Promise((resolve) => {
    cancel.onclick = () => {
      resolve(null);
    };
  });

  // Wait for the user to pick the files.
  const files = yield {
    promise: Promise.race([pickedPromise, cancelPromise]),
    response: {
      action: 'starting',
    }
  };

  cancel.remove();

  // Disable the input element since further picks are not allowed.
  inputElement.disabled = true;

  if (!files) {
    return {
      response: {
        action: 'complete',
      }
    };
  }

  for (const file of files) {
    const li = document.createElement('li');
    li.append(span(file.name, {fontWeight: 'bold'}));
    li.append(span(
        `(${file.type || 'n/a'}) - ${file.size} bytes, ` +
        `last modified: ${
            file.lastModifiedDate ? file.lastModifiedDate.toLocaleDateString() :
                                    'n/a'} - `));
    const percent = span('0% done');
    li.appendChild(percent);

    outputElement.appendChild(li);

    const fileDataPromise = new Promise((resolve) => {
      const reader = new FileReader();
      reader.onload = (e) => {
        resolve(e.target.result);
      };
      reader.readAsArrayBuffer(file);
    });
    // Wait for the data to be ready.
    let fileData = yield {
      promise: fileDataPromise,
      response: {
        action: 'continue',
      }
    };

    // Use a chunked sending to avoid message size limits. See b/62115660.
    let position = 0;
    do {
      const length = Math.min(fileData.byteLength - position, MAX_PAYLOAD_SIZE);
      const chunk = new Uint8Array(fileData, position, length);
      position += length;

      const base64 = btoa(String.fromCharCode.apply(null, chunk));
      yield {
        response: {
          action: 'append',
          file: file.name,
          data: base64,
        },
      };

      let percentDone = fileData.byteLength === 0 ?
          100 :
          Math.round((position / fileData.byteLength) * 100);
      percent.textContent = `${percentDone}% done`;

    } while (position < fileData.byteLength);
  }

  // All done.
  yield {
    response: {
      action: 'complete',
    }
  };
}

scope.google = scope.google || {};
scope.google.colab = scope.google.colab || {};
scope.google.colab._files = {
  _uploadFiles,
  _uploadFilesContinue,
};
})(self);
</script> 


    Saving kakao.png to kakao (5).png
    
    추출된 텍스트:
    Your browser does not support the audio element.


## 11B & 이미지 URL


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


## 90B & 파일 업로드


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

    사용할 모델을 선택해주세요:
    1: 11B 모델 (더 빠름)
    2: 90B 모델 (더 정확함)
    선택 (1 또는 2): 2
    
    이미지 텍스트 추출 방식을 선택해주세요:
    1: 파일 업로드
    2: 이미지 URL 입력
    선택 (1 또는 2): 1
    파일을 업로드해주세요...




     <input type="file" id="files-ef6eaf9f-be96-4f85-a1c7-7d9b6525818d" name="files[]" multiple disabled
        style="border:none" />
     <output id="result-ef6eaf9f-be96-4f85-a1c7-7d9b6525818d">
      Upload widget is only available when the cell has been executed in the
      current browser session. Please rerun this cell to enable.
      </output>
      <script>// Copyright 2017 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * @fileoverview Helpers for google.colab Python module.
 */
(function(scope) {
function span(text, styleAttributes = {}) {
  const element = document.createElement('span');
  element.textContent = text;
  for (const key of Object.keys(styleAttributes)) {
    element.style[key] = styleAttributes[key];
  }
  return element;
}

// Max number of bytes which will be uploaded at a time.
const MAX_PAYLOAD_SIZE = 100 * 1024;

function _uploadFiles(inputId, outputId) {
  const steps = uploadFilesStep(inputId, outputId);
  const outputElement = document.getElementById(outputId);
  // Cache steps on the outputElement to make it available for the next call
  // to uploadFilesContinue from Python.
  outputElement.steps = steps;

  return _uploadFilesContinue(outputId);
}

// This is roughly an async generator (not supported in the browser yet),
// where there are multiple asynchronous steps and the Python side is going
// to poll for completion of each step.
// This uses a Promise to block the python side on completion of each step,
// then passes the result of the previous step as the input to the next step.
function _uploadFilesContinue(outputId) {
  const outputElement = document.getElementById(outputId);
  const steps = outputElement.steps;

  const next = steps.next(outputElement.lastPromiseValue);
  return Promise.resolve(next.value.promise).then((value) => {
    // Cache the last promise value to make it available to the next
    // step of the generator.
    outputElement.lastPromiseValue = value;
    return next.value.response;
  });
}

/**
 * Generator function which is called between each async step of the upload
 * process.
 * @param {string} inputId Element ID of the input file picker element.
 * @param {string} outputId Element ID of the output display.
 * @return {!Iterable<!Object>} Iterable of next steps.
 */
function* uploadFilesStep(inputId, outputId) {
  const inputElement = document.getElementById(inputId);
  inputElement.disabled = false;

  const outputElement = document.getElementById(outputId);
  outputElement.innerHTML = '';

  const pickedPromise = new Promise((resolve) => {
    inputElement.addEventListener('change', (e) => {
      resolve(e.target.files);
    });
  });

  const cancel = document.createElement('button');
  inputElement.parentElement.appendChild(cancel);
  cancel.textContent = 'Cancel upload';
  const cancelPromise = new Promise((resolve) => {
    cancel.onclick = () => {
      resolve(null);
    };
  });

  // Wait for the user to pick the files.
  const files = yield {
    promise: Promise.race([pickedPromise, cancelPromise]),
    response: {
      action: 'starting',
    }
  };

  cancel.remove();

  // Disable the input element since further picks are not allowed.
  inputElement.disabled = true;

  if (!files) {
    return {
      response: {
        action: 'complete',
      }
    };
  }

  for (const file of files) {
    const li = document.createElement('li');
    li.append(span(file.name, {fontWeight: 'bold'}));
    li.append(span(
        `(${file.type || 'n/a'}) - ${file.size} bytes, ` +
        `last modified: ${
            file.lastModifiedDate ? file.lastModifiedDate.toLocaleDateString() :
                                    'n/a'} - `));
    const percent = span('0% done');
    li.appendChild(percent);

    outputElement.appendChild(li);

    const fileDataPromise = new Promise((resolve) => {
      const reader = new FileReader();
      reader.onload = (e) => {
        resolve(e.target.result);
      };
      reader.readAsArrayBuffer(file);
    });
    // Wait for the data to be ready.
    let fileData = yield {
      promise: fileDataPromise,
      response: {
        action: 'continue',
      }
    };

    // Use a chunked sending to avoid message size limits. See b/62115660.
    let position = 0;
    do {
      const length = Math.min(fileData.byteLength - position, MAX_PAYLOAD_SIZE);
      const chunk = new Uint8Array(fileData, position, length);
      position += length;

      const base64 = btoa(String.fromCharCode.apply(null, chunk));
      yield {
        response: {
          action: 'append',
          file: file.name,
          data: base64,
        },
      };

      let percentDone = fileData.byteLength === 0 ?
          100 :
          Math.round((position / fileData.byteLength) * 100);
      percent.textContent = `${percentDone}% done`;

    } while (position < fileData.byteLength);
  }

  // All done.
  yield {
    response: {
      action: 'complete',
    }
  };
}

scope.google = scope.google || {};
scope.google.colab = scope.google.colab || {};
scope.google.colab._files = {
  _uploadFiles,
  _uploadFilesContinue,
};
})(self);
</script> 


    Saving kakao.png to kakao (4).png
    
    추출된 텍스트:
    <progressBar class="progress-bar"></progress> <audio id="audioPlayer" src="https://raw.githubusercontent.com/joonlab/audio-share/main/research_paper_podcast_by_IU-Can_LLMs_Generate_Novel_Research_Ideas.mp3" type="audio/mpeg"></audio>


## 90B & 이미지 URL


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

