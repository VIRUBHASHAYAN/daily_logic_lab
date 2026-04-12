# 1 st bq : what is the product code of the 1968 ford Mustang
select productCode,productName from products where productName = "1968 Ford Mustang";
# 2nd bq : Find the sales manager email
select email,jobTitle from employees where jobTitle = "Sales Manager" ;
#3 rd bq : find the name similar like harley and its buy price
 select productName,buyPrice from products where productName like "%Harley%" ;
 # 4 th bq : show the product and its buying price more than 7500
 select productName,buyPrice from products where buyPrice  >"7500";
 # 5 th bq: show offices in chennai and its phone number
 select city,phone from offices where city = "Chennai" ;
 # 6 th bq : show me top 1 msrp product
 select productName,msrp from products order by msrp desc limit 1;
 # 7 th bq: show me the product name for the productvendor Autocart Stdio
 select productName,productVendor from products where productVendor = "Autoart Studio";
# 8 th bq: show me the employee where his job title is salesrep and officeCode is 2
 select firstName,lastName from employees where officeCode = 2 and jobTitle = "Sales Rep";
# 9 th bq: find the product line of the productCode S10_1678
select productCode,productLine from products where productCode="S10_1678";
# 10 th bq: i want to know text description of productline but i only know it contains sports ..i want to know the full description with its product line.
select productLine,textDescription from productlines where textDescription like "%Sports%"