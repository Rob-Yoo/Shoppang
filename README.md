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


## 🚨 주요 이슈와 해결 과정

