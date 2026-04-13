# TASK - 1 
		  # Frame 3 problem statements using aggregate functions
		  # 1st q : Find the maximum and minimum creditlimit 
		  # 2nd  q : Find the total buy price of the products
		  # 3rd q : how many uniq productline we have?
		  
		  #1 st:
			 select max(creditLimit) as highcredit,min(creditLimit) as lowcridit from customers;
		  #2nd :
			 select sum(buyPrice) as total_price from products;
		  #3rd :
			 select distinct(productLine) as uniq_products from products;
	# ------------- TASK 1 finished ---------------
    # TASK -3 
			   # 	Frame 3 problem statements using aggregate functions along with GROUP BY.
				# 1st q : Find how much each productline total buy prices 
			  # 2nd  q :  find how much each productline's Total Msrp
			  # 3rd q :  Find the total credit limit based on state
		   # 1 st q:
			    select sum(buyPrice),productLine from products group by productLine;
		   # 2 nd q : 
			    select sum(MSRP),productLine from products group by productLine;
		   # 3 rd q:
			    select state,sum(creditLimit) as Cl_by_states from customers group by state;
	#--------------------TASK - 3 Finished-----------------------------
         
	# TASK -2 
          # Frame 3 problem statements using aggregate functions with WHERE conditions.
          # 1st : count customerr's name starts with t 
          # 2nd : show the creditlimits where city at mumbai
          # 3rd :count only ordernumbers which is quantityOrdered is exactly 1
          
	 # 1 st :
          select count(customerName) from customers where customerName like "T%";
	# 2 nd :
          select city,sum(creditLimit) as Total_cl from customers where city ="Mumbai";
	# 3 rd :
		  select count(orderNumber) as no_of_people,quantityOrdered from orderdetails where quantityOrdered = 1;
 #------------------------TASK-2 Completed--------------------------------
 # TASK _4: Subquery:
 #  Problem_statement : Find the customer no which pays more than avg amount
 
		select customerNumber,amount from payments where amount > ( select avg(amount) from payments );
        
        
#---------------------------TASK-4 Completed--------------------------------#
		  select * from customers;
			select * from products;
			select * from offices;
			select * from orderdetails;
			select * from orders;
			select * from payments;
			select * from productlines;
			select * from products;
			
	