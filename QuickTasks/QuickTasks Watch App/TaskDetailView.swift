import SwiftUI

struct TaskDetailView: View {
    @Binding var task: TaskItem

    init(task: Binding<TaskItem>) {
        self._task = task
    }

    init(task: TaskItem) {
        self._task = .constant(task)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                // Large status icon
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 48))
                    .foregroundStyle(task.completed ? .green : .secondary)
                    .padding(.top, 4)

                // Task title
                Text(task.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)

                // Status text
                Text(task.completed ? "Completed" : "Pending")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(task.completed ? .green : .secondary)

                Divider()
                    .padding(.vertical, 4)

                // Category row (Option C)
                HStack(spacing: 8) {
                    Image(systemName: task.category.iconName)
                        .foregroundStyle(.secondary)
                    Text(task.category.rawValue)
                        .font(.body)
                        .foregroundStyle(.secondary)
                    Spacer()
                }

                // Priority row (Option D)
                HStack(spacing: 8) {
                    Text("—")
                        .foregroundStyle(task.priority.color)
                    Text("\(task.priority.rawValue) Priority")
                        .font(.body)
                        .foregroundStyle(task.priority.color)
                    Spacer()
                }

                Divider()
                    .padding(.vertical, 4)

                // Toggle status button
                Button {
                    task.completed.toggle()
                } label: {
                    Label(
                        task.completed ? "Mark Incomplete" : "Mark Completed",
                        systemImage: task.completed ? "arrow.counterclockwise" : "checkmark"
                    )
                }
                .tint(task.completed ? .orange : .green)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Details")
    }
}

#Preview {
    NavigationStack {
        TaskDetailView(
            task: .constant(
                TaskItem(
                    title: "Morning Walk",
                    completed: true,
                    category: .health,
                    priority: .medium
                )
            )
        )
    }
}
