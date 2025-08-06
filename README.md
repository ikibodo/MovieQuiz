[Читать на русском](./README.ru.md)

# MovieQuiz — Technical Specification

## Links

- [Figma Design](https://www.figma.com/file/l0IMG3Eys35fUrbvArtwsR/YP-Quiz?node-id=34%3A243)
- [IMDb API](https://imdb-api.com/api#Top250Movies-header)
- [Font Package](https://code.s3.yandex.net/Mobile/iOS/Fonts/MovieQuizFonts.zip)

## Purpose and Goals

MovieQuiz is a single-screen iOS game that challenges users with questions about movies from IMDb’s **Top 250** and **Most Popular Movies** lists.  
The goal of each round is to answer all **10** questions correctly.

## App Overview

- The game presents a movie poster and asks, for example, “Is this film’s rating higher than 6 on IMDb?”  
- The user answers with **Yes** or **No**; only one choice is correct.  
- After each tap the poster border turns green (correct) or red (incorrect), and the next question loads automatically after one second.  
- When all 10 questions are answered, a results alert displays:  
  - Score for the current round (correct answers out of 10)  
  - Total quizzes played in this session  
  - Best score with date and time  
  - Average accuracy in percent  
- The alert includes a **Play Again** button to start a new round.  
- If data cannot be loaded, an error alert appears with a **Retry** option.

---

## Functional Requirements

- Splash screen on app launch.  
- Question screen with poster, question text, and **Yes / No** buttons.  
- Automatic transition to the next question one second after an answer.  
- Results alert after every 10 questions with **full statistics** and a **Play Again** button.  
- Error alert with a **Retry** button if networking fails.

---

## Technical Requirements

1. Supports iPhone devices running **iOS 15**; portrait orientation only.  
2. Adaptive layout for iPhone screens starting with the iPhone X family (layouts for iPhone SE and iPad are not provided).  
3. Every screen matches the Figma design exactly: correct fonts and sizes, precise element positions, button dimensions, and spacing.
