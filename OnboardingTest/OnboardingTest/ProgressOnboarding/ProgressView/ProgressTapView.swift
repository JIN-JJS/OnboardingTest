//
//  ProgressTapView.swift
//  OnboardingTest
//
//  Created by 전준수 on 3/11/24.
//

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

#Preview {
    ProgressTapView(isFirstLaunch: .constant(false))
}
