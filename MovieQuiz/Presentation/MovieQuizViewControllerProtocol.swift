//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by N L on 12.9.24..
//

import Foundation
import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func highlightImageBorder(isCorrectAnswer: Bool)
    func changeStateButton(isEnable: Bool)
    
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    func showNetworkError(message: String)
}
