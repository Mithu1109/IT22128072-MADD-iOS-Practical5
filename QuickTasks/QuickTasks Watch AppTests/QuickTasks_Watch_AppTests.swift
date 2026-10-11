import Testing
@testable import QuickTasks_Watch_App

struct QuickTasks_Watch_AppTests {

    @Test func testTaskItemInitialization() async throws {
        let task = TaskItem(
            title: "Morning Walk",
            completed: true,
            category: .health,
            priority: .medium
        )

        #expect(task.title == "Morning Walk")
        #expect(task.completed == true)
        #expect(task.category == .health)
        #expect(task.priority == .medium)
    }

    @Test func testTaskToggleCompletion() async throws {
        var task = TaskItem(
            title: "Drink Water",
            completed: false,
            category: .health,
            priority: .high
        )

        #expect(task.completed == false)
        task.completed.toggle()
        #expect(task.completed == true)
        task.completed.toggle()
        #expect(task.completed == false)
    }

    @Test func testCompletedCountCalculation() async throws {
        let tasks = [
            TaskItem(title: "Task 1", completed: true),
            TaskItem(title: "Task 2", completed: false),
            TaskItem(title: "Task 3", completed: true),
            TaskItem(title: "Task 4", completed: false)
        ]

        let completedCount = tasks.filter { $0.completed }.count
        #expect(completedCount == 2)

        let percentage = Int((Double(completedCount) / Double(tasks.count)) * 100)
        #expect(percentage == 50)
    }

    @Test func testAllCompletedPercentage() async throws {
        let tasks = [
            TaskItem(title: "Task 1", completed: true),
            TaskItem(title: "Task 2", completed: true),
            TaskItem(title: "Task 3", completed: true),
            TaskItem(title: "Task 4", completed: true)
        ]

        let completedCount = tasks.filter { $0.completed }.count
        #expect(completedCount == 4)

        let percentage = Int((Double(completedCount) / Double(tasks.count)) * 100)
        #expect(percentage == 100)
    }

    @Test func testResetTasks() async throws {
        var tasks = [
            TaskItem(title: "Task 1", completed: true),
            TaskItem(title: "Task 2", completed: true)
        ]

        for index in tasks.indices {
            tasks[index].completed = false
        }

        #expect(tasks.allSatisfy { !$0.completed })
    }

    @Test func testPriorityValues() async throws {
        #expect(Priority.high.rawValue == "High")
        #expect(Priority.medium.rawValue == "Medium")
        #expect(Priority.low.rawValue == "Low")
    }

    @Test func testCategoryIcons() async throws {
        #expect(TaskCategory.health.iconName == "heart.fill")
        #expect(TaskCategory.study.iconName == "book.fill")
        #expect(TaskCategory.personal.iconName == "person.fill")
        #expect(TaskCategory.work.iconName == "briefcase.fill")
    }
}
