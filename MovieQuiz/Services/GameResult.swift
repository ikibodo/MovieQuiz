import Foundation

// записываем результат одной игры и сохраняем в UserDefaults.
struct GameResult {
    let correct: Int // количество правильных ответов
    let total: Int // количество вопросов квиза
    let date: Date // дата завершения раунда
    
    // метод сравнения по количеству верных ответов 
    func isBetterThan(_ another: GameResult) -> Bool {
            correct > another.correct
        }
}

