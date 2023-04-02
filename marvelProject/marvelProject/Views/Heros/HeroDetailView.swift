//
//  HeroDetailView.swift
//  marvelProject
//
//  Created by Marta Maquedano on 30/3/23.
//

import SwiftUI

struct HeroDetailView: View {
    @StateObject var viewModel : SeriesViewModel
    var screenWidth = UIScreen.main.bounds.size.width

    var body: some View {
        VStack{
            if let hero = viewModel.hero{
                Text(hero.name)
                    .font(.title)
                    .bold()
                    .id(0)
            }

            ScrollView{
                if let series = viewModel.series{
                    ForEach(series) { serie in
                        HeroDetailRowView(serie: serie)
                    }
                    .padding([.leading, .trailing], 32)
                }
            }
            .id(1)
        }
    }
}

struct HeroDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetailView(viewModel: SeriesViewModel(testing: true, hero: Hero(id: 1, name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), series: Series(available: 1))))
    }
}
