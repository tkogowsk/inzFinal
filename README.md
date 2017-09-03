# gate-interface
Instrukcja uruchomienia aplikacji z przykładowymi danymi na systemie operacyjnym linux:

Wymagane zależności:
- SBT -> http://www.scala-sbt.org/download.html
- Postgresql -> https://www.postgresql.org/download/
- Java 8 

Stworzenie bazy danych i załadowanie danych: 
Otworzyć terminal w folderze "gate-interface"
$ sudo -u postgres psql postgres
postgres=# CREATE DATABASE transcriptbrowserdb;
postgres=# CREATE USER transcriptbrowseruser WITH PASSWORD 'tempass';
postgres=# GRANT ALL PRIVILEGES ON DATABASE transcriptbrowserdb to transcriptbrowseruser;
postgres=# \q

$ psql -U transcriptbrowseruser transcriptbrowserdb -f inz_data.sql

Uruchomienie serwera (ważne by podać port HTTPS w przeciwnym wypadku nie będą dostępne wszystkie funkcjonalności) :
$ cd src/
$ sbt
$ run -Dhttps.port=9443

Uruchomić przeglądarkę internetową
W adresie wpisać : "https://localhost:9443"
Po wciśnięciu klawisza Enter należy poczekać, ponieważ projekt musi się skompilować.
Może się pojawić strona "This site can’t be reached". Należy wtedy odświeżyć stronę. 
Login : admin
Hasło : admin

Transkrypt z optymalną liczbą rekordów : "sample_id_3"