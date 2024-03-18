//
//  SlideView4.swift
//  OnboardingTest
//
//  Created by 전준수 on 3/18/24.
//

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

#Preview {
    SlideView4(isFirstLaunch: .constant(false))
}
