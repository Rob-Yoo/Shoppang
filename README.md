# Shoppang!
<div align = "center">
  <img width="150" alt="앱아이콘 예정" src="">
  <br>
  <br>
  <img src="https://img.shields.io/badge/Swift-v5.0-red?logo=swift"/>
  <img src="https://img.shields.io/badge/Xcode-v15.0-blue?logo=Xcode"/>
  <img src="https://img.shields.io/badge/iOS-15.0+-black?logo=apple"/>
</div>
<br>

소개글

<br>
<br>

## 🗄️ 프로젝트 정보
- **기간** : `2024.06.14 ~ 2024.07.19` (약 1개월)
- **개발 인원** : `iOS 1명`
- **기술 스택 및 사용 라이브러리** : `UIKit` `Webkit` `SnapKit` `Then` `Toast-Swift` `Kingfisher` `Realm` `Alamofire`
- **프로젝트 주요 기능**

  - `상품 검색`
    - 최근 검색어 조회/삭제 기능
    - 상품 검색 결과 조회 기능
    - 상품 검색 결과 정렬 옵션 기능
    - 상품 상세 정보 조회 기능
  
  <br>
  
  - `Apple 브랜드관`
    - Apple 제품 콜렉션 조회 기능
      
  <br>
  
  - `상품 찜하기`
    - 상품 찜버튼 기능
    - 찜한 목록 조회/삭제 기능
    - 찜한 목록 정렬 옵션 기능

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
- `DispatchGroup`을 사용하여 .....
```swift
func fetchAppleCollectionResult() {
    let requests = AppleProductType.allCases.map { $0.request }
    var productList: [ShoppingDTO?] = Array(repeating: nil, count: AppleProductType.allCases.count)

    let group = DispatchGroup()
    
    for (idx, request) in requests.enumerated() {
        group.enter()

        DispatchQueue.global().async(group: group) {
            NetworkManager.requestAPI(req: request){ result in
                productList[idx] = result
                group.leave()
            } failure: { _ in
                group.leave()
            }
        }

    }
    
    group.notify(queue: .main) {
        self.appleProductList = productList.compactMap { $0 }
    }
}
```

<br>

### 상품 찜하기

- `Realm`을 활용하여 찜한 상품의 정보를 로컬 DB에 저장
- `UIMenu`를 사용하여 찜한 목록의 정렬 옵션의 `Pull-Down 버튼` 구현
- `ViewController LifeCycle` 메서드를 사용하여 각 화면에서의 `찜 표시 연동` 기능 구현

<br>

## 📌 고려 사항



## 🚨 트러블 슈팅

### 1. UITableView 내부에서의 UICollectionView Delegate/Datasource 시점 문제와 UITableViewCell 재사용 문제

- `UICollectionView가 그려지지 않는 UITableViewCell이 존재`
- UITableViewCell이 재사용 되면서 `실제로 보여져야 할 Apple 제품과 다른 제품이 보여지는 상황`

<br>

<div align = "center">
  <img width="200" alt="재사용 문제 상황" src="https://github.com/user-attachments/assets/c9d86412-c7a9-42f6-b996-eebb23192645">
</div>

<br>

**🚧 해결 과정**

1. UITableView 내부에서의 UICollectionView Delegate/Datasource 시점 문제
   - 원인: `cellForRowAt 시점에 UICollectionView Delegate/Datasource를 지정`해줘서 실제로 UITableViewCell이 화면에 보이지 않는 경우에도 CollectionView를 그리려고 함
   - 해결: `willDisplay` 시점에 UICollectionView Delegate/Datasource를 지정해주는 것으로 해결

2. UITableViewCell 재사용 문제
   - 원인: UICollectionView Delegate/Datasource
   - 해결: `prepareForReuse` 메서드에서 `UICollectionView Delegate/Datasource를 nil로 초기화` 해줌으로써 해결

<br>

### 2. 찜한 목록에서 삭제 시 다른 화면에서 반영이 안되는 문제

<br>

<div align = "center">
  <img width="200" alt="찜한 상품 연동 문제 상황" src="https://github.com/user-attachments/assets/993e79ad-4ef0-4b44-bac8-4aa9008fcd30">
</div>

<br>

**🚧 해결 과정**

- 원인
  - `찜한 목록 리스트 화면`에서는 `viewWillDisappear` 시점에 Realm에서 해당 상품을 삭제
  - `검색 결과 화면`에서는 `viewWillAppear` 시점에 찜 상품에 대한 정보를 리로드
  - `viewWillDisappear보다 viewWillAppear가 더 먼저 호출`
<br>

- 해결
  - `검색 결과 화면`에서 찜 상품 정보 리로드 시점을 `viewIsAppearing` 시점으로 변경함으로써 해결 

<br>

### 3. 정상적인 웹 페이지 링크임에도 웹뷰를 띄울 수 없는 문제

<br>

<div align = "center">
  <img width="200" alt="웹뷰 문제 상황" src="https://github.com/user-attachments/assets/53ed5e10-6f39-4feb-be7c-89caa8f4f233">
</div>

<br>

**🚧 해결 과정**

- 원인
  - WKWebView의 `didFailProvisionalNavigation` 메서드 내에서 에러 메세지를 확인한 결과 iOS의 `ATS 정책`과 관련된 것을 확인
  - 실제로 해당 `웹페이지 링크는 HTTPS가 아닌 HTTP`

<br>

- 해결
  - `Info.plist`에서 `Allow Arbitrary Loads를 NO로 설정`하여 해결 

