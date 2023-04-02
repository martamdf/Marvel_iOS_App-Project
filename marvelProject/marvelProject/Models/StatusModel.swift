//
//  StatusModel.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import Foundation

// estados de la navegación principal
enum Status {
    case none, loading, error(error: String)//loaded, 
}
