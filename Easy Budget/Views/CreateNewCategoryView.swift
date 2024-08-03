import SwiftUI
import SwiftData

struct CreateNewCategoryView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    @Query var categories: [Category]
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @State private var categoryName = ""
    @State private var categoryColor = ""
    @State private var categoryIcon = ""
    @State private var colorPickerColor = Color.blue
    
    var body: some View {
        NavigationStack {
            Form {
                Section("main settigns") {
                    TextField("Category name", text: $categoryName)
                    ColorPicker("Category color", selection: $colorPickerColor)
                        .onChange(of: colorPickerColor, initial: true) { oldValue, newValue in
                            categoryColor = newValue.toHexString()
                        }
                }
                Section("emoji"){
                    emojiPickerView(selectedEmoji: $categoryIcon)
                }
            }
            .navigationTitle("New category")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        saveCategory()
                    }
                    .disabled(categoryName.isEmpty)
                }
            }
        }
    }
    
    func saveCategory() {
        let newCategory = Category(
            name: categoryName,
            color: categoryColor,
            icon: categoryIcon
        )
        
        modelContext.insert(newCategory)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            print("Unresolved error: \(nsError), \(nsError.userInfo)")
        }
    }
}

struct emojiPickerView: View {
    private let categories: [String: [String]] = [
        "Food": ["🍎", "🍔", "🍣", "🍕", "🍩", "🍰", "🥗", "🍜"],
        "Transportation": ["🚗", "🛵", "🚲", "✈️", "🚢", "🚂", "🛳️"],
        "Entertainment": ["🎬", "🎮", "🎨", "🎤", "🎸", "🎧", "🎪"],
        "Shopping": ["🛒", "👗", "👠", "💍", "🛍️", "📚", "🎁"],
        "Health": ["🏥", "💊", "🩺", "🚴‍♂️", "🧘‍♀️", "🏋️‍♂️", "🍎"],
        "Others": ["💡", "🧩", "🔧", "🖼️", "🎉", "📅", "📈"]
    ]
    
    @Binding var selectedEmoji: String
    @State private var selectedCategory: String = "Food"
    
    var body: some View {
        VStack {
            Picker("Icon category", selection: $selectedCategory) {
                ForEach(categories.keys.sorted(), id: \.self) { category in
                    Text(category).tag(category)
                }
            }
            .pickerStyle(.menu)
            
            Divider()
            
            let emojis = categories[selectedCategory] ?? []
            let columns = [GridItem(.adaptive(minimum: 60))]
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .font(.system(size: 24))
                        .frame(width: 30, height: 30)
                        .background(selectedEmoji == emoji ? Color.blue.opacity(0.3) : Color.clear)
                        .clipShape(Circle())
                        .onTapGesture {
                            selectedEmoji = emoji
                        }
                }
            }
            .padding()
            
        }
    }
}

#Preview {
    CreateNewCategoryView()
}

