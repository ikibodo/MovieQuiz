import Foundation
import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    
   // var currentQuestionIndex = 0
    var correctAnswers = 0
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let presenter = MovieQuizPresenter()
    
 //   private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    private var alertModel: AlertModel?
    private var alertPresenter: AlertPresenterProtocol?
    private var statisticService: StatisticServiceProtocol = StatisticService()
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        statisticService = StatisticService()
        alertPresenter = AlertPresenter()
        showLoadingIndicator()
        questionFactory?.loadData()
        
    }
    
    // MARK: - QuestionFactoryDelegate
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = presenter.convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    func didLoadDataFromServer() {
        hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        showNetworkError(message: error.localizedDescription)
    }
    
    
    // MARK: - Actions
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    // MARK: - Private functions
    
    private func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    private func showNetworkError(message: String) {
        hideLoadingIndicator()
        let alertModel = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать ещё раз") { [weak self] in
                guard let self = self else {return}
            self.presenter.resetQuestionIndex()
            self.correctAnswers = .zero
            self.questionFactory?.loadData()
            self.questionFactory?.requestNextQuestion()
        }
        guard let alert = alertPresenter?.showAlert(alertModel: alertModel) else { return }
        self.present(alert, animated: true, completion: nil)
    }
    /* перенесен в презентер - надо удалить тут
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        return questionStep
    }*/
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        changeStateButton(isEnable: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.showNextQuestionOrResults()
            changeStateButton(isEnable: true)
        }
    }
    
    private func changeStateButton(isEnable: Bool) {
        noButton.isEnabled = isEnable
        yesButton.isEnabled = isEnable
    }
    
    private func showNextQuestionOrResults() {
        imageView.layer.borderWidth = .zero
        
     // было   if currentQuestionIndex == questionsAmount - 1 
            if presenter.isLastQuestion(){
            statisticService.store(correct: correctAnswers, total: presenter.questionsAmount)
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: "Ваш результат: \(correctAnswers)/10 \n" +
                "Количество сыгранных квизов: \(statisticService.gamesCount) \n" +
                "Рекорд: \(statisticService.bestGame.correct)/\(statisticService.bestGame.total) (\(statisticService.bestGame.date.dateTimeString))  \n" +
                "Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%",
                buttonText: "Сыграть ещё раз")
            
            // currentQuestionIndex = .zero
            self.presenter.resetQuestionIndex()
            self.correctAnswers = .zero
            
            show(quiz: viewModel)
            
        } else {
            //currentQuestionIndex += 1
            presenter.switchToNextQuestion()
            questionFactory?.requestNextQuestion()
        }
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        
        let alertModel = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: result.buttonText) { [weak self] in
                guard let self = self else {return}
                self.questionFactory?.requestNextQuestion()
            }
        
        guard let alert = alertPresenter?.showAlert(alertModel: alertModel) else { return }
        self.present(alert, animated: true, completion: nil)
    }
}
