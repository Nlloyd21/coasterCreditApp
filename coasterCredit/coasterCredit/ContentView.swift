import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Coaster.name) private var coasters: [Coaster]
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                if coasters.isEmpty {
                    ContentUnavailableView("No Credits Yet",
                                           systemImage: "roller.coaster",
                                           description: Text("Tap the plus button to log your first ride."))
                } else {
                    ForEach(coasters) { coaster in
                        VStack(alignment: .leading) {
                            Text(coaster.name)
                                .font(.headline)
                            Text(coaster.park)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: deleteCoasters)
                }
            }
            .navigationTitle("Coaster Credits")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showingAddSheet = true }) {
                        Label("Add Coaster", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddCoasterSheet()
            }
        }
    }

    private func deleteCoasters(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(coasters[index])
            }
        }
    }
}

struct AddCoasterSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var park = ""
    @State private var location = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Coaster Name", text: $name)
                TextField("Park", text: $park)
                TextField("Location", text: $location)
            }
            .navigationTitle("New Credit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newCoaster = Coaster(name: name, park: park, location: location)
                        modelContext.insert(newCoaster)
                        dismiss()
                    }
                    .disabled(name.isEmpty || park.isEmpty)
                }
            }
        }
    }
}
