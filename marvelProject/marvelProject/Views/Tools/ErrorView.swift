//
//  ErrorView.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var viewModel: RootViewModel
    private var textError:String
    
    init(error:String){
        self.textError = error
    }
    
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 100, height: 100)
                .padding()
                .id(0)//para testing
            
            Text("\(textError)")
                .foregroundColor(.red)
                .font(.title)
                .id(1)//para testing
            
            Spacer()
            Button("Volver") {
                self.viewModel.status = .none
            }
            .frame(width: 200, height: 50)
            .background(.orange)
            .font(.title2)
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 10.0, x:20, y: 10)
            .id(2) //para testing
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Test")
    }
}
