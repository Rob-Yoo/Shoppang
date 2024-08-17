# Shoppang!
<br>

네이버 쇼핑 검색 API를 활용하여 상품을 검색하고 찜할 수 있는 앱

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

## 🧰 주요 기능 기술 사항

### 상품 검색

- `UserDefaults`와 `JSONEncoder/Decoder`를 활용하여 `최근 검색어 조회 기능` 구현

- `Repository 패턴`을 활용하여 `외부 데이터 소스 접근 작업 추상화`

  - `라우터 패턴`과 `싱글턴 패턴` 활용하여 `네트워크 작업 추상화`

- `UICollectionViewDataSourcePrefetching`을 활용하여 `페이지네이션` 기능 구현

- `WKWebView`를 활용하여 `상품 상세 정보 조회 기능` 구현

<br>

### Apple 브랜드관

- `UITableView`와 `UICollectionView`을 혼합하여 `수직/수평 스크롤 뷰` 구현

- `DispatchGroup`을 사용하여 `데이터 순서 보장과 TableView의 중복 갱신 방지`

<br>

### 상품 찜하기

- `Repoistory 패턴`을 사용하여 `로컬 데이터 소스 접근 작업 추상화`

- 검색 결과 상품 리스트의 `찜 여부 판단 로직`을 `O(N^2)에서 O(N)`으로 개선

<br>

## 🚨 트러블 슈팅

### 1. UITableView에서의 UICollectionViewDelegate/Datasource 위임 문제

 - 특정 CollectionView의 `렌더링 누락 현상`
   - 원인 분석: `cellForRowAt` 메서드 호출 시점에 위임되어 렌더링 되지 않은 TableViewCell에서 CollectionView를 렌더링하려고 함
   - 해결: `willDisplay` 메서드 호출 시점에 위임

 - UITableViewCell 재사용 시 `데이터 불일치 문제`
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

