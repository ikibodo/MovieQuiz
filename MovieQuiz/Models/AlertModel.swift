//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by N L on 16.8.24..
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    var completion: (() -> Void)?
}
