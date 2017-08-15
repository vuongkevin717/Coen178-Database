/* Create a Repair Job -- Accept a machine for repair. 
The user should provide the necessary information. If a warranty number is given, 
it should be checked against the database of stored warranty numbers
and accept the warranty, if the warranty period covers the date the machine was 
brought in. If the warranty is not valid, a message to that effect should be displayed 
and the machine accepted forrepair (with costs) */

/* Warranty(servicecontract) # may or may not be given. 
 If no warranty number, enter 00000 for the contractID_param input */
 
CREATE OR REPLACE PROCEDURE addrepairjob
 	(repairID_param IN repairMachine.repairID%type,
  	 machineID_param IN repairMachine.machineID%type,
  	 datein_param IN repairMachine.datein%type,
  	 dateout_param IN repairMachine.dateout%type,
  	 timein_param IN repairMachine.timein%type,
  	 timeout_param IN repairMachine.timeout%type,
  	 laborhours_param IN repairMachine.laborhours%type,
  	 costofparts_param IN repairMachine.costofparts%type,
   	 status_param IN repairMachine.status%type,
  	 custID_param IN customer.custID%type,
  	 empID_param IN repairPerson.empID%type,
  	 billID_param IN bill.billID%type,
  	 contractID_param IN contract.contractID%type) --used to test validity of warranty
DECLARE
	coverage_param IN repairMachine.coverage%type --used to update coverage to yes or no based on warranty validity
AS
	BEGIN 
		coverage_param := warrantycheck(contractID_param, datein_param); 
		
	/* Tests to see if warranty is in the database of stored contractIDs 
	and then tests to see if the current date is prior to the warranty expiration date */

	/* The machine is inserted into the database. The coverage is either Y or N. If the
	coverage is Y the machine is covered and costs will be 0. If it is N then the customer
	will have to pay for the machine. */

		INSERT INTO repairMachine
			 VALUES (repairID_param, machineID_param, datein_param, dateout_param, timein_param, timeout_param, laborhours_param, costofparts_param, status_param, coverage_param, custID_param, empID_param, billID_param);
END;
/
show errors;		
