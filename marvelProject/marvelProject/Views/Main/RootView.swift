//
//  RootView.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootviewModel: RootViewModel
    var body: some View { // caja de estados
        switch rootviewModel.status{
        case .none:
            HeroesView(viewModel: HeroViewModel())
            Text("Nada")
        case .loaded:
            Text("Cargado")
            //PrincipalView()
        case .error(error: let errorString):
            Text("Error")
            //ErrorView(error: errorString)
        case .loading:
            Text("Cargando")
            //LoaderView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(RootViewModel())
    }
}
