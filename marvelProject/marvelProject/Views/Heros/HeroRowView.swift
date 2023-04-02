//
//  HeroRowView.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import SwiftUI

struct HeroRowView: View {
    var hero: Hero
    var screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack{
            ZStack (alignment: .bottomLeading){
                
                //Imagen héroe
                AsyncImage(url: URL(string: hero.thumbnail.path+"."+hero.thumbnail.thumbnailExtension)) { Image in
                    Image
                        .resizable()
                        .frame(width: 320, height: 320)
                        .cornerRadius(16)
                        .padding([.leading, .trailing],16)
                        .padding(.bottom, 8)
                    
                } placeholder: {
                    ProgressView()
                        .position(x: 160, y: 160)
                        .aspectRatio(contentMode: .fill)
                    
                }
                
                // Filtro
                Image(decorative: "")
                    .resizable()
                    .frame(width: 320, height: 320)
                    .background(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(16)
                    .padding([.leading, .trailing],16)
                    .padding(.bottom, 8)
                    .opacity(0.2)
                
                ZStack{
                    // Filtro Pequeño para alojar el Nombre
                    Image(decorative: "")
                        .resizable()
                        .frame(width: 320, height: 120)
                        .background(.black)
                        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                        .padding([.leading, .trailing],16)
                        .padding(.bottom, 8)
                        .opacity(0.5)

                    VStack{
                        Text(hero.name)
                            .foregroundColor(.white)
                            .bold()
                            .font(.title)
                            .padding(.init(top: 0, leading: 8, bottom: 8, trailing: 8))
                            .frame(width: 320, height: 64)
                            .aspectRatio(contentMode: .fit)
                            .scaledToFill()
        
                        Label("Series disponibles: " + String(hero.series.available), systemImage: "menucard")
                            .foregroundColor(.white)
                            .bold()
                            .font(.callout)
                            .padding(.init(top: 0, leading: 8, bottom: 12, trailing: 8))
                            .frame(width: 320, height: 24)
                            .aspectRatio(contentMode: .fit)
                            .scaledToFill()
                        
                    }
                    .padding(.init(top: 0, leading: 0, bottom: 16, trailing: 0))
                    .frame(width: 320, height: 110)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(radius: 3, x:2, y:5)
        }
    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: Hero(id: 1, name: "A-Bomb (HAS)", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ", modified: "12/12/2022", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), series: Series(available: 1)))
    }
}


// Extensión para conseguir aplicar el corner radius a esquinas concretas.
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
