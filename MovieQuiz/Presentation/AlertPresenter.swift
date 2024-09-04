import Foundation
import UIKit


protocol AlertPresenterDelegate: AnyObject {
}

protocol AlertPresenterProtocol {
    func alert(alertModel: AlertModel) -> UIAlertController
}

class ResultAlertPresenter: AlertPresenterProtocol {
    
    weak var delegate: AlertPresenterDelegate?
    
    func alert(alertModel: AlertModel) -> UIAlertController  {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { [weak self] _ in
            guard let self = self else { return }
        }
        alert.addAction(action)
        return alert
    }
}
