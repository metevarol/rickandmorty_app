import SwiftUI
import Combine

struct LocationListView: View {
    @ObservedObject var viewModel: LocationListViewModel
    @ObservedObject var viewModel2: CharacterListViewModel
    
    @Binding var selectedLocation: Location?
    
    @State private var cancellables = Set<AnyCancellable>() // ***
    
    let maxLocations = 20
    var check = 0
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                Spacer()
                ForEach(viewModel.locations.prefix(maxLocations)) { location in
                    Button(action: {
                        selectedLocation = location
                        viewModel2.updateCharacters(for: selectedLocation)
                        
                    }) {
                        
                        KeywordBubbleDefaultPadding(keyword: location.name, isSelected: selectedLocation == location)
                    }.onAppear {
                        viewModel2.$noCharacters
                            .sink { noCharacters in
                                if noCharacters {
                                    viewModel2.clearCharacters()
                                }
                            }
                            .store(in: &cancellables)
                    }
                    
                }
            }
            
            
            
        }.onAppear(perform: {
            viewModel.fetchLocations()
            
        })
        .onFirstAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let firstLocation = viewModel.locations.first {
                    selectedLocation = firstLocation
                    viewModel2.updateCharacters(for: selectedLocation)
                }
            }
        })
    }
}

struct RoundedRectangleView: View {
    @State var label: String
    var location: Location
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("green1"))
                .frame(width: 100, height: 50)
            Text(label)
                .foregroundColor(.blue)
        }
    }
}

struct KeywordBubbleDefaultPadding: View {
    let keyword: String
    var isSelected: Bool
    
    var body: some View {
        Text(keyword)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(isSelected ? .white : Color("darkblue1"))
            .padding()
            .frame(height: 40)
            .background(isSelected ? Color("darkblue1") : Color("green1"), in: Capsule())

    }
}

struct OnFirstAppearModifier: ViewModifier {
    let perform:() -> Void
    @State private var firstTime: Bool = true
    func body(content: Content) -> some View {
        content
            .onAppear{
                if firstTime{
                    firstTime = false
                    self.perform()
                }
            }
    }
}

extension View {
    func onFirstAppear( perform: @escaping () -> Void ) -> some View {
        return self.modifier(OnFirstAppearModifier(perform: perform))
    }
}

struct LocationListView_Previews: PreviewProvider {
    @State static private var selectedLocation: Location?
    
    static var previews: some View {
        LocationListView(viewModel: LocationListViewModel(),viewModel2: CharacterListViewModel(), selectedLocation: $selectedLocation)
    }
}
