/* Given the machine id or customer-phone or email address, should show a
machine(s) status. This procedure will only return at most 1 machine */

CREATE OR REPLACE PROCEDURE statusbyID --by machineID
	(machineID_param IN serviceItem.machineID%type)
AS
	BEGIN
		SELECT repairID, machineID, cust_phone, status
		FROM repairMachine NATURAL JOIN customer
		WHERE machineID_param = machineID;
END;
/
show errors;

/* This procedure can return as many machines as the customer has. */
CREATE OR REPLACE PROCEDURE statusbyphone --by cust_phone
	(custphone_param IN customer.cust_phone%type)
AS
	BEGIN
		SELECT repairID, machineID, cust_phone, status
		FROM repairMachine NATURAL JOIN customer
		WHERE custphone_param = cust_phone;
END;
/
show errors;