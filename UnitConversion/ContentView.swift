import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit: String = "Meters"
    @State private var outputUnit: String = "Kilometers"
    @FocusState private var isFocused: Bool
    
    let units = ["Feet", "Kilometers", "Meters", "Miles", "Yards"]
    
    var result: String {
        //We will centralize everything by converting everything to meter, THEN outputting it
        let inputToMetersMultiplier: Double
        let metersToOutputMultiplier: Double
        
        switch inputUnit {
        case "Feet":
            inputToMetersMultiplier = 0.3048 //whatever the input is * this number = input in meter
        case "Kilometers":
            inputToMetersMultiplier = 1000
        case "Miles":
            inputToMetersMultiplier = 1609.34
        case "Yards":
            inputToMetersMultiplier = 0.9144
        default:
            inputToMetersMultiplier = 1.0
        }
        
        
        switch outputUnit {
        case "Feet":
            metersToOutputMultiplier = 3.28084 //if we have 1 meter, it is equal to this much feet
        case "Kilometers":
            metersToOutputMultiplier = 0.001
        case "Miles":
            metersToOutputMultiplier = 0.000621371
        case "Yards":
            metersToOutputMultiplier = 1.09361
        default:
            metersToOutputMultiplier = 1.0
        }
        
        let inputInMeters = input * inputToMetersMultiplier
        let output = inputInMeters * metersToOutputMultiplier
        
        let outputString = output.formatted()
        return "\(outputString) \(outputUnit.lowercased())"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                } header: {
                    Text("Enter input here")
                }
                
            
                
                Section {
                    Picker("Enter input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Enter output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) { element in
                            Text(element)
                        }
                    }
                }
                
                
                
                Section {
                    Text(result)
                } header: {
                    Text("Output")
                }
                
                
            }
            .navigationTitle("Unit Conversion Tool")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        isFocused = false
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
