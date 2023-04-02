//
//  LoadingView.swift
//  marvelProject
//
//  Created by Marta Maquedano on 2/4/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var animationAmount = 0.5
    @State private var animate = false
    
    var body: some View {
        VStack {
            Text("Cargando...")
                .font(.title)
                .foregroundColor(.red)
                .padding(.top, 100)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
