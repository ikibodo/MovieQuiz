//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by N L on 14.8.24..
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
