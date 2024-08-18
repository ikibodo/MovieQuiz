
import Foundation

final class StatisticService {
    
    private let storage: UserDefaults = .standard
    
    private enum Keys: String {
        case correct
        case bestGame
        case gamesCount
        case correctAnswers
        case totalAccuracy
    }
}


extension StatisticService: StatisticServiceProtocol {
    
    var totalAccuracy: Double {
        get {
            Double((correctAnswers) / ( 10 * gamesCount ) * 100)
        }
        set {
            storage.set(newValue, forKey: Keys.totalAccuracy.rawValue)
        }
    }
    
    var gamesCount: Int {
        get {
            // Добавьте чтение значения из UserDefaults - storage.integer(forKey: "gamesCount") or
            storage.integer(forKey: "gamesCount")
        }
        set {
            // Добавьте запись значения newValue из UserDefaults - storage.set(newValue, forKey: "gamesCount") or
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var correctAnswers: Int {
        get {
            storage.integer(forKey: "correctAnswers")
        }
        set {
            storage.set(newValue, forKey: Keys.correctAnswers.rawValue)
        }
    }
    
    
    var bestGame: GameResult {
        get {
            let date = UserDefaults.standard.object(forKey: "bestGame.date") as? Date ?? Date()
    
            return GameResult(
                correct: storage.integer(forKey: "GameResult.correct"),
                total: storage.integer(forKey: "GameResult.total"),
                date: date)
        }
        set {
            // Добавьте запись значений каждого поля из newValue из UserDefaults
            storage.set(newValue, forKey: "GameResult.correct")
            storage.set(newValue, forKey: "GameResult.total")
            storage.set(Date(), forKey: "bestGame.date")
            
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        <#code#>
    }
    
}

