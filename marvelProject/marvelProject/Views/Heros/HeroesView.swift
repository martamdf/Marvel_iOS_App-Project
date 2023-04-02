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
            Text("Marvel Heroes")
                .bold()
                .font(.title)
            ScrollView{
                if let heroes = viewModel.heroes{
                    ForEach(heroes) { hero in
                        NavigationLink {
                            HeroDetailView(viewModel: SeriesViewModel(hero: hero))
                        } label: {
                            HeroRowView(hero: hero)
                        }
                    }
                    .frame(height: 328)
                }
            }
            .listRowSeparator(.hidden)
            .id(0)
        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesView(viewModel: HeroViewModel(testing: true))
    }
}
