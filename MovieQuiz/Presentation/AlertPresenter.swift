import Foundation
import UIKit


protocol AlertPresenterDelegate: AnyObject {
    var currentQuestionIndex: Int { get set }
    var correctAnswers: Int { get set }
}

protocol AlertPresenterProtocol {
    func alert(alertModel: AlertModel, questionFactory: QuestionFactoryProtocol) -> UIAlertController
}

class ResultAlertPresenter: AlertPresenterProtocol {
    
    weak var delegate: AlertPresenterDelegate?
    
    func alert(alertModel: AlertModel, questionFactory: QuestionFactoryProtocol) -> UIAlertController  {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            delegate?.currentQuestionIndex = .zero
            delegate?.correctAnswers = .zero
            
            questionFactory.requestNextQuestion()
    }
        
        alert.addAction(action)
        
        return alert
    }
}
