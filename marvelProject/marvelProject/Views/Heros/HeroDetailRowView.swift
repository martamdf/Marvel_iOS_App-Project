//
//  HeroDetailRowView.swift
//  marvelProject
//
//  Created by Marta Maquedano on 31/3/23.
//

import SwiftUI

struct HeroDetailRowView: View {
    var serie: SerieResult
    var screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: serie.thumbnail.path+"."+serie.thumbnail.thumbnailExtension)) { Image in
                    Image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 280)
                    
                } placeholder: {
                    ProgressView()
                        .position(x: 140, y: 140)
                        .aspectRatio(contentMode: .fill)
                }
                .id(0)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            Text(serie.title)
                .font(.title).bold()
                .foregroundColor(Color.black)
                .padding(8)
                .id(1)
            
            if let description = serie.description {
                Text(description)
                    .foregroundColor(.black)
                    .padding(8)
                    .id(2)
                
            }else{
                Text("Sorry, not available description! :(")
                    
                    .foregroundColor(.black)
                    .padding(8)
                    .id(2)
            }
        }
        .frame(maxWidth: screenWidth - 72)
        .padding([.top, .bottom], 16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(radius: 10, x:2, y:5)
    }
}

struct HeroDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetailRowView(serie: SerieResult(id: 1, title: "Dark Avengers (2012 - 2013)", description: "Most of the Marvel Universe has given up on career super villains like Juggernaut, Moonstone and Crossbones, but criminal-turned-Avenger Luke Cage believes everybody deserves a second chance. Can the former Power Man turn this crew around?", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/4/40/544937e49fe42", thumbnailExtension: "jpg")))
    }
}
