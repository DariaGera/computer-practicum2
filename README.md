# computer-practicum2
Герасимчук Дарія КМ-82 Варіант 5

Інструкція по запуску
В бд є заповнена таблиця з КП1 - для цього необхідно виконати файл comp_pract1.py. 
Команди для міграції: 
flyway baseline 
flyway migrate

У випадку, коли в БД немає нічого - Команди для міграції: 
flyway migrate

У випадку, коли в БД пуста таблиця з КП1 - Команди для міграції: 
flyway baseline 
flyway -target=2 migrate
