//
//  GoalCardView.swift
//  Goally
//
//  Created by Hieu Le on 1/1/24.
//

import SwiftUI

struct GoalCardView: View {
    
    var goalTitle: String
    var goalProgress: Double
    
    @StateObject private var goalListViewModel = GoalListViewModel()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(goalTitle)
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .foregroundColor(.black)
                
                HStack {
                    ProgressView(value: goalProgress / 100)
                        .tint(Color(.systemBlue))
                    
                    Text("\(Int(floor(goalProgress)))%")
                        .font(.system(size: 12))
                        .padding(.bottom, 4)
                        .foregroundColor(Color(.systemBlue))
                }
                
            }
            .padding(.leading, 10)
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: UIScreen.screenWidth * 9/10, height: UIScreen.screenWidth * 1/5, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color(.lightGray), lineWidth: 1)
        )
        .padding(.bottom, 7)
    }
}

struct GoalCardView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCardView(goalTitle: "Learn Core Data", goalProgress: 0.66)
    }
}
