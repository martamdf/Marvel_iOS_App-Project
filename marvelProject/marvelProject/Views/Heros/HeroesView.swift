//
//  HerosView.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import SwiftUI

struct HeroesView: View {
    @StateObject var viewModel : HeroViewModel
    @State private var filter = ""
    
    var body: some View {
        NavigationStack{
            List{
                if let heroes = viewModel.heroes{
                    ForEach(heroes) { hero in
                        NavigationLink {
                            Text("Detalle view")
                            //HeroesDetailView(hero: hero)
                        } label: {
                            HeroRowView(hero: hero)
                        }
                    }
                    .frame(height: 300)
                }
            }
            
        }
        // Barra de búsqueda
        .searchable(text: $filter,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Buscar heroe...")
        .onChange(of: filter) { newValue in
            print("busqueda: \(newValue)")
            viewModel.getHeros(filtro: newValue)
        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesView(viewModel: HeroViewModel(testing: true))
    }
}
