//
//  ProgressView4.swift
//  OnboardingTest
//
//  Created by 전준수 on 3/11/24.
//

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

#Preview {
    ProgressView4()
}
