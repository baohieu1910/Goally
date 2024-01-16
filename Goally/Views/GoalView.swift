//
//  GoalView.swift
//  Goally
//
//  Created by Hieu Le on 1/1/24.
//

import SwiftUI
import SwipeableView

struct GoalView: View {
    @State var showAddGoal = false
    @State var showEditGoal = false
    @State private var showDeleteAlert = false
    @State var selectedGoal: Goals
    
    @StateObject private var goalListViewModel = GoalListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Text(goalListViewModel.goals.count == 0 ? "No goals are waiting for you today" : "\(goalListViewModel.goals.count) goals are waiting for you today")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.bottom, 23)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    if (goalListViewModel.goals.count == 0) {
                        
                        Image("No-Goals")
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 38)
                            .frame(width: UIScreen.screenWidth, height: 317)
        
                        Text("You've no goals")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.bottom, 6)
                            .frame(width: UIScreen.screenWidth, alignment: .center)
        
                        Text("Add new goal and start progressing")
                            .font(.system(size: 12))
                            .padding(.bottom, 6)
                            .frame(width: UIScreen.screenWidth, alignment: .center)
                    
                    } else {
                        ForEach(goalListViewModel.goals, id: \.self) { goal in
                            NavigationLink(destination: GoalDetailView(goal: goal)) {
                                GoalCardView(goalTitle: goal.unwrappedTitle, goalProgress: Double(goal.unwrappedProgress))
                            }
                        }
                        .environmentObject(goalListViewModel)
                    }
                    Spacer()
                }
                .navigationTitle("Your Goals")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.showAddGoal.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color(.systemBlue))
                        }
                    }
                }
            }
        }
        .onAppear {
            goalListViewModel.getAllGoals()
        }
        .sheet(isPresented: $showAddGoal) {
            AddGoalView(showModal: self.$showAddGoal).environmentObject(goalListViewModel)
        }
    }
    
    private func deleteAction(goal: Goals){
        self.selectedGoal = goal
        self.showDeleteAlert.toggle()
    }
    
    private func editAction(goal: Goals){
        self.selectedGoal = goal
        self.showEditGoal.toggle()
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(selectedGoal: Goals())
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
