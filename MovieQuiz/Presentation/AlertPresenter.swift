import Foundation
import UIKit

protocol AlertPresenterProtocol {
    func showAlert(alertModel: AlertModel) -> UIAlertController
}

class AlertPresenter: AlertPresenterProtocol {
    
    func showAlert(alertModel: AlertModel) -> UIAlertController {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: alertModel.buttonText,
            style: .default) { _ in
                alertModel.completion?()
            }
        
        alert.addAction(action)
        return alert
    }
}
