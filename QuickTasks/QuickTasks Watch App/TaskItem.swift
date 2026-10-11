import Foundation
import SwiftUI

// MARK: - Priority (Part G - Option D)
enum Priority: String, CaseIterable, Codable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
    
    var color: Color {
        switch self {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .blue
        }
    }
}

// MARK: - TaskCategory (Part G - Option C)
enum TaskCategory: String, CaseIterable, Codable {
    case health = "Health"
    case study = "Study"
    case personal = "Personal"
    case work = "Work"
    
    var iconName: String {
        switch self {
        case .health:
            return "heart.fill"
        case .study:
            return "book.fill"
        case .personal:
            return "person.fill"
        case .work:
            return "briefcase.fill"
        }
    }
}

// MARK: - TaskItem Model (Part A)
struct TaskItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var completed: Bool
    var category: TaskCategory
    var priority: Priority

    init(
        id: UUID = UUID(),
        title: String,
        completed: Bool = false,
        category: TaskCategory = .personal,
        priority: Priority = .medium
    ) {
        self.id = id
        self.title = title
        self.completed = completed
        self.category = category
        self.priority = priority
    }
}
