CREATE TABLE patient_data(
Patient_ID INT(11) PRIMARY KEY,
First_Name VARCHAR(50),
Last_Name VARCHAR(50),
Date_of_Birth DATE,
Gender VARCHAR(10),
Phone_Number VARCHAR(13),
Next_of_Kin VARCHAR(100),
Location_ID INT(11) ,
Date_Added DATE,
Update_Date DATE,
FOREIGN KEY(Location_ID) REFERENCES geographical_location(Location_ID)

);



CREATE TABLE geographical_location(
Location_ID INT(11) PRIMARY KEY,
Village VARCHAR(100),
Parish VARCHAR(100),
Sub_County VARCHAR(100),
Country VARCHAR(100),
Region VARCHAR(50),
Population INT(11),
Coordiinates VARCHAR(100),
Malaria_Risk_Level VARCHAR(50),
Health_Facilites_Count INT(11),
ITN_Coverage DECIMAL(5,2),
Reported_Cases INT(11));


CREATE TABLE supply_chain(
Supply_ID INT(11) PRIMARY KEY,
Resource_ID INT(11) ,
Facility_ID INT(11) ,
Quantity_Shipped INT(11),
Shipment_Date DATE,
Expected_Arrival_Date DATE,
Shipped_By INT(11),
Status VARCHAR(50),
Update_Date DATE,
FOREIGN KEY (Resource_ID) REFERENCES resource(Resource_Id),
FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID));

CREATE TABLE epidemiological_data(
Data_ID INT(11) PRIMARY KEY,
Location_ID INT(11),
Recorded_Date DATE,
Cases_Per_Thousand_People INT(11),
Rainfall INT(11),
Average_Temperature DECIMAL(5,2),
Update_Date DATE,
Added_By INT(11),
FOREIGN KEY(Location_ID) REFERENCES geographical_location(Location_ID),
FOREIGN KEY(Added_By)REFERENCES users(User_ID));


CREATE TABLE training(
Training_ID INT(11) PRIMARY KEY,
User_ID INT(11) ,
Training_Type VARCHAR(100),
Training_Date DATE,
Completion_Status VARCHAR(50),
FOREIGN KEY (User_ID) REFERENCES user(User_Id));

CREATE TABLE facility_type(
Facility_Type_ID INT(11) PRIMARY KEY,
Name VARCHAR(50),
Description TEXT,
Date_Added DATE,
Date_Updated DATE);

CREATE TABLE treatment_outcome(
Outcome_ID INT(11) PRIMARY KEY,
Outcome_Name VARCHAR(50),
Outcome_Description TEXT,
Date_Added DATE,
Added_By INT(11),
Update_Date DATE,
FOREIGN KEY (Added_By) REFERENCES user(User_ID));



CREATE TABLE laboratory_test(
Test_ID INT(11) PRIMARY KEY,
Case_ID INT(11) ,
Test_Type VARCHAR(50),
Test_Result VARCHAR(50),
Test_Date DATE,
Technician_ID INT(11),
FOREIGN KEY (Case_ID) REFERENCES malaria_cases(Case_ID),
FOREIGN KEY(Technician_ID) REFERENCES user(User_ID));


CREATE TABLE health_facility(
Facility_ID INT(11) PRIMARY KEY,
Facility_Name VARCHAR(100),
Location_ID INT(11),
Facility_Type INT(11),
Capacity INT(11),
Contact_Details VARCHAR(100),
Date_Added DATE,
Facility_Head VARCHAR(100),
FOREIGN KEY(Location_ID) REFERENCES geographical_location(Location_ID));

CREATE TABLE resource(
Resource_ID INT(11) PRIMARY KEY,
Facility_ID INT(11),
Resource_Type VARCHAR(50),
Quantity INT(50),
Last_Updated_Date DATE,
Description TEXT,
Date_Added DATE,
Update_Date DATE,
FOREIGN KEY (Facility_ID)REFERENCES facility_type(Facility_ID));

CREATE TABLE treatment(
Treatment_ID INT(11) PRIMARY KEY,
Treatmment_Name VARCHAR(50),
Treatment_Description TEXT,
Dosage VARCHAR(50),
Side_Effects TEXT,
Date_Added DATE,
Update_Date DATE);

CREATE TABLE visit_records(
Visit_ID INT(11) PRIMARY KEY,
Patient_ID INT(11),
Visit_Number INT(11),
Visit_Date DATE,
Update_Date DATE,
Facility_ID INT(11),
FOREIGN KEY(Patient_ID) REFERENCES patient_data(Patient_ID),
FOREIGN KEY(Facility_ID) REFERENCES facility_type(Facility_ID));



CREATE TABLE interventions(
Interventions_ID INT(11) PRIMARY KEY,
Type VARCHAR(50),
Location_ID INT(11),
Start_Date DATE,
End_Date DATE,
Outcome VARCHAR(50),
Date_Added DATE,
Update_Date DATE,
FOREIGN KEY(Location_ID ) REFERENCES geographical_location(Location_ID));



CREATE TABLE system_log(
Log_ID INT(11) PRIMARY KEY,
User_ID INT(11),
Activity TEXT,
Timestamp DATETIME,
IP_Address VARCHAR(100),
Location VARCHAR(100),
FOREIGN KEY(User_ID)REFERENCES user(User_ID));



CREATE TABLE  malaria_type(
Type_ID INT(11) PRIMARY KEY,
Type_Name VARCHAR(50),
Descriptiion TEXT,
Date_Added DATE,
Added_By INT(11),
Update_Date DATE,
FOREIGN KEY(Added_By) REFERENCES user(User_ID));


CREATE TABLE user(
User_ID INT(11) PRIMARY KEY,
First_Name VARCHAR(50),
Last_Name VARCHAR(50),
Preffered_Name VARCHAR(50),
Role_ID INT(11),
Username VARCHAR(50),
Password VARCHAR(100),
Facility_ID INT(11),
FOREIGN KEY(Role_ID) REFERENCES user_role(Role_ID),
FOREIGN KEY(Facility_ID) REFERENCES facility_type(Facility_ID)); 


CREATE TABLE referral(
Referral_ID INT(11) PRIMARY KEY,
Case_ID INT(11),
Referred_From INT(11),
Referred_To INT(11),
Referral_Date DATE,
Reason TEXT,
Outcome_ID INT(11),
Update_Date DATE,
Referred_By INT(11),
FOREIGN KEY(Referred_From) REFERENCES health_facility(Facility_ID),
FOREIGN KEY(Referred_To) REFERENCES health_facility(Facility_ID),
FOREIGN KEY(Outcome_ID)REFERENCES treatment_outcome(Outcome_ID),
FOREIGN KEY(Referred_By) REFERENCES user(User_ID));


CREATE TABLE user_role(
Role_ID INT(11) PRIMARY KEY,
Role_Name VARCHAR(50),
Role_Description TEXT,
Date_Added DATE,
Update_Date DATE);


CREATE TABLE malaria_cases(
Case_ID INT(11) PRIMARY KEY,
Patient_ID INT(11),
Facility_ID INT(11),
Date_Of_Diagnosis DATE,
Type_Of_Malaria VARCHAR(50),
Treatment_ID INT(11),
Outcome_ID INT(11),
FOREIGN KEY(Patient_ID)REFERENCES patient_data(Patient_ID),
FOREIGN KEY(Facility_ID) REFERENCES health_facility(Facility_ID),
FOREIGN KEY(Treatment_ID)REFERENCES treatment(Treatment_ID),
FOREIGN KEY(Outcome_ID) REFERENCES treatment_outcome(Outcome_ID));