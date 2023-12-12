1.	Создайте генератор для генерирования первичных ключей в таблице “космические тела”, 
установите его значение таким образом, чтобы гарантировать уникальность первичных ключей. 
Вставьте в таблицу “космические тела” информацию о спутниках Марса - "Фобосе" и "Деймосе" 
с использованием генератора. (простой)
--Создали временную таблицу для демонстрации
CREATE TEMP TABLE mytable AS
--Изменили значение в колонке num_heavenly_body так, чтобы оно было уникальным
ALTER TABLE mytable DROP COLUMN num_heavenly_body;
ALTER TABLE mytable ADD COLUMN num_heavenly_body int UNIQUE;
--Создали генератор уникальных значений для генерирования первичных ключей
CREATE SEQUENCE generator 
INCREMENT BY 4 
START WITH 1;
--Обновили данные в столбце num_heavenly_body на примере 'солнце' и 'земля'
UPDATE mytable SET num_heavenly_body = nextval('generator')
WHERE name_heavenly_body = 'солнце'
--Вставьте в таблицу “космические тела” информацию о спутниках Марса - "Фобосе" и "Деймосе" 
INSERT INTO mytable VALUES ('Марс', null, nextval('generator'))
INSERT INTO mytable VALUES ('Фобос', 9, nextval('generator'))
INSERT INTO mytable VALUES ('Деймос', 9, nextval('generator'))
SELECT * FROM mytable;
SELECT * FROM heavenly_body;