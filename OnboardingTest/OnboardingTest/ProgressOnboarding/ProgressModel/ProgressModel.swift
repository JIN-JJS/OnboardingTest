//
//  ProgressModel.swift
//  OnboardingTest
//
//  Created by 전준수 on 3/11/24.
//

struct ProgressModel: Identifiable, Hashable {
    var id: Int
    var systemName: String = ""
    var title: String = ""
    var content: String = ""
}
