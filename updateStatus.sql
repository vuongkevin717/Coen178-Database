/* The status of a machine that is in for a repair can be updated. For example,
 one may change the status to 3 (it is ready) and enter the current time, costs 
 and other information associated with the repair */

/* If product repair is not yet complete, 
timeout will be the estimated completion date, costofparts is an estimation
and laborhours is an estimation as well. When this procedure is run
with a newstatus of 3 or 4, then those estimations will be the finalized exact
numbers */
 CREATE OR REPLACE PROCEDURE updatestatus
 	(repairID_param IN repairMachine.repairID%type,
 	 machineID_param IN repairMachine.machineID%type,
 	 dateout_param IN repairMachine.dateout%type,
 	 timeout_param IN repairMachine.timeout%type,
 	 costofparts_param IN repairMachine.costofparts%type,
 	 laborhours_param IN rapairMachine.laborhours%type,
 	 newstatus IN repairMachine.status%type)
 /* DECLARE
 	temptimeout IN repairMachine.timeout%type;
 	tempcostofparts IN repairMachine.costofparts%type;
 	templaborhours IN repairMachine.laborhours%type; */
 AS
 	BEGIN
 /*		SELECT timeout, costofparts, laborhours INTO temptimeout, tempcostofparts, templaborhours
 		FROM repairMachine
 		WHERE repairID_param = repairID AND machineID_param = machineID; */

 	/* Update the status of the desired machine */

 		UPDATE repairMachine
 		SET status = newstatus
 		WHERE repairID_param = repairID AND machineID_param = machineID; --use the primary key to identify the specific machine being updated

	/* Update the estimated repair completion date of the desired machine. Time will only change when the official timeout is determined.
	Similarly with the costofparts and laborhours; these only are changed when the final cost and hours is officially determined.*/

	    IF  newstatus = '4'
	    	UPDATE repairMachine
	    	SET dateout = dateout_param
	    	WHERE repairID_param = repairID AND machineID_param = machineID;
	    	 
			UPDATE repairMachine
			SET timeout = timeout_param
			WHERE repairID_param = repairID AND machineID_param = machineID;
		ENDIF;

		IF newstatus = '3'
			UPDATE repairMachine
			SET costofparts = costofparts_param
			WHERE repairID_param = repairID AND machineID_param = machineID;

			UPDATE repairMachine
			SET laborhours = laborhours_param
			WHERE repairID_param = repairID AND machineID_param = machineID;
		ENDIF;
	END;
	/
	show errors;
