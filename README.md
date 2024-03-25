## **1\. Onboarding 이란**

\- 온보딩 화면은 앱을 최초로 실행했을 때 앱 소개, 사용법 안내 등을 위해 사용

\- 새로운 사용자와 복귀하는 사용자를 맞이하는 수단

\- [Apple Developer HIG](https://developer.apple.com/design/human-interface-guidelines/onboarding)

<img width="770" alt="스크린샷 2024-03-25 오후 4 01 48" src="https://github.com/JIN-JJS/OnboardingTest/assets/114235515/cfb46766-9b07-43a9-8b10-70579d39aa2a">


### **(1) HIG 모범 사례 고려사항**

\- 사람들이 많은 정보를 외우거나 제공할 필요가 없는 간단하고 즐거운 경험으로 디자인

\- 온보딩 흐름이 앱에 관한 것인지 확인

\- 상호작용을 통한 교육을 선호

\- 별도의 온보딩 흐름 대신 간략한 온보딩 요소를 기본 경험에 통합하는 것을 고려

\- 튜토리얼을 제공하는 경우 사람들이 건너뛸 수 있는 방법을 제공

\- 온보딩 흐름 내에서 라이선스 세부 정보를 표시하지 않기

## **2\. 기본 스타일**

![Simulator Screen Recording - iPhone 15 Pro - 2024-03-18 at 16 34 09](https://github.com/JIN-JJS/OnboardingTest/assets/114235515/229850fe-2def-4eed-9e36-d98b10251869)


### **(1) 프로젝트 구성**

\- MVVM패턴의 프로젝트 구성

<img width="250" alt="스크린샷 2024-03-18 오후 12 25 36" src="https://github.com/JIN-JJS/OnboardingTest/assets/114235515/ad4146a4-2d21-48f3-8299-1a701cdd4925">


### **(2) ContentView**

\- **@State** 속성을 포함하여 데이터 저장까지 한 번에 할 수 있는 property wrapper **@AppStorage**를 사용하여,

사용자가 앱을 처음으로 켰는지 여부를 확인해봅시다.

\- 온보딩뷰를 노출 시에는 **popover**은 모달뷰, **fullScreenCover**는 전체화면으로 채워서 보임

```
import SwiftUI

struct ContentView: View {
    
    // 사용자 안내 온보딩 페이지를 앱 설치 후, 최초 실횅할 때만 띄우도록 하는 변수
    // AppStorage에 저장되어 앱 종료 후에도 유지됨
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var body: some View {
        
        VStack {
            Text("Main View")
        }
        // MARK: BasicOnboarding
        .popover(isPresented: $isFirstLaunch) {
            BasicView(isFirstLaunch: $isFirstLaunch)
        }
    }
}
```

### **(3) View**

\- 시작하기 버튼으로 **@AppStorage** 값을 false로 변경할 수 있도록 설정

```
import SwiftUI

struct BasicView: View {
    
    @Binding var isFirstLaunch: Bool
    
    @StateObject var basicViewModel: BasicViewModel = .init()
    
    var body: some View {
        VStack{
            VStack{
                Text("손쉽게 시작해보아요")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.vertical,48)
            
            VStack(spacing:24){
                
                ForEach(basicViewModel.basicModelList){ index in
                    HStack{
                        Image(systemName: "\(index.systemName)")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .frame(width:36,height: 36)
                            .padding(8)
                        
                        VStack{
                            Text("\(index.title)")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.bottom,0.25)
                            Text("\(index.content)")
                                .foregroundColor(.gray)
                                .lineLimit(3)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }
                    }.padding(.horizontal, 16)
                }
                Spacer()
                
                
                Button{
                    isFirstLaunch = false
                } label: {
                    Text("시작하기")
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .frame(maxWidth: 330)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom,24)
            }
        }.padding()
    }
}
```

### **(4) Model**

```
import Foundation

struct BasicModel: Identifiable, Hashable {
    var id: Int
    var systemName: String = ""
    var title: String = ""
    var content: String = ""
}
```

### **(5) View Model**

```
import Foundation
import Combine

final class BasicViewModel: ObservableObject {
    @Published var basicModelList: [BasicModel] = []
    init() {
        fetchModel()
    }
    
    public func fetchModel(){
        self.basicModelList = [
            BasicModel(id:1, systemName: "pencil.circle.fill", title:"메모 글 쓰기" , content:"기존 앱들과 다른 감성 있는 폰트와 디자인이 준비 되어있습니다."),
            BasicModel(id:2, systemName: "square.and.arrow.up.fill", title:"친구에게 공유" , content:"내가 작성한 글을 친구들에게 빠르게 공유할 수 있습니다."),
            BasicModel(id:3, systemName: "paperplane.fill", title:"장소 저장" , content:"메모장 글 작성 시 현재 위치 또한 함께 저장 가능합니다."),
            BasicModel(id:4, systemName: "photo.fill", title:"사진 참조" , content:"사진과 함께 추억을 남겨보세요.")
        ]
    }
}
```

## **3\. 슬라이드 스타일**

![Simulator Screen Recording - iPhone 15 Pro - 2024-03-18 at 16 43 06](https://github.com/JIN-JJS/OnboardingTest/assets/114235515/01d53c43-bc8a-4197-b382-754c8fff0c9a)

### **(1) 프로젝트 구성**

\- MVVM패턴의 프로젝트 구성

<img width="250" alt="스크린샷 2024-03-18 오후 12 26 08" src="https://github.com/JIN-JJS/OnboardingTest/assets/114235515/3e2119e9-6759-4b00-8a98-8378a037de2b">

### **(2) ContentView**

```
struct ContentView: View {
    
    // 사용자 안내 온보딩 페이지를 앱 설치 후, 최초 실횅할 때만 띄우도록 하는 변수
    // AppStorage에 저장되어 앱 종료 후에도 유지됨
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var body: some View {
        
        VStack {
            Text("Main View")
        }
        // MARK: SlideOnboarding
        .fullScreenCover(isPresented: $isFirstLaunch) {
            SlideTapView(isFirstLaunch: $isFirstLaunch)
        }
    }
}
```

### **(3) View**

\- **SlideTapView**에서 **SlideView1** ~ **SlideView4**를 tabViewStyle(PageTabViewStyle())로 좌우로 넘어가게 작성해줍니다.

\- 마지막 페이지에는 시작하기 버튼이 있으므로 **isFirstLaunch** 값을 바인딩 해주어야 합니다.

\- **SlideView** 마다 필요한 데이터는 페이지 마다 index.id의 값으로 구분해서 받아와줍니다.

```
import SwiftUI

struct SlideTapView: View {
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        
        TabView {
            SlideView1()
            
            SlideView2()
            
            SlideView3()
            
            SlideView4(isFirstLaunch: $isFirstLaunch)
        }
        .tabViewStyle(PageTabViewStyle())

    }
}
```

```
import SwiftUI

struct SlideView1: View {
    @StateObject var slideViewModel: SlideViewModel = .init()
    
    var body: some View {
        VStack{
            VStack{
                Text("손쉽게 시작해보아요")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.vertical,48)
            
            VStack(spacing:24){
                ForEach(slideViewModel.slideModelList){ index in
                    if index.id == 1 {
                        HStack{
                            Image(systemName: "\(index.systemName)")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.accentColor)
                                .frame(width:36,height: 36)
                                .padding(8)
                            
                            VStack{
                                Text("\(index.title)")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.bottom,0.25)
                                Text("\(index.content)")
                                    .foregroundColor(.gray)
                                    .lineLimit(3)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                            }
                        }.padding(.horizontal, 16)
                    }
                }
                Spacer()
            }
        }.padding()
    }
}
```

```
import SwiftUI

struct SlideView2: View {
    @StateObject var slideViewModel: SlideViewModel = .init()
    
    var body: some View {
        VStack{
            VStack{
                Text("손쉽게 시작해보아요")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.vertical,48)
            
            VStack(spacing:24){
                ForEach(slideViewModel.slideModelList){ index in
                    if index.id == 2 {
                        HStack{
                            Image(systemName: "\(index.systemName)")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.accentColor)
                                .frame(width:36,height: 36)
                                .padding(8)
                            
                            VStack{
                                Text("\(index.title)")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.bottom,0.25)
                                Text("\(index.content)")
                                    .foregroundColor(.gray)
                                    .lineLimit(3)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                            }
                        }.padding(.horizontal, 16)
                    }
                }
                Spacer()
            }
        }.padding()
    }
}
```

```
import SwiftUI

struct SlideView3: View {
    @StateObject var slideViewModel: SlideViewModel = .init()
    
    var body: some View {
        VStack{
            VStack{
                Text("손쉽게 시작해보아요")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.vertical,48)
            
            VStack(spacing:24){
                ForEach(slideViewModel.slideModelList){ index in
                    if index.id == 3 {
                        HStack{
                            Image(systemName: "\(index.systemName)")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.accentColor)
                                .frame(width:36,height: 36)
                                .padding(8)
                            
                            VStack{
                                Text("\(index.title)")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.bottom,0.25)
                                Text("\(index.content)")
                                    .foregroundColor(.gray)
                                    .lineLimit(3)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                            }
                        }.padding(.horizontal, 16)
                    }
                }
                Spacer()
            }
        }.padding()
    }
}
```

```
import SwiftUI

struct SlideView4: View {
    @StateObject var slideViewModel: SlideViewModel = .init()
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        
        VStack{
            VStack{
                Text("손쉽게 시작해보아요")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.vertical,48)
            
            VStack(spacing:24){
                ForEach(slideViewModel.slideModelList){ index in
                    if index.id == 4 {
                        HStack{
                            Image(systemName: "\(index.systemName)")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.accentColor)
                                .frame(width:36,height: 36)
                                .padding(8)
                            
                            VStack{
                                Text("\(index.title)")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.bottom,0.25)
                                Text("\(index.content)")
                                    .foregroundColor(.gray)
                                    .lineLimit(3)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                            }
                        }.padding(.horizontal, 16)
                    }
                }
                Spacer()
                
                Button{
                    isFirstLaunch = false
                } label: {
                    Text("시작하기")
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .frame(maxWidth: 330)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom,24)
            }
        }.padding()
    }
}
```

### **(4) Model**

```
struct SlideModel: Identifiable, Hashable {
    var id: Int
    var systemName: String = ""
    var title: String = ""
    var content: String = ""
}
```

### **(5) View Model**

```
import Foundation
import Combine

final class SlideViewModel: ObservableObject {
    @Published var slideModelList: [SlideModel] = []
    init() {
        fetchModel()
    }
    
    public func fetchModel(){
        self.slideModelList = [
            SlideModel(id:1, systemName: "pencil.circle.fill", title:"메모 글 쓰기" , content:"기존 앱들과 다른 감성 있는 폰트와 디자인이 준비 되어있습니다."),
            SlideModel(id:2, systemName: "square.and.arrow.up.fill", title:"친구에게 공유" , content:"내가 작성한 글을 친구들에게 빠르게 공유할 수 있습니다."),
            SlideModel(id:3, systemName: "paperplane.fill", title:"장소 저장" , content:"메모장 글 작성 시 현재 위치 또한 함께 저장 가능합니다."),
            SlideModel(id:4, systemName: "photo.fill", title:"사진 참조" , content:"사진과 함께 추억을 남겨보세요.")
        ]
    }
}
```

## **4\. 프로그레스 스타일**

![Simulator Screen Recording - iPhone 15 Pro - 2024-03-18 at 16 56 00](https://github.com/JIN-JJS/OnboardingTest/assets/114235515/9e437150-5ac8-4bff-84bd-ec6468b32b64)

### **(1) 프로젝트 구성**

\- MVVM패턴의 프로젝트 구성

<img width="250" alt="스크린샷 2024-03-18 오후 12 26 31" src="https://github.com/JIN-JJS/OnboardingTest/assets/114235515/86d3bbc2-a66d-4587-afbf-4ef857e49283">

### **(2) ContentView**

```
import SwiftUI

struct ContentView: View {
    
    // 사용자 안내 온보딩 페이지를 앱 설치 후, 최초 실횅할 때만 띄우도록 하는 변수
    // AppStorage에 저장되어 앱 종료 후에도 유지됨
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var body: some View {
        
        VStack {
            Text("Main View")
        }
        // MARK: ProgressOnboarding
        .fullScreenCover(isPresented: $isFirstLaunch) {
            ProgressTapView(isFirstLaunch: $isFirstLaunch)
        }
    }
}
```

### **(3) View**

**\-** 타이머로 카운터 값을 올려 뷰가 자동으로 전환되게 설정

\- 하위 **ProgressView1** ~ **ProgressView5** 내부에 Start, Ready, End의 ProgressView를 직접 그려서 노출시킴

```
import SwiftUI

struct ProgressTapView: View {
    @Binding var isFirstLaunch: Bool
    
    // timer count
    @State var count: Int = 1
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
            ZStack {
                ZStack {
                    TabView(selection: $count,
                            content: {
                        if count == 1 {
                            ProgressView1()
                                .tag(1)
                        } else if count == 2 {
                            ProgressView2()
                                .tag(2)
                        } else if count == 3 {
                            ProgressView3()
                                .tag(3)
                        } else if count == 4 {
                            ProgressView4()
                                .tag(4)
                        } else if count == 5 {
                            ProgressView5()
                                .tag(5)
                        }
                    })
                    .ignoresSafeArea()
                    .onReceive(timer, perform: { _ in
                        withAnimation(.default) {
                            count = count == 5 ? 1 : count + 1
                        }
                    })
                }
                
                VStack {
               
                    Spacer()
           
                        Button{
                            isFirstLaunch = false
                        } label: {
                            Text("시작하기")
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                                .frame(maxWidth: 330)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom,24)

                }
            } 
    }
}
```

```
import SwiftUI

struct ProgressView1: View {
    
    @StateObject var progressViewModel: ProgressViewModel = .init()
    
    // MARK: Ready ProgressView
    var progressReady : Double = 0.0
    
    // MARK: Start ProgressView
    var progressStart: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(3)
        
        return start...end
    }
    
    // MARK: End ProgressView
    var progressEnd: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(0)
        return start...end
    }
    
    var body: some View {
        
            VStack{
                VStack{
                    VStack{
                        Text("손쉽게 시작해보아요")
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical,48)
                    
                    VStack(spacing:24){
                        ForEach(progressViewModel.progressModelList){ index in
                            if index.id == 1 {
                                HStack{
                                    Image(systemName: "\(index.systemName)")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.accentColor)
                                        .frame(width:36,height: 36)
                                        .padding(8)
                                    
                                    VStack{
                                        Text("\(index.title)")
                                            .fontWeight(.bold)
                                            .frame(maxWidth: .infinity,alignment: .leading)
                                            .padding(.bottom,0.25)
                                        Text("\(index.content)")
                                            .foregroundColor(.gray)
                                            .lineLimit(3)
                                            .frame(maxWidth: .infinity,alignment: .leading)
                                    }
                                }.padding(.horizontal, 16)
                            }
                        }
                        Spacer()
                    }
                }.padding()
                
                
                
                HStack(spacing: 4) {
                    // MARK: Start ProgressView
                    ProgressView(timerInterval: progressStart, countsDown: false)
                        .tint(Color.blue)
                        .foregroundColor(.clear)
                        .frame(width: 55)
                    
                    // MARK: Ready ProgressView
                    ProgressView(value: progressReady)
                        .frame(width: 55)
                        .padding(.bottom, 19)
                    
                    // MARK: Ready ProgressView
                    ProgressView(value: progressReady)
                        .frame(width: 55)
                        .padding(.bottom, 19)
                    
                    // MARK: Ready ProgressView
                    ProgressView(value: progressReady)
                        .frame(width: 55)
                        .padding(.bottom, 19)
                    
                    // MARK: Ready ProgressView
                    ProgressView(value: progressReady)
                        .frame(width: 55)
                        .padding(.bottom, 19)
                }
                .padding(.top, -120)

        }
    }
}
```

```
import SwiftUI

struct ProgressView2: View {
    
    @StateObject var progressViewModel: ProgressViewModel = .init()
    
    // MARK: Ready ProgressView
    var progressReady : Double = 0.0
    
    // MARK: Start ProgressView
    var progressStart: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(3)
        
        return start...end
    }
    
    // MARK: End ProgressView
    var progressEnd: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(0)
        return start...end
    }
    
    var body: some View {
        
        VStack{
            VStack{
                VStack{
                    Text("손쉽게 시작해보아요")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.vertical,48)
                
                VStack(spacing:24){
                    ForEach(progressViewModel.progressModelList){ index in
                        if index.id == 2 {
                            HStack{
                                Image(systemName: "\(index.systemName)")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.accentColor)
                                    .frame(width:36,height: 36)
                                    .padding(8)
                                
                                VStack{
                                    Text("\(index.title)")
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.bottom,0.25)
                                    Text("\(index.content)")
                                        .foregroundColor(.gray)
                                        .lineLimit(3)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                }
                            }.padding(.horizontal, 16)
                        }
                    }
                    Spacer()
                }
            }.padding()
            
            
            
            HStack(spacing: 4) {
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: Start ProgressView
                ProgressView(timerInterval: progressStart, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: Ready ProgressView
                ProgressView(value: progressReady)
                    .frame(width: 55)
                    .padding(.bottom, 19)
                
                // MARK: Ready ProgressView
                ProgressView(value: progressReady)
                    .frame(width: 55)
                    .padding(.bottom, 19)
                
                // MARK: Ready ProgressView
                ProgressView(value: progressReady)
                    .frame(width: 55)
                    .padding(.bottom, 19)
            }
            .padding(.top, -120)
        }
    }
}
```

```
import SwiftUI

struct ProgressView3: View {
    
    @StateObject var progressViewModel: ProgressViewModel = .init()
    
    // MARK: Ready ProgressView
    var progressReady : Double = 0.0
    
    // MARK: Start ProgressView
    var progressStart: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(3)
        
        return start...end
    }
    
    // MARK: End ProgressView
    var progressEnd: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(0)
        return start...end
    }
    
    var body: some View {
        
        VStack{
            VStack{
                VStack{
                    Text("손쉽게 시작해보아요")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.vertical,48)
                
                VStack(spacing:24){
                    ForEach(progressViewModel.progressModelList){ index in
                        if index.id == 3 {
                            HStack{
                                Image(systemName: "\(index.systemName)")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.accentColor)
                                    .frame(width:36,height: 36)
                                    .padding(8)
                                
                                VStack{
                                    Text("\(index.title)")
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.bottom,0.25)
                                    Text("\(index.content)")
                                        .foregroundColor(.gray)
                                        .lineLimit(3)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                }
                            }.padding(.horizontal, 16)
                        }
                    }
                    Spacer()
                }
            }.padding()
            
            
            
            HStack(spacing: 4) {
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: Start ProgressView
                ProgressView(timerInterval: progressStart, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: Ready ProgressView
                ProgressView(value: progressReady)
                    .frame(width: 55)
                    .padding(.bottom, 19)
                
                // MARK: Ready ProgressView
                ProgressView(value: progressReady)
                    .frame(width: 55)
                    .padding(.bottom, 19)
            }
            .padding(.top, -120)
        }
    }
}
```

```
import SwiftUI

struct ProgressView4: View {
    
    @StateObject var progressViewModel: ProgressViewModel = .init()
    
    // MARK: Ready ProgressView
    var progressReady : Double = 0.0
    
    // MARK: Start ProgressView
    var progressStart: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(3)
        
        return start...end
    }
    
    // MARK: End ProgressView
    var progressEnd: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(0)
        return start...end
    }
    
    var body: some View {
        
        VStack{
            VStack{
                VStack{
                    Text("손쉽게 시작해보아요")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.vertical,48)
                
                VStack(spacing:24){
                    ForEach(progressViewModel.progressModelList){ index in
                        if index.id == 4 {
                            HStack{
                                Image(systemName: "\(index.systemName)")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.accentColor)
                                    .frame(width:36,height: 36)
                                    .padding(8)
                                
                                VStack{
                                    Text("\(index.title)")
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.bottom,0.25)
                                    Text("\(index.content)")
                                        .foregroundColor(.gray)
                                        .lineLimit(3)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                }
                            }.padding(.horizontal, 16)
                        }
                    }
                    Spacer()
                }
            }.padding()
            
            
            
            HStack(spacing: 4) {
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: Start ProgressView
                ProgressView(timerInterval: progressStart, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: Ready ProgressView
                ProgressView(value: progressReady)
                    .frame(width: 55)
                    .padding(.bottom, 19)
            }
            .padding(.top, -120)
        }
    }
}
```

```
import SwiftUI

struct ProgressView5: View {
    
    @StateObject var progressViewModel: ProgressViewModel = .init()
    
    // MARK: Ready ProgressView
    var progressReady : Double = 0.0
    
    // MARK: Start ProgressView
    var progressStart: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(3)
        
        return start...end
    }
    
    // MARK: End ProgressView
    var progressEnd: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(0)
        return start...end
    }
    
    var body: some View {
        
        
        VStack{
            VStack{
                VStack{
                    Text("손쉽게 시작해보아요")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.vertical,48)
                
                VStack(spacing:24){
                    ForEach(progressViewModel.progressModelList){ index in
                        if index.id == 5 {
                            HStack{
                                Image(systemName: "\(index.systemName)")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.accentColor)
                                    .frame(width:36,height: 36)
                                    .padding(8)
                                
                                VStack{
                                    Text("\(index.title)")
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.bottom,0.25)
                                    Text("\(index.content)")
                                        .foregroundColor(.gray)
                                        .lineLimit(3)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                }
                            }.padding(.horizontal, 16)
                        }
                    }
                    Spacer()
                }
            }.padding()
            
            
            
            HStack(spacing: 4) {
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: End ProgressView
                ProgressView(timerInterval: progressEnd, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
                
                // MARK: Start ProgressView
                ProgressView(timerInterval: progressStart, countsDown: false)
                    .tint(Color.blue)
                    .foregroundColor(.clear)
                    .frame(width: 55)
            }
            .padding(.top, -120)
        }
    }
}
```

### **(4) Model**

```
struct ProgressModel: Identifiable, Hashable {
    var id: Int
    var systemName: String = ""
    var title: String = ""
    var content: String = ""
}
```

### **(5) View Model**

```
import Foundation
import Combine

final class ProgressViewModel: ObservableObject {
    @Published var progressModelList: [ProgressModel] = []
    init() {
        fetchModel()
    }
    
    public func fetchModel(){
        self.progressModelList = [
            ProgressModel(id:1, systemName: "pencil.circle.fill", title:"메모 글 쓰기" , content:"기존 앱들과 다른 감성 있는 폰트와 디자인이 준비 되어있습니다."),
            ProgressModel(id:2, systemName: "square.and.arrow.up.fill", title:"친구에게 공유" , content:"내가 작성한 글을 친구들에게 빠르게 공유할 수 있습니다."),
            ProgressModel(id:3, systemName: "paperplane.fill", title:"장소 저장" , content:"메모장 글 작성 시 현재 위치 또한 함께 저장 가능합니다."),
            ProgressModel(id:4, systemName: "photo.fill", title:"사진 참조" , content:"사진과 함께 추억을 남겨보세요."),
            ProgressModel(id:5, systemName: "cloud.snow.fill", title:"날씨 참조" , content:"추억의 온도를 함께 남겨보세요.")
        ]
    }
}
```
