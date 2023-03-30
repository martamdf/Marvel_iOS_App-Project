//
//  HeroRowView.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import SwiftUI

struct HeroRowView: View {
    var hero: Hero
    
    var body: some View {
        ZStack{
            //Imagen héroe
            AsyncImage(url: URL(string: hero.thumbnail.path+"."+hero.thumbnail.thumbnailExtension)) { Image in
                Image
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .cornerRadius(16)
                    .padding([.leading, .trailing],16)
                
            } placeholder: {
                Text("Cargando foto...")
            }
            
            // Filtro
            Image(decorative: "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.black)
                .cornerRadius(16)
                .padding([.leading, .trailing],16)
                .opacity(0.3)
                

            
            Text("Linterna Verde")
                .foregroundColor(.white)
                .bold()
                .font(.title)
                .padding(.init(top: 360, leading: 10, bottom: 100, trailing: 100))
                .aspectRatio(contentMode: .fit)
                

        }
        .shadow(radius: 3, x:2, y:5)
        

    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: Hero(id: 1, name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg")))
    }
}
