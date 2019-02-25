

--UserRole

CREATE TABLE UserRole(
RoleId NVarchar(100) PRIMARY KEY,
RoleName NVarchar(100) NOT NULL,
IsDefault BIT DEFAULT 0
)


--Users

CREATE TABLE "User"(
UserID INT IDENTITY(1,1) PRIMARY KEY,
UserName NVarchar(100),
UserPassword NVarchar(100),
RoleId NVarchar(100) NULL,
CONSTRAINT FK_UserInRole FOREIGN KEY (RoleId) REFERENCES UserRole(RoleId),
CONSTRAINT UK_Users_UserName UNIQUE (UserName)
)


-- Region Office

CREATE TABLE RegionOffice(
ROfficeID int IDENTITY(1,1) PRIMARY KEY,
ROffice_Name NVarchar(100),
ROffice_Desc NVarchar(100),
ROffice_StreeNumber NVarchar(20),
ROffice_StreetName NVarchar(100),
ROffice_Area NVarchar(100),
ROffice_City NVarchar(100),
ROffice_Region NVarchar(100),
ROffice_PostalCode NVarchar(100)
)



--Staff table

CREATE TABLE Staff(
StaffID int IDENTITY(1,1) PRIMARY KEY,
Staff_PNumber NVarchar(100),
Staff_FName NVarchar(100),
Staff_LName NVarchar(100),
Staff_IDNumber NVarchar(20),
Staff_Type NVarchar(50),
Staff_Income DECIMAL(18,2),
ManagerID int NULL,
ROfficeID int ,
CONSTRAINT FK_UserManager FOREIGN KEY (ManagerID) REFERENCES Staff(StaffID),
CONSTRAINT FK_UserRegion FOREIGN KEY (ROfficeID) REFERENCES RegionOffice(ROfficeID)
)



-- ManagerRole

CREATE TABLE ManagerRole(
ManagerRoleId int IDENTITY(1,1) PRIMARY KEY,
MRole_Desc NVarchar(100)
)


--Manager

CREATE TABLE Manager(
StaffID int PRIMARY KEY,
ManagerRoleId int NULL,
Man_StaffManaged NVarchar(100),
CONSTRAINT FK_StaffManger FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
CONSTRAINT FK_MangerRole FOREIGN KEY (ManagerRoleId) REFERENCES ManagerRole(ManagerRoleId)
)


--Degree

CREATE TABLE Degree(
DegreeID int IDENTITY(1,1) PRIMARY KEY,
DegreeName NVarchar(100),
DegreeDesc NVarchar(100),
)


--Engineer

CREATE TABLE Engineer(
StaffID int PRIMARY KEY,
Eng_YearsOfExperience int,
DegreeID INT,
CONSTRAINT FK_StaffEngineer FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
CONSTRAINT FK_EngineerExperience FOREIGN KEY (DegreeID) REFERENCES Degree(DegreeID)
)

--SupportRole

CREATE TABLE SupportRole(
SupportRoleID int IDENTITY(1,1) PRIMARY KEY,
SRole_Desc NVarchar(100)
)

-- Support

CREATE TABLE Support(
StaffID int PRIMARY KEY,
SupportRoleId int,
CONSTRAINT FK_StaffSupport FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
CONSTRAINT FK_StaffSupportRole FOREIGN KEY (SupportRoleId) REFERENCES SupportRole(SupportRoleId)
)


--Benefit

CREATE TABLE Benefit(
BenefitID int IDENTITY(1,1) PRIMARY KEY,
Benefit_Name NVarchar(50),
Benefit_Desc NVarchar(100)
)

--Staff Benefit

CREATE TABLE Benefit_Staff(
BenefitID INT,
StaffID int,
DateAssigned DateTimeOffset NOT NULL DEFAULT SYSDATETIMEOFFSET(),
CONSTRAINT PK_StaffBenefit PRIMARY KEY (BenefitID,StaffID),
CONSTRAINT FK_StaffBenefit FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
CONSTRAINT FK_BenefitStaff FOREIGN KEY (BenefitID) REFERENCES Benefit(BenefitID)
)

--Customer

CREATE TABLE Customer(
CustomerID NVarchar(20) PRIMARY KEY,
Cus_EAccount NVarchar(50),
Cus_FName NVarchar(50),
Cus_LName NVarchar(50),
Cus_ContactNumber NVarchar(20),
Cus_Email NVarchar(100),
Cus_BankAccNumber NVarchar(20),
Cus_BankCode NVarchar(10),
Cus_StreetNumber NVarchar(50),
Cus_StreetName NVarchar(100),
Cus_Area NVarchar(100),
Cus_City NVarchar(100),
Cus_Region NVarchar(100),
Cus_PostalCode NVarchar(50),
Cus_ProfilePic NVarchar(200),
)

--DriverLicense

CREATE TABLE DriverLicense(
CustomerID NVarchar(20) PRIMARY KEY,
DLicense_Number NVarchar(50),
DLicense_ExpireDate DATE,
CONSTRAINT FK_StaffLicense FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)


--TollTag

CREATE TABLE TollTag(
TTagID int IDENTITY(1,1) PRIMARY KEY,
TTag_RFIDNumber NVarchar(20),
TTag_ManufactureDate DateTimeOffset NOT NULL default SYSDATETIMEOFFSET(),
TTag_Brand NVarchar(100),
CT_AssignedDate DATETIME,
CT_IsActive BIT DEFAULT 1,
CustomerID NVarchar(20)
CONSTRAINT FK_CustomerToll FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)

--Municipality

CREATE TABLE Municipality(
MunID int IDENTITY(1,1) PRIMARY KEY,
Mun_Name NVarchar(50),
Mun_Desc NVarchar(100)
)


--VehicleRegistration

CREATE TABLE VehicleRegistration(
VehicleID int IDENTITY(1,1) PRIMARY KEY,
Vehicle_Name NVarchar(50),
Vehicle_Desc NVarchar(100),
Vehicle_Registration NVarchar(20),
CustomerID NVarchar(20) NOT NULL,
MunID INT NOT NULL,
CONSTRAINT FK_CustomerVehicle FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT FK_VehicleMunicipality FOREIGN KEY (MunID) REFERENCES Municipality(MunID),
CONSTRAINT UK_VehicleRegistration UNIQUE(Vehicle_Registration)
)


--Fines

CREATE TABLE Fines(
FineID int IDENTITY(1,1) PRIMARY KEY,
Fine_Name NVarchar(50),
Fine_Desc NVarchar(100),
Fine_Amount DECIMAL(18,2),
Fine_IsDefault BIT DEFAULT 0
)


--VehicleFine

CREATE TABLE VehicleFine(
Vehicle_FineId int IDENTITY(1,1) PRIMARY KEY,
VF_DateTime DateTimeOffset NOT NULL default SYSDATETIMEOFFSET(),
VF_IsPaid BIT DEFAULT 0,
VehicleID INT NOT NULL,
FineID INT NOT NULL,
CONSTRAINT FK_VehicleFineRegistration FOREIGN KEY (VehicleID) REFERENCES VehicleRegistration(VehicleID),
CONSTRAINT FK_VehicleFine FOREIGN KEY (FineID) REFERENCES Fines(FineID)
)


--TollRate

CREATE TABLE TollRate(
TRateID int IDENTITY(1,1) PRIMARY KEY,
TRateName NVarchar(50),
TRateDesc NVarchar(100),
TRateAmount DECIMAL(18,2)
)

--DiscountRate

CREATE TABLE DiscountRate(
DRateID int IDENTITY(1,1) PRIMARY KEY,
DRate_StartDateTime DATETIME,
DRate_EndDateTime DATETIME,
DRate_Percentage DECIMAL(18,2)
)

--PaymentMethod

CREATE TABLE PaymentMethod(
PayMethodID int IDENTITY(1,1) PRIMARY KEY,
PayMethodDesc NVarchar(100),
PayMethod_ClearTime DATETIME
)


--Payments

CREATE TABLE Payment(
PayID int IDENTITY(1,1) PRIMARY KEY,
Pay_DateTime DateTimeOffset NOT NULL default SYSDATETIMEOFFSET(),
Pay_Amount DECIMAL(18,2),
PayMethodID int,
CONSTRAINT FK_PaymentMethod FOREIGN KEY (PayMethodID) REFERENCES PaymentMethod(PayMethodID)
)


--Gantry


CREATE TABLE Gantry(
GantryID int IDENTITY(1,1) PRIMARY KEY,
Gantry_Name NVarchar(100),
Gantry_Desc NVarchar(100),
Gantry_GPSLocation NVarchar(200),
ROfficeID INT NOT NULL,
TRateID INT NOT NULL,
CONSTRAINT FK_GantryOffice FOREIGN KEY (ROfficeID) REFERENCES RegionOffice(ROfficeID),
CONSTRAINT FK_GantryTollRate FOREIGN KEY (TRateID) REFERENCES TollRate(TRateID)
)


--TollTransaction

CREATE TABLE TollTransaction(
TTID int IDENTITY(1,1) PRIMARY KEY,
TT_DateTime DateTimeOffset NOT NULL default SYSDATETIMEOFFSET(),
TT_Amount DECIMAL(18,2),
TT_IsPaid BIT DEFAULT 0,
TT_OnDiscount BIT DEFAULT 0,
TT_VehicleRegistration Nvarchar(20),
TTagID INT DEFAULT -1,
PayID INT,
DRateID INT,
GantryID INT NOT NULL,
CONSTRAINT FK_TTransactionTollTag FOREIGN KEY (TTagID) REFERENCES TollTag(TTagID),
CONSTRAINT FK_TTransactionPayment FOREIGN KEY (PayID) REFERENCES Payment(PayID),
CONSTRAINT FK_TTransactionTollRate FOREIGN KEY (DRateID) REFERENCES DiscountRate(DRateID),
CONSTRAINT FK_TTransactionGantry FOREIGN KEY (GantryID) REFERENCES Gantry(GantryID)
)


-- AuditTrailId

CREATE TABLE AuditTrailId(
AuditTrain_Id int IDENTITY(1,1) PRIMARY KEY,
AuditTrail_TableAffected NVarchar(100),
AuditTrail_PreviousValue NVarchar(100),
AutiTrail_NewValue NVarchar(100),
AuditTrail_UserId NVarchar(100)
)

--Constraints

ALTER TABLE Customer 
ADD CONSTRAINT UK_CustomerEmail UNIQUE (Cus_Email); 

ALTER TABLE DriverLicense 
ADD CONSTRAINT UK_DriverLicenseNumber UNIQUE (DLicense_Number); 

ALTER TABLE TollTag 
ADD CONSTRAINT UK_TagRFIDNumber UNIQUE (TTag_RFIDNumber); 

ALTER TABLE Staff 
ADD CONSTRAINT UK_StaffIDNumber UNIQUE (Staff_IDNumber); 


