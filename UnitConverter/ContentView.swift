//
//  ContentView.swift
//  UnitConverter
//
//  Created by Jeff Fischer on 7/14/22.
//

import SwiftUI

enum Unit: String {
    case inches = "Inches"
    case feet = "Feet"
    case yards = "Yards"
    case miles = "Miles"
    case meters = "Meters"
    case kilometers = "Kilometers"
    case fahrenheit = "Fahrenheit"
    case celcius = "Celcius"
    case kelvin = "Kelvin"
    case ounces = "Ounces"
    case pints = "Pints"
    case gallons = "Gallons"
    case liters = "Liters"
}

enum UnitType: String {
    case temperature = "Temperature"
    case linear = "Linear"
    case liquid = "Liquid"
}

struct ContentView: View {
    @State var linearValues: [Unit: Double] = [
        .inches: 0.0,
        .feet: 0.0,
        .yards: 0.0,
        .miles: 0.0,
        .meters: 0.0,
        .kilometers: 0.0
    ]

    @State var temperatureValues: [Unit: Double] = [
        .fahrenheit: 0.0,
        .celcius: 0.0,
        .kelvin: 0.0
    ]

    @State var liquidValues: [Unit: Double] = [
        .ounces: 0.0,
        .pints: 0.0,
        .gallons: 0.0,
        .liters: 0.0
    ]

    let linearUnits: [Unit] = [.inches, .feet, .yards, .miles, .meters, .kilometers]
    let temperatureUnits: [Unit] = [.fahrenheit, .celcius, .kelvin]
    let liquidUnits: [Unit] = [.ounces, .pints, .gallons, .liters]

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Linear")) {
                    ForEach(linearUnits, id: \.self) { unit in
                        SectionRow(unitValue: binding(for: unit, type: .linear), unit: unit, calculate: calculate, formatter: formatter)
                    }
                }

                Section(header: Text("Temperature")) {
                    ForEach(temperatureUnits, id: \.self) { unit in
                        SectionRow(unitValue: binding(for: unit, type: .temperature), unit: unit, calculate: calculate, formatter: formatter)
                    }
                }

                Section(header: Text("Liquid")) {
                    ForEach(liquidUnits, id: \.self) { unit in
                        SectionRow(unitValue: binding(for: unit, type: .liquid), unit: unit, calculate: calculate, formatter: formatter)
                    }
                }
            }
            .padding(.top)
            .navigationTitle("Unit Converter")
        }
    }

    func binding(for key: Unit, type: UnitType) -> Binding<Double> {
        switch type {
            case .linear:
                return Binding(
                    get: {
                        return linearValues[key] ?? 0.0
                    },
                    set: {
                        linearValues[key] = $0
                    }
                )
            case .temperature:
                return Binding(
                    get: {
                        return temperatureValues[key] ?? 0.0
                    },
                    set: {
                        temperatureValues[key] = $0
                    }
                )
            case .liquid:
                return Binding(
                    get: {
                        return liquidValues[key] ?? 0.0
                    },
                    set: {
                        liquidValues[key] = $0
                    }
                )
        }
    }

    func calculate(for unit: Unit) {
        switch unit {
            case .inches:
                let baseMeasure = Measurement(value: linearValues[.inches]!, unit: UnitLength.inches)
                calculateLinearValues(baseMeasure: baseMeasure)
            case .feet:
                let baseMeasure = Measurement(value: linearValues[.feet]!, unit: UnitLength.feet)
                calculateLinearValues(baseMeasure: baseMeasure)
            case .yards:
                let baseMeasure = Measurement(value: linearValues[.yards]!, unit: UnitLength.yards)
                calculateLinearValues(baseMeasure: baseMeasure)
            case .miles:
                let baseMeasure = Measurement(value: linearValues[.miles]!, unit: UnitLength.miles)
                calculateLinearValues(baseMeasure: baseMeasure)
            case .meters:
                let baseMeasure = Measurement(value: linearValues[.meters]!, unit: UnitLength.meters)
                calculateLinearValues(baseMeasure: baseMeasure)
            case .kilometers:
                let baseMeasure = Measurement(value: linearValues[.kilometers]!, unit: UnitLength.kilometers)
                calculateLinearValues(baseMeasure: baseMeasure)

            case .fahrenheit:
                let baseMeasure = Measurement(value: temperatureValues[.fahrenheit]!, unit: UnitTemperature.fahrenheit)
                calculateTemperatureValues(baseMeasure: baseMeasure)
            case .celcius:
                let baseMeasure = Measurement(value: temperatureValues[.celcius]!, unit: UnitTemperature.celsius)
                calculateTemperatureValues(baseMeasure: baseMeasure)
            case .kelvin:
                let baseMeasure = Measurement(value: temperatureValues[.kelvin]!, unit: UnitTemperature.kelvin)
                calculateTemperatureValues(baseMeasure: baseMeasure)

            case .ounces:
                let baseMeasure = Measurement(value: liquidValues[.ounces]!, unit: UnitVolume.fluidOunces)
                calculateLiquidValues(baseMeasure: baseMeasure)
            case .pints:
                let baseMeasure = Measurement(value: liquidValues[.pints]!, unit: UnitVolume.pints)
                calculateLiquidValues(baseMeasure: baseMeasure)
            case .gallons:
                let baseMeasure = Measurement(value: liquidValues[.gallons]!, unit: UnitVolume.gallons)
                calculateLiquidValues(baseMeasure: baseMeasure)
            case .liters:
                let baseMeasure = Measurement(value: liquidValues[.liters]!, unit: UnitVolume.liters)
                calculateLiquidValues(baseMeasure: baseMeasure)
        }
        print("Setting values based on \(unit.rawValue)")
    }

    func calculateLinearValues(baseMeasure: Measurement<UnitLength>) {
        linearValues[.inches] = baseMeasure.converted(to: UnitLength.inches).value
        linearValues[.feet] = baseMeasure.converted(to: UnitLength.feet).value
        linearValues[.yards] = baseMeasure.converted(to: UnitLength.yards).value
        linearValues[.miles] = baseMeasure.converted(to: UnitLength.miles).value
        linearValues[.meters] = baseMeasure.converted(to: UnitLength.meters).value
        linearValues[.kilometers] = baseMeasure.converted(to: UnitLength.kilometers).value
    }

    func calculateTemperatureValues(baseMeasure: Measurement<UnitTemperature>) {
        temperatureValues[.fahrenheit] = baseMeasure.converted(to: UnitTemperature.fahrenheit).value
        temperatureValues[.celcius] = baseMeasure.converted(to: UnitTemperature.celsius).value
        temperatureValues[.kelvin] = baseMeasure.converted(to: UnitTemperature.kelvin).value
    }

    func calculateLiquidValues(baseMeasure: Measurement<UnitVolume>) {
        liquidValues[.ounces] = baseMeasure.converted(to: UnitVolume.fluidOunces).value
        liquidValues[.pints] = baseMeasure.converted(to: UnitVolume.pints).value
        liquidValues[.gallons] = baseMeasure.converted(to: UnitVolume.gallons).value
        liquidValues[.liters] = baseMeasure.converted(to: UnitVolume.liters).value
   }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
