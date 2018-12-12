# Opis
Projekt w języku R mający na celu analizę danych z serwisu Stackoverflow.

# Zadania do zrobienia:
### 1. Opis tabel w każdym forum Stackoverflow
**Marcin:**
  * Badges
  * Comments
  * PostHistory
  * PostLinks

**Tomek**
* Posts
* Tags
* Users
| Reputation     | Kiedy inni użytkownicy głosują (UpVote - dodatni lub DwonVote - ujemny) na twoje posty (pytania i odpowiedzi), generujesz reputację.  Ilość punktów zależy od wielu czynników, ale mniej więcej po przeskalowaniu działa to w sposób  sum(UpVote) + sum(downVote) = Reputation                 |
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| CreationDate   | Data stworzenia użytkownika                                                                                                                                                                                                                                                                    |
| DisplayName    | Nick użytkownika                                                                                                                                                                                                                                                                               |
| LastAccessDate | Kiedy ostatnio był zalogowany                                                                                                                                                                                                                                                                  |
| WebsiteUrl     | Strona internetowa użytkownika                                                                                                                                                                                                                                                                 |
| Location       | Miejsce zamieszkania użytkownika. Zazwyczaj w formie Miasto, Państwo                                                                                                                                                                                                                           |
| AboutMe        | To co użytkownik napisał sam o sobie. Zazwyczaj kilka zdań.                                                                                                                                                                                                                                    |
| Views          | Ilość wyświetleń posta użytkownika (jedno IP może naliczyć się tylko raz w ciągu godziny)                                                                                                                                                                                                      |
| UpVotes        | UpVote powoduje przesuwanie treści "w górę", aby była widoczna dla większej liczby osób.  Zasady:   * Awanse na pytanie dają popisowi reputację +5.   * Awanse na odpowiedź dają replikatorowi reputację +10.   * Możesz głosować 30 razy dziennie w UTC plus 10 razy więcej tylko na pytania. |
| DownVotes      | DownVote przesuwa treść "w dół" strony, więc będzie ją widzieć mniej osób.   Zasady:   * Downvotes usuwa 2 reputacje od właściciela postu.   * Downvotes na odpowiedzi usuwają 1 reputację od ciebie.   * Downvotes na pytania są bezpłatne.   * Możesz głosować 30 razy w ciągu UTC.          |
* Votes

### 2. Sprawdzenie pomysłów na analizę
**Marcin**
  * reputacja w zaleznosci od miejsca zamieszkania (regresja)
  * ego uzytkownika na podstawie opisu
  * w zaleznosci od stazu na forum ile user dostawal upvote
  * badges - jak user szybko zdobywal awans

**Tomek**
  * reputacja w zaleznosci od miejsca zamieszkania (wykres)
  * po jakim czasie pada odpowiedz ktora jest oznaczona ptaszkiem
  * jakie są najbardziej popularne posty na wybranych forach
  
### 3. Ulepszenie funkcji wczytujących dane
Prototypowe wersje funkcji znajdują się *firstLookAtData.R*
