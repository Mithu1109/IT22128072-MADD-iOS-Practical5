import SwiftUI

struct ContentView: View {
    // MARK: - State Management (Part B)
    @State private var tasks: [TaskItem] = [
        TaskItem(
            title: "Morning Walk",
            completed: true,
            category: .health,
            priority: .medium
        ),
        TaskItem(
            title: "Drink Water",
            completed: false,
            category: .health,
            priority: .high
        ),
        TaskItem(
            title: "Read Notes",
            completed: false,
            category: .study,
            priority: .medium
        ),
        TaskItem(
            title: "Call Home",
            completed: true,
            category: .personal,
            priority: .low
        )
    ]

    // MARK: - Computed Properties (Part E & Part G Option B)
    private var completedCount: Int {
        tasks.filter { $0.completed }.count
    }

    private var completionPercentage: Int {
        guard !tasks.isEmpty else { return 0 }
        return Int((Double(completedCount) / Double(tasks.count)) * 100)
    }

    private var progressRatio: Double {
        guard !tasks.isEmpty else { return 0.0 }
        return Double(completedCount) / Double(tasks.count)
    }

    // MARK: - Body View
    var body: some View {
        NavigationStack {
            List {
                // Summary Progress Card
                Section {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(completedCount) / \(tasks.count) Completed")
                            .font(.headline)
                            .bold()

                        Text("\(completionPercentage)% Complete")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        // Visual Progress Bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 8)

                                Capsule()
                                    .fill(Color.green)
                                    .frame(
                                        width: max(0, geometry.size.width * CGFloat(progressRatio)),
                                        height: 8
                                    )
                                    .animation(.easeInOut, value: completedCount)
                            }
                        }
                        .frame(height: 8)
                        .padding(.top, 4)
                    }
                    .padding(.vertical, 4)
                }

                // Tasks List (Part C & D)
                Section(header: Text("Tasks")) {
                    ForEach(tasks.indices, id: \.self) { index in
                        Button {
                            withAnimation {
                                tasks[index].completed.toggle()
                            }
                        } label: {
                            HStack {
                                Image(
                                    systemName: tasks[index].completed
                                        ? "checkmark.circle.fill"
                                        : "circle"
                                )
                                .font(.title3)
                                .foregroundStyle(tasks[index].completed ? .green : .secondary)

                                Text(tasks[index].title)
                                    .strikethrough(tasks[index].completed)
                                    .foregroundStyle(
                                        tasks[index].completed ? .secondary : .primary
                                    )

                                Spacer()
                            }
                        }
                    }
                }

                // Task Details Navigation (Part F)
                Section(header: Text("Details")) {
                    ForEach(tasks.indices, id: \.self) { index in
                        NavigationLink {
                            TaskDetailView(task: $tasks[index])
                        } label: {
                            HStack {
                                Image(systemName: tasks[index].category.iconName)
                                    .foregroundStyle(.blue)
                                Text(tasks[index].title)
                                    .font(.footnote)
                                Spacer()
                            }
                        }
                    }
                }

                // Reset Tasks Action (Part G - Option A)
                Section {
                    Button(role: .destructive) {
                        withAnimation {
                            for index in tasks.indices {
                                tasks[index].completed = false
                            }
                        }
                    } label: {
                        Label("Reset All Tasks", systemImage: "arrow.counterclockwise")
                    }
                }
            }
            .navigationTitle("Quick Tasks")
        }
    }
}

#Preview {
    ContentView()
}
