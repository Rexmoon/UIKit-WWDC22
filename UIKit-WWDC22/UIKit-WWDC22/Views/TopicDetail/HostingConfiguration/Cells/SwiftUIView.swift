//
//  SwiftUIView.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/28/23.
//

import SwiftUI

struct SwiftUIView: View {
    
    private let hostingConfiguration: HostingConfiguration
    
    init(hostingConfiguration: HostingConfiguration) {
        self.hostingConfiguration = hostingConfiguration
    }
    
    var body: some View {
        HStack() {
            Image(uiImage: hostingConfiguration.type.image!)
                .renderingMode(.template)
                .foregroundColor(.blue)
            
            Text("I am a SWIFTUI view \(hostingConfiguration.text) \(hostingConfiguration.type.rawValue)")
        }
    }
}

#Preview {
    SwiftUIView(hostingConfiguration: HostingConfiguration(text: "Cell",
                                                           type: .forTableView))
}
