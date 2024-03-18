//
//  SlideTapView.swift
//  OnboardingTest
//
//  Created by 전준수 on 3/11/24.
//

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

#Preview {
    SlideTapView(isFirstLaunch: .constant(false))
}
