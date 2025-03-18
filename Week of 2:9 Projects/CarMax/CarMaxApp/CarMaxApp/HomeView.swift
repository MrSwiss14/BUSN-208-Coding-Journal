//
//  ContentView.swift
//  CarMaxApp
//
//  Created by Laudeman, Luke D on 2/13/25.
//

import SwiftUI

struct HomeView: View {
    
    //here's where I'll define the state var's
    @State private var currentPage: Pages = .home //will be used to track the current page and I set it do the default page: home
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
