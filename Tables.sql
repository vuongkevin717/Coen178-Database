/* THIS FILE CREATES ALL THE TABLES FOR OUR DATABASE */

CREATE TABLE customer(custID varchar(5) NOT NULL,
                      cust_name varchar(20) NOT NULL,
                      cust_phone char(10),
                      PRIMARY KEY (custID));


CREATE TABLE contract(contractID varchar(5) NOT NULL,
                      start_date date,
                      end_date date,
                      PRIMARY KEY (contractID));


CREATE TABLE problem(problemID varchar(5) NOT NULL,
                     description varchar(100),
                     PRIMARY KEY (problemID));


CREATE TABLE bill(billID varchar(5) NOT NULL,
                  amount number(10,2),
                  PRIMARY KEY (billID));


CREATE TABLE group(groupID varchar(5) NOT NULL,
                   noofmachines varchar(5),
                   PRIMARY KEY (groupID));


CREATE TABLE serviceItem(machineID varchar(5) NOT NULL,
                         model varchar(10),
                         custID varchar(5) NOT NULL,
                         contractID varchar(5) NOT NULL,
                         groupID varchar(5) NOT NULL,
                         PRIMARY KEY (machineID),
                         FOREIGN KEY (custID) REFERENCES customer(custID),
                         FOREIGN KEY (contractID) REFERENCES contract(contractID),
                         FOREIGN KEY (groupID) REFERENCES group(groupID));


CREATE TABLE repairPerson(empID varchar(5) NOT NULL,
                          emp_name varchar(20) NOT NULL,
                          emp_phone char(10),
                          PRIMARY KEY (empID));

CREATE TABLE repairMachine(repairID varchar(5) NOT NULL,
                           machineID varchar(5) NOT NULL,
                           custID varchar(5) NOT NULL,
                           empID varchar(5) NOT NULL,
                           billID varchar(5) NOT NULL,
--------		   partsordered,
                           timein time,
                           timeout time,
                           status char(1),
                           coverage varchar(10),
                           PRIMARY KEY (repairID,machineID),
                           FOREIGN KEY (custID) REFERENCES customer(custID),
                           FOREIGN KEY (empID) REFERENCES repairPerson(empID),
                           FOREIGN KEY (billID) REFERENCES bill(billID));
CREATE TABLE has(
      repairID varchar(5),
      machineID varchar(5),
      problemID varchar(5),
      PRIMARY KEY (repairID, machineID, problemID)
);

--We should add checks to some of the tables so that the user does not accidently input values that are invalid.
--For example, status can only be values within the set ('1', '2', '3', '4').
