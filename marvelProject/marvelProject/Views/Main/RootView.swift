//
//  RootView.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootviewModel: RootViewModel
    var body: some View { 
        // Caja de estados
        switch rootviewModel.status{
        case .none:
            HeroesView(viewModel: HeroViewModel())
        case .error(error: let errorString):
            ErrorView(error: errorString)
        case .loading:
            LoadingView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(RootViewModel())
    }
}
