1.	Получить информацию обо всех типах космических аппаратов (КА).   
select * from type_space_flight

2.	Получить для каждого КА его интернациональное обозначение и вес. 

select international_designation, weight_space_vehicle 
from space_vehicle

3.	Найти целое значение веса КА в русских фунтах (вес в граммах на 403)

select weight_space_vehicle, weight_space_vehicle * 403 as russian_units
from space_vehicle 

4.	Найти номер дня недели, когда США меняло свое название

SELECT date_change_name, name_country, EXTRACT (DOW FROM date_change_name) as num_of_week
from assignee
where name_country='Соединенные Штаты Америки'; 


5.	Найти КА порядковый номер которых меньше либо равен 114.  

select * 
from space_vehicle
where num_space_vehicle <= 114

6.	Найти космодромы расположенные между 5 градусами южной и северной широты, 
открытых после 1960 года (значения широты в десятичных градусах, 
положительные значения - северное полушарие, отрицательные - южное.)

select * 
from cosmodrome
where (year_open > 1960) AND longitude > -5 AND longitude > 5


7.	Выдать список уникальных номеров ракетоносителей использованных для запуска КА.  

select distinct num_carrier_rocket 
from carrier_rocket 


8.	Найти все возможные комбинации информации о РН и типах КА (декартово произведение)   

select *
from carrier_rocket, space_vehicle

9.	Найти все пары возможных комбинаций названий и типов КА.
select name_space_vehicle, name_type_space_flight
from space_vehicle, type_space_flight

10.	Внести информацию о типе КА «Восток-3А».  

INSERT into type_space_flight(num_type_space_flight, name_type_space_flight) 
VALUES (21,'Восток-3А')
select *
from type_space_flight

11.	Удалить информацию о РН номер 2.

DELETE FROM space_vehicle where NUM_CARRIER_ROCKET = '2';
DELETE FROM carrier_rocket where NUM_CARRIER_ROCKET = '2';

select * from space_vehicle 
where NUM_CARRIER_ROCKET = 2

select * from  carrier_rocket
where NUM_CARRIER_ROCKET = 2


12.	Перевести все названия космических тел в верхний регистр. 
select upper (name_heavenly_body) 
from heavenly_body 

13.	Найти космодромы, принадлежащие Франции, России и Китаю расположенные в северном полушарии.
select    		cosm.num_country,
    			cosm.name_cosmodrom,
    			cosm.latitude,
    			country.short_name_country
from 		country

inner join 		cosmodrome cosm on (country.num_country = cosm.num_country)

where 		latitude > 0 and
      		country.num_country in (1, 5, 6)

14.	Найти названия КА и наименование страны, которой они принадлежат на борту, которых не было ни одной живой души. 
select 			country.short_name_country,
    				sv.name_space_vehicle,
    				sf.num_astronaut
from 			country
inner join 			space_vehicle sv on (country.num_country = sv.num_country)
left outer join 		space_flight sf on (sv.num_space_vehicle = sf.num_space_vehicle)
where 			sf.num_astronaut is null 

15.	Найти названия КА и наименование типов КА масса, которых находится в промежутке между 100 кг и одной тонной. 
select    		sv.name_space_vehicle,
    			tsf.name_type_space_flight,
    			sv.weight_space_vehicle
from 		type_space_flight tsf
inner join 		space_vehicle sv on (tsf.num_type_space_flight = sv.num_type_space_flight)
where 		sv.weight_space_vehicle between 100 and 1000

16.	Найти названия КА и наименование космодрома, с которого они взлетели при условии, 
что имя КА начинается с «explorer» учесть, что регистр названия может быть разным. 
select 		sv.name_space_vehicle,
    			cosm.name_cosmodrom
	
from cosmodrome cosm
inner join space_vehicle sv on (cosm.num_cosmodrome = sv.num_cosmodrome)
inner join history_space_vehicle hsv on (hsv.num_space_vehicle = sv.num_space_vehicle)
   
   
where hsv.type_event = 0 and 
name_space_vehicle  like 'explorer%' or name_space_vehicle  like 'Explorer%'

17.	Найти названия КА при условии, что имя КА содержит подстроку «спутник». 
select 	sv.name_space_vehicle
from 	space_vehicle sv
where	sv.name_space_vehicle like '%спутник%'

18.	Найти названия биологических видов, которые оканчиваются на слог «ка»
select 	name_species
from 	species
where 	name_species like '%ка' 


19.	Найти информацию обо всех КА, для которых неизвестен вес.

select 	name_space_vehicle,
   	 	weight_space_vehicle
from 	space_vehicle
where 	weight_space_vehicle is null


20.	Найти название страны, которая запускала в космос космонавтов всех биологических видов

select 		distinct ctr.short_name_country, astr.num_species
from 		country ctr
inner join 		space_vehicle sv on sv.num_country = ctr.num_country
inner join 		space_flight sf on sf.num_space_vehicle = sv.num_space_vehicle
inner join 		astronaut astr on astr.num_astronaut = sf.num_astronaut
where 		num_species in (1, 2)


21.	Найти информацию обо всех РН, которые использовались для единственного запуска КА. 
select carrier, count1
from
(
select  cr.num_carrier_rocket as carrier,
  			count( sv.num_space_vehicle ) as count1,
    		count( sf.num_space_flight ) as count2

from space_flight sf
inner join 	space_vehicle sv on sf.num_space_vehicle = sv.num_space_vehicle
inner join 	carrier_rocket cr on sv.num_carrier_rocket = cr.num_carrier_rocket
group by cr.num_carrier_rocket ) as cr_launch
where cr_launch.count1 = 1

22.	Найти пары номер КА и номер космодрома, такие что, данный КА был выведен с данного космодрома, 
при условии что, в результате будут представлены все космодромы, для космодрома, 
с которого не стартовал КА вместо номера КА установить null. 

select cosm.name_cosmodrom,
sv.name_space_vehicle
from cosmodrome cosm
left join space_vehicle  sv on (cosm.num_cosmodrome = sv.num_cosmodrome)


23.	Сколько всего было космонавтов?  
select count (astronaut.num_astronaut) as coutn_astronaut
from astronaut

24.	Сколько было космонавтов животных?
select count(num_astronaut) as count_animal
from astronaut
where num_species<>1


25.	Найти последнее название Франции.    
select 		ctr.num_country, max (date_change_name) 
into 		temp_table
from 		assignee asgn
inner join 	country ctr on (asgn.num_country = ctr.num_country)
where  		ctr.short_name_country= 'Франция' 
group by 	ctr.num_country

select 	name_country 
from 	assignee asgn
inner join temp_table tt on (asgn.num_country = tt.num_country)
where tt.max = asgn.date_change_name


26.	Получить список космодромов с указанием общего числа запусков КА.  
select cosm.name_cosmodrom as cosmodrome,
sv.name_space_vehicle as space_vehicles,
hsv.type_event as starts
into history
from history_space_vehicle hsv
inner join 	space_vehicle sv on (hsv.num_space_vehicle = sv.num_space_vehicle)
inner join cosmodrome cosm on (sv.num_cosmodrome = cosm.num_cosmodrome)
where hsv.type_event = 1

select * from history

select cosmodrome,  count (starts) as QuantityOfStarts
from 	history 
group by cosmodrome

27.	Получение статистических данных о количество запусков в 1978 с указанием количества запусков за каждый месяц. 
(нетривиальный) 
select 	extract (year  from history.date_history_space_vehicle) as yearOfStart,
		extract (month  from history.date_history_space_vehicle) as monthOfStart,
		count (history.num_space_vehicle) as numberOfStarts
from
		(select  	hsv.num_space_vehicle,
					min(hsv.date_history_space_vehicle) as date_history_space_vehicle
		from 		history_space_vehicle hsv
		group by 	num_space_vehicle
		)
		as 			history

group by yearOfStart,  monthOfStart
having extract (year  from history.date_history_space_vehicle) = '1960'

28.	Составить запрос возвращающий: список стран в порядке вывода ими КА в космос со своих космодромов.
select 		cnt.short_name_country as country,
			cosm.name_cosmodrom,
			hsv.date_history_space_vehicle,
			sv.name_space_vehicle

from 		space_flight sf
inner join 		space_vehicle sv on (sf.num_space_vehicle = sv.num_space_vehicle )
inner join 		cosmodrome cosm on (sv.num_cosmodrome =cosm.num_cosmodrome )
inner join 		country cnt on (cosm.num_cosmodrome=cnt.num_country)
inner join 		history_space_vehicle hsv on (hsv.num_space_vehicle = sv.num_space_vehicle)
order by 		(cnt.short_name_country, hsv.date_history_space_vehicle)

29.	Составить запрос возвращающий: список стран в порядке вывода ими КА в космос со своих космодромов 
и своими ракетоносителями.  
select 		cnt.short_name_country as country,
			cosm.name_cosmodrom,
			hsv.date_history_space_vehicle,
			sv.name_space_vehicle,
			cr.name_carrier_rocket

from 		space_flight sf
inner join 		space_vehicle sv on (sf.num_space_vehicle = sv.num_space_vehicle )
inner join 		cosmodrome cosm on (sv.num_cosmodrome =cosm.num_cosmodrome )
inner join 		country cnt on (cosm.num_cosmodrome=cnt.num_country)
inner join 		history_space_vehicle hsv on (hsv.num_space_vehicle = sv.num_space_vehicle)
inner join 		carrier_rocket cr on (sv.num_carrier_rocket = cr.num_carrier_rocket)
order by 		(cnt.short_name_country, hsv.date_history_space_vehicle)


30.	Список стран с указанием общего количества представителей страны слетавших в космос, 
отсортированный в порядке возрастания числа полетов.
select 	country, people 
from
	(select 	cnt.short_name_country as country,
				count (people.name) as people

	from 		space_flight sf
	inner join 	space_vehicle sv on (sf.num_space_vehicle = sv.num_space_vehicle )
	inner join 	history_space_vehicle hsv on (hsv.num_space_vehicle = sv.num_space_vehicle)
	inner join 	astronaut on (sf.num_astronaut =astronaut.num_astronaut  )
	inner join 	people  on (astronaut.num_astronaut =people.num_astronaut)
	inner join 	country cnt on (people.num_country=cnt.num_country)
	group by 	country
	) as one
order by people

31.	Внести в БД следующую информацию: 12.04.1961 В 6:07 UTC с космодрома Байконур, 
стартовый комплекс № 1, осуществлен пуск ракеты-носителя «Восток 8К72К», 
которая вывела на околоземную орбиту советский космический корабль «Восток» (00103 / 1961 Мю 1), 
КА типа «Восток-3А». Космический корабль пилотировал советский космонавт Юрий ГАГАРИН. Полет продолжался 1 час 48 минут. 

INSERT INTO ASTRONAUT (NUM_ASTRONAUT, NUM_SPECIES, SEX) 
VALUES (100, 1, 'М');

INSERT INTO PEOPLE (NUM_ASTRONAUT, NUM_COUNTRY, BIRTHDAY, NAME, FAMILY, PATRONYMIC) 
VALUES (100, 1, '1934-03-09', 'Юрий', 'ГАГАРИН', 'Алексеевич');


INSERT INTO TYPE_SPACE_FLIGHT (NUM_TYPE_SPACE_FLIGHT, NAME_TYPE_SPACE_FLIGHT) 
VALUES (21, 'Восток 3-А');

INSERT INTO SPACE_VEHICLE (NUM_SPACE_VEHICLE, NUM_CARRIER_ROCKET,NUM_COUNTRY, NUM_COSMODROME, NUM_TYPE_SPACE_FLIGHT, NAME_SPACE_VEHICLE, 
						   SEQUENCE_NUMBER, INTERNATIONAL_DESIGNATION, WEIGHT_SPACE_VEHICLE) 
VALUES (53, 28, 1, 1, 21, '«Восток»', 00103, '1961 Мю 1', NULL);
select * from SPACE_VEHICLE 


INSERT 
INTO SPACE_FLIGHT (NUM_SPACE_FLIGHT, NUM_SPACE_VEHICLE, NUM_ASTRONAUT, NUM_STATUS, FLIGHT_ENDURANCE) 
VALUES (24, 53, 100, 4, 108)

select * from SPACE_FLIGHT 


INSERT 
INTO HISTORY_SPACE_VEHICLE (NUM_HISTORY_SPACE_VEHICLE, NUM_HEAVENLY_BODY, NUM_SPACE_VEHICLE, TYPE_EVENT, 
							DATE_HISTORY_SPACE_VEHICLE,  TIME_HISTORY_SPACE_VEHICLE) 
VALUES (49, 2, 53, 4, '1961-04-12', '6:07:00');

select * from HISTORY_SPACE_VEHICLE 

