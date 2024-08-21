import Foundation

final class StatisticService  {
    
    private let storage = UserDefaults.standard
    
    private enum Keys: String {
        case correct
        case total
        case bestGameDate
        case gamesCount
        case totalAccuracy
        case totalCorrectAnswers
        case totalQuestions
    }
}

extension StatisticService: StatisticServiceProtocol {
    func store(correct count: Int, total amount: Int) {
        
        let result = GameResult(correct: count, total: amount, date: Date())

        gamesCount += 1
        totalCorrectAnswers += count
        totalQuestions += amount

        if result.isBetterThan(bestGame) {
          bestGame = result
        }
        
    }
   
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.correct.rawValue)
            let total = storage.integer(forKey:  Keys.total.rawValue)
            let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
    
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.correct.rawValue)
            storage.set(newValue.total, forKey: Keys.total.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        get {
            guard gamesCount != 0 else { return 1 }
            return 100 * Double(totalCorrectAnswers) / Double(totalQuestions)
        }
        set {
            storage.set(newValue, forKey: Keys.totalAccuracy.rawValue)
        }
    }
    
    var totalCorrectAnswers: Int {
        get {
            storage.integer(forKey: Keys.totalCorrectAnswers.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.totalCorrectAnswers.rawValue)
        }
    }

    var totalQuestions: Int {
        get {
            storage.integer(forKey: Keys.totalQuestions.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.totalQuestions.rawValue)
        }
    }
}
