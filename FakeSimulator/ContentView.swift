//
//  ContentView.swift
//  FakeSimulator
//
//  Created by Chris Eidhof on 05.10.22.
//

import SwiftUI

struct Device {
    var size: CGSize
    var bezelWidth: CGFloat = 10
    var topSafeAreaHeight: CGFloat = 47
    var bottomSafeAreaHeight: CGFloat = 34

    static let iPhone13 = Device(size: .init(width: 390, height: 844))
}

struct PhoneModifier: ViewModifier {
    var device: Device
    var colorScheme: ColorScheme = .light

    var deviceShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 40, style: .continuous)
    }

    var topBar: some View {
        HStack {
            Text(Date(), format: Date.FormatStyle(date: .none, time: .shortened))
                .fontWeight(.medium)
                .padding(.leading, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
            Rectangle()
                .frame(width: 160)
            HStack {
                Image(systemName: "wifi")
                Image(systemName: "battery.75")
            }
            .padding(.trailing, 24)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top, spacing: 0) {
                topBar
                    .frame(height: device.topSafeAreaHeight)
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Color.clear
                    .frame(height: device.bottomSafeAreaHeight)
            }
            .frame(width: device.size.width, height: device.size.height)
            .background(.background)
            .clipShape(deviceShape)
            .overlay {
                deviceShape
                    .inset(by: -device.bezelWidth/2)
                    .stroke(.black, lineWidth: device.bezelWidth)
            }
            .padding(device.bezelWidth)
            .colorScheme(colorScheme)
    }
}


struct ContentView: View {
    var body: some View {
        Color.yellow
        .modifier(PhoneModifier(device: .iPhone13))
        .padding()
        .background(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
