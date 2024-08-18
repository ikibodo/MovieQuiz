//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by N L on 16.8.24..
//

import Foundation
import UIKit


protocol AlertPresenterDelegate: AnyObject {
    var currentQuestionIndex: Int { get set }
    var correctAnswers: Int { get set }
   // var questionFactory: QuestionFactoryProtocol { get set }
}


class ResultAlertPresenter: UIAlertController {
    
    weak var delegate: AlertPresenterDelegate?
    
    func alert(alertModel: AlertModel, questionFactory: QuestionFactoryProtocol) -> UIAlertController {
        
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            delegate?.currentQuestionIndex = 0
            delegate?.correctAnswers = 0
            
           // delegate?.
            questionFactory.requestNextQuestion()
        }
        
        alert.addAction(action)
        
        return alert
        
    }
    
}

