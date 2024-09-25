//
//  Untitled.swift
//  MovieQuiz
//
//  Created by N L on 25.9.24..
//

import Foundation
import XCTest

@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    func showLoadingIndicator() {}
    func hideLoadingIndicator() {}
    func highlightImageBorder(isCorrectAnswer: Bool) {}
    func changeStateButton(isEnable: Bool) {}
    func show(quiz step: MovieQuiz.QuizStepViewModel) {}
    func show(quiz result: MovieQuiz.QuizResultsViewModel) {}
    func showNetworkError(message: String) {}
}
