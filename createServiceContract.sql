/* Create a service contract for a customer. Contains contractID, start/end date
	must check so see if date is valid */

CREATE OR REPLACE PROCEDURE createservicecontract
	(contractID_param IN Contract.contractID%type
	 startdate_param IN Contract.start_date%type
	 enddate_param IN Contract.end_date%type)
AS
	BEGIN
		INSERT INTO Contract
		VALUES (contractID_param, startdate_param, enddate_param);
END;
/
show errors;