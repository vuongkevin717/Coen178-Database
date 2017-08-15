/* Should display the billing information. A customer’s bill shows the 
customer’s information (name, phone or email), the model of the computer 
repaired, time (and date) the machine was brought in; time the machine is 
ready and repair information. Repair information includes the name and 
description of each type of problem that is fixed, charge for each service, 
names and price of parts used (if any) and the total amount due. If the 
machine is under warranty, total amount due should be 0 

Function that calculates the customers total bill between all their machines
and returns the value as a numeric 

The customers bill will be discounted 10% if they have more than 1 machine.
*/

CREATE OR REPLACE FUNCTION customerbill
	(custID_param IN customer.custID%type)
RETURN NUMERIC IS amount NUMERIC(10,2)
	CURSOR group_cur IS 
		SELECT groupID
		FROM serviceItem
		WHERE custID_param = custID;
	group_rec group_cur%rowtype;

	CURSOR machine_cur IS
		SELECT machineID
		FROM serviceItem
		WHERE groupID = group_rec;
	machine_rec machine_cur%rowtype;

BEGIN
	DECLARE
		numbertemp groupcluster.noofmachines%type;
		sumtemp bill.amount%type;
		amounttemp bill.amount%type;
		laborhourstemp repairMachine.laborhours%type;
		costofpartstemp repairMachine.costofpartstemp%type;
		sumtemp := 0; 
		amounttemp := 0;

	IF NOT group_cur%ISOPEN THEN
	  		OPEN group_cur; --open cursor
	END IF;

	IF NOT machine_cur%ISOPEN THEN
	  	OPEN machine_cur;
	END IF;

/* This loop will obtain the groupID (each customer has a "group" of machines with total number
   of machines being 1 or greater in that group) and determine the number of machines in each group. The loop
   is used primarily in the case that a customer has multiple orders and thus has multiple "groups" of machines */
   
	LOOP
		FETCH group_cur INTO group_rec;
		EXIT WHEN group_cur%NOTFOUND;

		SELECT noofmachines INTO numbertemp
		FROM groupcluster
		WHERE groupID = group_rec;

/* If the customer has more than 1 machine. This will loop through that customers machines
   and calculate the cost accordingly with the 10 percent discount.*/

		IF noofmachines > 1 THEN
			LOOP
				FETCH machine_cur INTO machine_rec;
				EXIT WHEN machine_cur%NOTFOUND;

				SELECT laborhours, costofparts INTO laborhourstemp, costofpartstemp
				FROM repairMachine
				WHERE machineID = machine_rec;

				sumtemp := 50.00 + 25.00 * laborhourstemp + costofpartstemp;
				amounttemp := amounttemp + (sumtemp - sumtemp * 0.1); --adding to amount the total with a 10% discount b/c it is a cluster
			END LOOP;
			CLOSE machine_cur;
		ELSE --noofmachines = 1 so selecting machineID with this groupID should result in only 1 machineID
			SELECT laborhours, costofparts INTO laborhourstemp, costofpartstemp
			FROM repairMachine
			WHERE machineID IN (SELECT machineID -- should only give back 1 machineID
								FROM serviceItem
								WHERE groupID = group_rec);
			amounttemp := amounttemp + 50.00 + 25.00 * laborhourstemp + costofpartstemp;
		END IF;
	END LOOP;
	CLOSE group_cur;
	amount := amounttemp;
	RETURN amount;
END;
/
show errors;







