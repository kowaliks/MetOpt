# Integracja metody LARS z pakietem ROI i analiza jej wydajności
## Metody optymalizacji
autorzy: Kosma Grochowski, Szymon Kowalik

## Instrukcja uruchomienia
1. W celu rejestracji metody LARS jako solvera ROI należy jednokrotnie uruchomić skrypt `register_lars.R`.
2. W celu rejestracji w środowisku R funkcji pomocniczych należy uruchomić skrypt `qp_lasso.R`.
3. W celu uruchomienia obliczeń dla różnych zbiorów danych należy uruchomić jeden z trzech opisanych poniżej skryptów. Możliwa jest modyfikacja parametru `lambda` wewnątrz skryptu.
   - `solve_diabetes.R` - wykonuje obliczenia dla zbioru danych diabetyków
   - `solve_generated.R` - wykonuje obliczenia dla sztucznie wygenerowanego zbioru danych
   - `solve_song.R` - wykonuje obliczenia dla zbioru danych *Million Song Dataset*; skrypt wymaga, aby w katalogu roboczym istniał folder `data`, a w nim plik `YearPredictionMSD.txt` - do pobrania z https://archive.ics.uci.edu/ml/machine-learning-databases/00203/
4. Po zakończeniu działania skryptu w środowisku R będą dostępne następujące zmienne:
   - `lars_solved` - obiekt wynikowy funkcji `ROI_solve()` z wykorzystaniem solvera LARS
   - `qpoases_solved` - obiekt wynikowy funkcji `ROI_solve()` z wykorzystaniem solvera qpOASES
   - `lars_duration` - czas wykonania obliczeń solvera LARS
   - `qpoases_duration` - czas wykonania obliczeń solvera qpOASES