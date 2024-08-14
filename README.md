# Shoppang!
<br>

네이버 쇼핑 검색 API를 활용하여 마음에 드는 상품을 검색하고 찜할 수 있는 앱

<br>

## 🗄️ 프로젝트 정보
- **기간** : `2024.06.14 ~ 2024.07.19` (약 1개월)
- **개발 인원** : `iOS 1명`
- **지원 버전**: <img src="https://img.shields.io/badge/iOS-15.0+-black?logo=apple"/>
- **기술 스택 및 라이브러리** : `UIKit` `Webkit` `SnapKit` `Then` `Toast-Swift` `Kingfisher` `Realm` `Alamofire`
- **프로젝트 주요 기능**

  - `상품 검색`
    - 최근 검색어 조회/삭제 기능
    - 상품 검색 결과 조회/정렬 기능
    - 상품 상세 정보 조회 기능
  
  <br>
  
  - `Apple 브랜드관`
    - Apple 제품 콜렉션 조회 기능
      
  <br>
  
  - `상품 찜하기`
    - 상품 찜 버튼 기능
    - 찜한 목록 조회/삭제/정렬 기능

<br>

| 상품 검색 | Apple 브랜드관 | 상품 찜하기 |
|--|--|--|
|![Simulator Screen Recording - iPhone 15 Pro Max - 2024-08-13 at 00 24 50](https://github.com/user-attachments/assets/f41bb49b-a348-467f-b93e-82cb0469b512)|![Simulator Screen Recording - iPhone 15 Pro Max - 2024-08-12 at 22 30 52](https://github.com/user-attachments/assets/8bca80dd-4552-46a9-ab6a-d41a3bbd6596)|![Simulator Screen Recording - iPhone 15 Pro Max - 2024-08-13 at 00 13 38](https://github.com/user-attachments/assets/a0c09f3c-c67b-4361-bd95-09e685844308)|


<br>

## 🧰 주요 기능 구현 방법

### 상품 검색

- `UserDefaults`에 검색어와 검색 날짜로 이루어진 `Struct를 Encoding`하여 저장하는 방식으로 `최근 검색어 조회 기능` 구현
- `Alamofire`을 통해 `네이버 쇼핑 검색 API`로부터 받아온 검색 결과를 `UICollectionViewFlowLayout`을 사용한 UICollectionView로 보여주는 방식으로 `상품 검색 결과 조회 기능` 구현
  - `UICollectionViewDataSourcePrefetching`을 활용하여 `페이지네이션` 기능 구현
- 상품 상세 웹페이지 링크를 활용하여 `WKWebView`로 띄우는 방식으로 `상품 상세 정보 조회 기능` 구현

<br>

### Apple 브랜드관

- Apple 제품별 네이버 쇼핑 API 결과 리스트를 `UITableView 내부의 UICollectionView` 형태의 뷰로 보여주는 방식으로 `Apple 제품 콜렉션 조회 기능` 구현
- `DispatchGroup`을 사용

<br>

### 상품 찜하기

- `Realm`을 활용하여 찜한 상품의 정보를 로컬 DB에 저장
- `UIMenu`를 사용하여 찜한 목록의 정렬 옵션의 `Pull-Down 버튼` 구현
- `ViewController LifeCycle` 메서드를 사용하여 각 화면에서의 `찜 표시 연동` 기능 구현

<br>

## 📌 고려 사항

### 1. API 과다 호출 방지

- 검색 결과 화면 정렬 버튼 클릭
- 검색 결과 화면에서 마지막 페이지일 경우 스크롤 시 API 호출하지 않음

### 2. 찜한 목록에서 찜 삭제 시 바로 사라지지 않게 구현

- 찜 목록 화면에서 삭제 시 바로 삭제되지 않고 viewWillDisappear 시점에서 찜이 삭제되도록 하여 유저로 하여금 찜 목록에서 다시 추가할 수 있게 함

### 3. 검색 결과 화면에서의 찜한 상품 판단 로직 관련 시간복잡도

- 검색 결과 화면에 보여주는 상품 리스트와 찜한 상품 리스트끼리 비교 로직은 O(n2)
- 찜한 상품 리스트를 Array에서 Set으로 바꿔 판단 로직을 O(n)으로 개선

<br>

## 🚨 트러블 슈팅

### 1. UITableView에서의 UICollectionViewDelegate/Datasource 위임 문제

 - 특정 CollectionView의 렌더링 누락 현상
   - 원인 분석: `cellForRowAt` 메서드 호출 시점에 위임되어 렌더링 되지 않은 TableViewCell에서 CollectionView를 렌더링하려고 함
   - 해결: `willDisplay` 메서드 호출 시점에 위임

 - UITableViewCell 재사용 시 데이터 불일치 문제
   - 원인 분석: 재사용 시 이전에 설정한 위임이 해제되지 않아, 기존 셀의 데이터가 남아있어 불일치 문제 발생
   - 해결: `prepareForReuse` 메서드에서 위임을 해제하여 해결

<br>

### 2. 뷰 컨트롤러 간의 생명 주기 순서에 따른 화면 간 찜 여부 데이터 불일치 문제

- 원인 분석
  
  - `찜한 목록 리스트 화면`에서는 `viewWillDisappear` 메서드 호출 시점에 Realm에서 해당 상품을 삭제
  - `검색 결과 화면`에서는 `viewWillAppear` 메서드 호출 시점에 찜 여부 정보를 업데이트
  - `viewWillDisappear보다 viewWillAppear가 더 먼저 호출`

- 해결

  - `검색 결과 화면`에서 찜 여부 정보 업데이트 시점을 `viewIsAppearing` 메서드 호출 시점으로 변경

<br>

### 3. ATS 정책에 의해 특정 링크에서 웹뷰 로드에 실패되는 문제

- 원인 분석

  - WKWebView의 `didFailProvisionalNavigation` 메서드 내에서 에러 메세지를 확인한 결과 iOS의 `ATS 정책`과 관련된 것을 확인
  - 실제로 특정 링크가 사용중인 프로토콜은 `HTTPS가 아닌 HTTP`

- 해결

  - `Info.plist`에서 `Allow Arbitrary Loads를 NO로 설정`하여 해결

