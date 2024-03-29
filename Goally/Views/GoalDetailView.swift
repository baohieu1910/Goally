//
//  GoalDetailView.swift
//  Goally
//
//  Created by Hieu Le on 1/1/24.
//

import SwiftUI

struct GoalDetailView: View {
    @State var showAddGoal = false
    @State var showAddTask = false
    
    @StateObject var goal: Goals
    
    @StateObject private var taskListViewModel = TaskListViewModel()
    @StateObject private var goalListViewModel = GoalListViewModel()
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    VStack {
                        HStack {
                            VStack (alignment: .leading) {
                                Text(goal.unwrappedTitle)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold))
                                    .padding(.bottom, 5)
                                
                                Text(goal.unwrappedDesc)
                                    .foregroundColor(.white)
                                    .lineSpacing(5)
                                    .font(.system(size: 14))
                            }
                            .frame(width: UIScreen.screenWidth*60/100, alignment: .leading)
                            .offset(x: 23, y: -15)

                            ZStack {
                                CircularProgressBarView(progress: goal.progress)
                                    .frame(width: 80, height: 80)
                                    .padding(.bottom, 20)

                            }
                            .frame(width: UIScreen.screenWidth*40/100, alignment: .center)

                        }
                        .padding(.top, 15)
                        .padding(.bottom, 3)
                    }
                    .frame(width: UIScreen.screenWidth, height: 140)
                    .background(Color("DarkBlue"))
                    
                    Spacer()
                    
                    if (goal.tasksArray.count == 0) {
                        VStack {
                            Image("No-Tasks")
                                .resizable()
                                .scaledToFit()
        
                            Text("You've no tasks")
                                .font(.system(size: 18, weight: .bold))
                                .padding(.bottom, 3)
                                .frame(width: 390, alignment: .center)
        
                            Text("Add new task and start progressing")
                                .font(.system(size: 12))
                                .padding(.bottom, 10)
                                .frame(width: 390, alignment: .center)
                            
                            Button(action: {
                                self.showAddTask.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus")
                                    
                                    Text("Add Task")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 344, height: 48)
                                .foregroundColor(.white)
                                .background(Color("DarkBlue"))
                                .cornerRadius(8)
                            }
                        }
                        
                    } else {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Your Tasks")
                                    .font(.system(size: 18, weight: .bold))
                                    .padding(.vertical, 15)
                                    .padding(.leading, 19)
                                
                                Spacer()
                                
                                Button(action: {
                                    self.showAddTask.toggle()
                                }) {
                                    Label("Add", systemImage: "plus")
                                        .foregroundColor(Color("DarkBlue"))
                                        .offset(x: -17)
                                }
                            }
                            
                            List {
                                ForEach(Array(goal.tasksArray.enumerated()), id: \.offset) { index, task in
                                    VStack {
                                        HStack {
                                            Image(systemName: task.isAchieved ? "checkmark.square.fill" : "square")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(task.isAchieved ? Color("DarkBlue") : Color("DarkGray"))
                                                .onTapGesture {
                                                    task.isAchieved.toggle()
                                                    taskListViewModel.updateTask()
                                                    goalListViewModel.calculateProgress(goal: goal)
                                                }
                                            
                                            VStack (alignment: .leading) {
                                                Text(task.unwrappedTitle)
                                                    .font(.system(size: 14))
                                                    .padding(.bottom, 4)
                                                
                                                Text(task.unwrappedReminderTime, formatter: itemFormatter)
                                                    .foregroundColor(Color("DarkGray"))
                                                    .font(.system(size: 12))
                                                    .padding(.bottom, 4)
                                            }
                                            .padding(.leading)
                                            .padding(.vertical, 10)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .listStyle(.plain)
                        }
                    }

                    Spacer()
                }
                .navigationBarHidden(true)
            }
            .sheet(isPresented: $showAddTask) {
                AddTaskView(showAddTask: self.$showAddTask, goals: goal)
                    .environmentObject(taskListViewModel)
            }
        }
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goal: Goals(context: CoreDataManager.shared.viewContext))
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
