import Foundation

protocol StatisticServiceProtocol {
    var gamesCount: Int { get } //количество завершенных игр
    var bestGame: GameResult { get } //лучший результат (результат лучшей попытки) с датой
    var totalAccuracy: Double { get } // средняя точность правильных ответов за все игры в процентах

    
    // метод для сохранения текущего результата игры - в него можно передавать объект типа GameResult
    func store(correct count: Int, total amount: Int )
    
}

