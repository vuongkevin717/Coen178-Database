/* This function will check whether or not a warranty is valid and return 
Y or N which will be inputted into the coverage attribute 

It begins by ensure the contractID entered is valid. Then it checks the datein that
was entered and compares that to the enddate of the contract and updates the warranty coverage
accordingly*/

CREATE OR REPLACE FUNCTION warrantycheck
	(contractID_param IN contract.contractID%type,
	 datein_param IN repairMachine.datein%type)
RETURN CHAR IS
	validcoverage CHAR(1);
AS
BEGIN
	IF contractID_param IN (SELECT contractID 
							FROM contract) AND contractID_param != '0'
		IF datein_param <= (SELECT end_date
							FROM contract
							WHERE contractID_param = contractID)
			SET validcoverage = 'Y'; --Warranty is valid
		ELSE
			SET validcoverage = 'N'; --Warranty is invalid	
			dbms_output.put_line('Warranty Invalid');	
		ENDIF;
	ELSE
		SET validcoverage = 'N';
		dbms_output.put_line('Warranty Invalid');
	ENDIF;
	RETURN validcoverage
END;
/
show errors;