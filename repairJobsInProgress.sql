/* Should display all the repair-jobs that have a status of 1 or 2 */

CREATE OR REPLACE PROCEDURE repairjobsinprogress
AS
	BEGIN
		SELECT *
		FROM repairMachine
		WHERE status IN ('1', '2');
END;
/
show errors;