//
//  SlideViewModel.swift
//  OnboardingTest
//
//  Created by 전준수 on 3/11/24.
//

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
