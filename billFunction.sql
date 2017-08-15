/*  This function will calculate the bill for an individual machine. Even if the machines
 *  are covered by a warranty, we will use the bill values of those to obtain the amount
 *  covered by warranties in our final bills. 
 *  Charges are: 50$ service fee + cost of parts + 25$ x Labor Hours
 */

CREATE OR REPLACE FUNCTION billfunction
 	(custID_param IN repairMachine.custID%type)
 RETURN NUMERIC IS
 	price NUMERIC(10,2);
 	sumofparts repairMachine.costofparts%type;
 	hoursworked repairMachine.laborhours%type;
AS
BEGIN

 /*	SELECT SUM(costofparts) INTO sumofparts
 	FROM repairMachine
 	WHERE custID_param = custID;

 	SELECT SUM(laborhours) INTO hoursworked
 	FROM repairMachine
 	WHERE custID_param = custID;

 	price = (50.00 + sumofparts + 25.00 * hoursworked);
 	RETURN price */
END;
/
show errors;

/*  start with groupID, custID
	Use custID in serviceItem to find all groupIDs belonging to 1 customer
	from groupID obtain noofmachines
	if noofmachines is >1 then use groupID and cursor to cycle through machineIDs
	Use these machineIDs with the repairMachine table to find laborhours and 
	cost of parts which can be used to calculate the bill which will be 10% off
	because it is a cluster.

	IF noofmachines is =1 then use groupID to find machineID within serviceItem
	use this machineID to find laborhours and costofparts to calculate

