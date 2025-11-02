-- 1. Количество закрывшихся компаний
SELECT COUNT(status) 
FROM company
WHERE status = 'closed';

-- 2. Количество привлечённых средств для новостных компаний США
SELECT funding_total 
FROM company
WHERE category_code = 'news' AND country_code = 'USA'
ORDER BY funding_total DESC;

-- 3. Имя, фамилия и аккаунты, начинающиеся на 'Silver'
SELECT first_name, last_name, network_username 
FROM people
WHERE network_username LIKE 'Silver%';

-- 4. Люди с аккаунтами, содержащими 'money', и фамилией на 'K'
SELECT * 
FROM people
WHERE network_username LIKE '%money%' AND last_name LIKE 'K%';

-- 5. Общая сумма привлечённых инвестиций по странам
SELECT country_code, SUM(funding_total) 
FROM company 
GROUP BY country_code 
ORDER BY SUM(funding_total) DESC;

-- 6. Сотрудники и их учебные заведения
SELECT p.first_name, p.last_name, e.instituition 
FROM people AS p
LEFT JOIN education AS e ON p.id = e.person_id;

-- 7. Общая сумма сделок (наличные, 2011–2013)
SELECT SUM(price_amount) 
FROM acquisition
WHERE acquired_at BETWEEN '2011-01-01' AND '2013-12-31'
AND term_code = 'cash';

-- 8. Активность фондов по странам
SELECT country_code,
       MIN(invested_companies),
       MAX(invested_companies),
       AVG(invested_companies)
FROM fund
WHERE founded_at BETWEEN '2010-01-01' AND '2012-12-31'
GROUP BY country_code
HAVING MIN(invested_companies) > 0
ORDER BY AVG(invested_companies) DESC, country_code 
LIMIT 10;
