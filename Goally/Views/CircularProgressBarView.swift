//
//  CircularProgressBarView.swift
//  Goally
//
//  Created by Hieu Le on 1/1/24.
//

import SwiftUI

struct CircularProgressBarView: View {
    
    let progress: Int16
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(.systemOrange).opacity(0.5),
                        lineWidth: 13
                    )
            
            Circle()
                .trim(from: 0, to: Double(Double(progress)/100))
                .stroke(Color(.systemOrange),
                        style: StrokeStyle( lineWidth: 13, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}

struct CircularProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBarView(progress: 0)
    }
}
