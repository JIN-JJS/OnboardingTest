//
//  ContentView.swift
//  OnboardingTest
//
//  Created by 전준수 on 3/11/24.
//

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
        //        .popover(isPresented: $isFirstLaunch) {
        //            BasicView(isFirstLaunch: $isFirstLaunch)
        //        }
        
        // MARK: SlideOnboarding
        //        .fullScreenCover(isPresented: $isFirstLaunch) {
        //            SlideTapView(isFirstLaunch: $isFirstLaunch)
        //        }
        
        // MARK: ProgressOnboarding
        .fullScreenCover(isPresented: $isFirstLaunch) {
            ProgressTapView(isFirstLaunch: $isFirstLaunch)
        }
    }
}

#Preview {
    ContentView()
}
