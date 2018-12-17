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

| Nazwa kolumny | Opis |
|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| Id | Id posta |
| PostTypeId | Id typu posta. Rozróżniamy następujące: 1 Question 2 Answer 3 Wiki 4 TagWikiExcerpt 5 TagWiki 6 ModeratorNomination 7 WikiPlaceholder 8 PrivilegeWiki |
| AcceptedAnswerId | Id zaakceptowanej odpowiedzi (z zielonym ptaszkiem). Pole obecne tylko jeżeli PostTypeId = 1. |
| ParentId | Id pytania do którego została napisana odpowiedź. Pole obecne tylko jeżeli PostTypeId = 2. |
| CreationDate | Data napisania posta. |
| Score | Wynik posta, liczba którą widzimy pomiędzy strzałkami w górę i w dół. Zaczyna się od 0. Potem pozostali użytkownicy decydują jak ocenić post. |
| ViewCount | Ilość wyświetleń posta. Pole obecne tylko jeżeli PostTypeId = 1. |
| Body | Treść posta |
| OwnerUserId | Id użytkownika który napisał post. Pole obecne tylko jeżeli użytkownik nie został usunięty. |
| LastEditorUserId | Id użytkownika, który ostatni odpowiadał na post. |
| LastEditDate | Data ostatniej edycji posta. |
| LastActivityDate | Data ostatniej aktywności w poście |
| Title | Tytuł posta. Pole obecne tylko jeżeli PostTypeId = 1. |
| Tags | Tagi posta. Pole obecne tylko jeżeli PostTypeId = 1. |
| AnswerCount | Ilość odpowiedzi do posta/odpowiedzi, czyli takich z PostTypeId = 2. Nie chodzi tutaj o komentarze. Pole obecne tylko dla PostTypeId = 1 |
| CommentCount | Ilość komentarzy do posta. |
| FavoriteCount | Ile użytkowników dodało post do ulubionych. Do ulubionych można dodawać tylko posty, które są PostTypeId = 1 |
* Tags
* Users

| Nazwa kolumny  | Opis
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Reputation     | Kiedy inni użytkownicy głosują (UpVote - dodatni lub DwonVote - ujemny) na twoje posty (pytania i odpowiedzi), generujesz reputację.  Ilość punktów zależy od wielu czynników, ale mniej więcej po przeskalowaniu działa to w sposób:<br>sum(UpVote) + sum(downVote) = Reputation                 |
| CreationDate   | Data stworzenia użytkownika                                                                                                                                                                                                                                                                    |
| DisplayName    | Nick użytkownika                                                                                                                                                                                                                                                                               |
| LastAccessDate | Kiedy ostatnio był zalogowany                                                                                                                                                                                                                                                                  |
| WebsiteUrl     | Strona internetowa użytkownika                                                                                                                                                                                                                                                                 |
| Location       | Miejsce zamieszkania użytkownika. Zazwyczaj w formie Miasto, Państwo                                                                                                                                                                                                                           |
| AboutMe        | To co użytkownik napisał sam o sobie. Zazwyczaj kilka zdań.                                                                                                                                                                                                                                    |
| Views          | Ilość wyświetleń posta użytkownika (jedno IP może naliczyć się tylko raz w ciągu godziny)                                                                                                                                                                                                      |
| UpVotes        | UpVote powoduje przesuwanie treści "w górę", aby była widoczna dla większej liczby osób.<br>Zasady:   <ul><li>Awanse na pytanie dają popisowi reputację +5.</li><li>Awanse na odpowiedź dają replikatorowi reputację +10</li><li>Możesz głosować 30 razy dziennie w UTC plus 10 razy więcej tylko na pytania.</li></ul> |
| DownVotes      | DownVote przesuwa treść "w dół" strony, więc będzie ją widzieć mniej osób.<br>Zasady:<ul><li>Downvotes usuwa 2 reputacje od właściciela postu.</li><li>Downvotes na odpowiedzi usuwają 1 reputację od ciebie</li><li>Downvotes na pytania są bezpłatne</li><li>?Możesz głosować 30 razy w ciągu UTC.</li></ul>|

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
