-- Table: Yelp_User
CREATE TABLE Yelp_User (
    Yelp_Id varchar2(10)  NOT NULL,
    First_Name varchar2(50)  NOT NULL,
    Last_Name varchar2(50)  NOT NULL,
    Birthdate date  NOT NULL,
    Birth_Place varchar2(2)  NOT NULL,
    Gender varchar2(1) NOT NULL,
    Email varchar2(50)  NOT NULL,
    CONSTRAINT Yelp_User_pk PRIMARY KEY (Yelp_Id)
) ;


-- Table: Review
CREATE TABLE Reviews (
    Review_Id varchar2(10)  NOT NULL,
    Number_of_Stars number  NOT NULL,
    Yelp_Id varchar2(10)  NOT NULL,
    Publish_Date date  NOT NULL,
    Business_Id varchar2(10) NOT NULL,
    Text_Content  varchar2(4000) NOT NULL,
    CONSTRAINT Review_pk PRIMARY KEY (Review_Id)
) ;


-- Table: Ambient_Type
CREATE TABLE Ambient_Type (
    Ambient_Type_Id number  NOT NULL,
    Ambient_Type_Name varchar2(50)  NOT NULL,
    CONSTRAINT Ambient_Type_pk PRIMARY KEY (Ambient_Type_Id)
) ;


-- Table: Business
CREATE TABLE Business (
    Business_Id varchar2(10)  NOT NULL,
    Business_Name varchar2(50)  NOT NULL,
    Street_Address varchar2(50)  NOT NULL,
    City varchar2(50) NOT NULL,
    State varchar2(2)  NOT NULL,
    Zip_Code number  NOT NULL,
    Parking_Type_Id number  NOT NULL,
    Ambient_Type_Id number  NOT NULL,
    Business_Category_Id varchar2(10)  NOT NULL,
    CONSTRAINT Business_pk PRIMARY KEY (Business_Id)
) ;

    
-- Table: User_Business_Check_In
CREATE TABLE User_Business_Check_In (
    User_Business_Check_In_Id number  NOT NULL,
    Yelp_Id varchar2(10)  NOT NULL,
    Business_Id varchar2(10)  NOT NULL,
    CONSTRAINT User_Business_Check_In_pk PRIMARY KEY (User_Business_Check_In_Id)
) ;

    
-- Table: Business_Category
CREATE TABLE Business_Category (
    Business_Category_Id varchar2(10)  NOT NULL,
    Business_Category_Name varchar2(50)  NOT NULL,
    CONSTRAINT Business_Category_pk PRIMARY KEY (Business_Category_Id)
) ;


-- Table: Business_Operation_Days
CREATE TABLE Business_Operation_Days (
    Business_Id varchar2(10)  NOT NULL,
    Day_of_week varchar2(3)  NOT NULL,
    CONSTRAINT Business_Operation_Days_pk PRIMARY KEY (Day_of_week,Business_Id)
) ;


-- Table: Business_Subcategories
CREATE TABLE Business_Subcategories (
    Business_Category_Id varchar2(10)  NOT NULL,
    Business_Subcategory_Name varchar2(50)  NOT NULL,
    CONSTRAINT Business_Subcategories_pk PRIMARY KEY (Business_Subcategory_Name,Business_Category_Id)
) ;


-- Table: Parking_Type
CREATE TABLE Parking_Type (
    Parking_Type_Id number  NOT NULL,
    Parking_Type_Name varchar2(50)  NOT NULL,
    CONSTRAINT Parking_Type_pk PRIMARY KEY (Parking_Type_Id)
) ;


-- Table: Vote_Category
CREATE TABLE Vote_Category (
    Vote_Category_Id number  NOT NULL,
    Vote_Category_Name varchar2(50)  NOT NULL,
    CONSTRAINT Vote_Category_pk PRIMARY KEY (Vote_Category_Id)
) ;


-- Table: Review_Votes
CREATE TABLE Review_Votes (
    Review_Votes_Id number  NOT NULL,
    Review_Id varchar2(10)  NOT NULL,
    Yelp_Id varchar2(10)  NOT NULL,
    Vote_Category_Id number  NOT NULL,
    CONSTRAINT Review_Votes_pk PRIMARY KEY (Review_Votes_Id)
) ;

-- Table: User_Friends
CREATE TABLE User_Friends (
    Yelp_Id varchar2(10)  NOT NULL,
    Friend_Yelp_Id varchar2(10)  NOT NULL,
    Follow_Indicator varchar2(1)  NOT NULL,
    Complimented_Indicator varchar2(1)  NOT NULL,
    CONSTRAINT User_Friends_pk PRIMARY KEY (Yelp_Id,Friend_Yelp_Id)
) ;

-- Table: Review_Comments
CREATE TABLE Review_Comments (
    Review_Comment_Id number NOT NULL,
    Review_Id varchar2(10) NOT NULL,
    Yelp_Id varchar2(10) NOT NULL,
    Textual_Content varchar2(500) NOT NULL,
    Date_Created date NOT NULL,
    CONSTRAINT Review_Comments_pk PRIMARY KEY (Review_Comment_Id)
) ;

--==============================================

-- Reference: Review_Votes_Review (table: Review_Votes)
ALTER TABLE Review_Votes ADD CONSTRAINT Review_Votes_Review
    FOREIGN KEY (Review_Id)
    REFERENCES Reviews (Review_Id)
    ON DELETE CASCADE;

-- Reference: Review_Votes_Vote_Category (table: Review_Votes)
ALTER TABLE Review_Votes ADD CONSTRAINT Review_Votes_Vote_Category
    FOREIGN KEY (Vote_Category_Id)
    REFERENCES Vote_Category (Vote_Category_Id);

-- Reference: Review_Votes_Yelp_User (table: Review_Votes)
ALTER TABLE Review_Votes ADD CONSTRAINT Review_Votes_Yelp_User
    FOREIGN KEY (Yelp_Id)
    REFERENCES Yelp_User (Yelp_Id)
    ON DELETE CASCADE;

-- Reference: Business_Subcat_Category (table: Business_Subcategories)
ALTER TABLE Business_Subcategories ADD CONSTRAINT Business_Subcat_Category
    FOREIGN KEY (Business_Category_Id)
    REFERENCES Business_Category (Business_Category_Id)
    ON DELETE CASCADE;

-- Reference: Operation_Days_Business (table: Business_Operation_Days)
ALTER TABLE Business_Operation_Days ADD CONSTRAINT Operation_Days_Business
    FOREIGN KEY (Business_Id)
    REFERENCES Business (Business_Id)
    ON DELETE CASCADE;

-- Reference: Business_CheckIn_Yelp_User (table: User_Business_Check_In)
ALTER TABLE User_Business_Check_In ADD CONSTRAINT Business_CheckIn_Yelp_User
    FOREIGN KEY (Yelp_Id)
    REFERENCES Yelp_User (Yelp_Id)
    ON DELETE CASCADE;
    

-- Reference: User_Business_Check_In (table: User_Business_Check_In)
ALTER TABLE User_Business_Check_In ADD CONSTRAINT User_Business_Check_In
    FOREIGN KEY (Business_Id)
    REFERENCES Business (Business_Id)
    ON DELETE CASCADE;

-- Reference: Business_Ambient_Type (table: Business)
ALTER TABLE Business ADD CONSTRAINT Business_Ambient_Type
    FOREIGN KEY (Ambient_Type_Id)
    REFERENCES Ambient_Type (Ambient_Type_Id);


-- Reference: Business_Business_Category (table: Business)
ALTER TABLE Business ADD CONSTRAINT Business_Business_Category
    FOREIGN KEY (Business_Category_Id)
    REFERENCES Business_Category (Business_Category_Id);
    

-- Reference: Business_Parking_Type (table: Business)
ALTER TABLE Business ADD CONSTRAINT Business_Parking_Type
    FOREIGN KEY (Parking_Type_Id)
    REFERENCES Parking_Type (Parking_Type_Id);

-- Reference: Review_Yelp_User (table: Review)
ALTER TABLE Reviews ADD CONSTRAINT Review_Yelp_User
    FOREIGN KEY (Yelp_Id)
    REFERENCES Yelp_User (Yelp_Id)
    ON DELETE CASCADE;
    
-- Reference: Review_Yelp_User (table: Review)
ALTER TABLE Reviews ADD CONSTRAINT Business_Reviewed
    FOREIGN KEY (Business_Id)
    REFERENCES Business (Business_Id)
    ON DELETE CASCADE;
    
-- Reference: User_Friends_Yelp_User (table: User_Friends)
ALTER TABLE User_Friends ADD CONSTRAINT User_Friends_Yelp_User
    FOREIGN KEY (Yelp_Id)
    REFERENCES Yelp_User (Yelp_Id)
    ON DELETE CASCADE;

-- Reference: Yelp_User_Friend (table: User_Friends)
ALTER TABLE User_Friends ADD CONSTRAINT Yelp_User_Friend
    FOREIGN KEY (Friend_Yelp_Id)
    REFERENCES Yelp_User (Yelp_Id)
    ON DELETE CASCADE;

ALTER TABLE Review_Comments ADD CONSTRAINT Review_Comments_Review
    FOREIGN KEY (Review_Id)
    REFERENCES Reviews (Review_Id)
    ON DELETE CASCADE;

ALTER TABLE Review_Comments ADD CONSTRAINT Review_Comments_Yelp_User
    FOREIGN KEY (Yelp_Id)
    REFERENCES Yelp_User (Yelp_Id)
    ON DELETE CASCADE;


-- INSERT INTO Parking type table
INSERT INTO Parking_Type values(1, 'Street');
INSERT INTO Parking_Type values(2, 'Garage');
INSERT INTO Parking_Type values(3, 'Lot');
INSERT INTO Parking_Type values(4, 'Valet');


-- INSERT INTO Ambient Type table
INSERT INTO Ambient_Type values(1, 'Romantic');
INSERT INTO Ambient_Type values(2, 'Classy');
INSERT INTO Ambient_Type values(3, 'Touristy');
INSERT INTO Ambient_Type values(4, 'Casual');


-- INSERT INTO Vote Category table
INSERT INTO Vote_Category values(1, 'Useful');
INSERT INTO Vote_Category values(0, 'Non-useful');


-- INSERT INTO Business Category table
INSERT INTO Business_Category values('BCT1', 'Amusement Parks');
INSERT INTO Business_Category values('BCT2', 'National Parks');
INSERT INTO Business_Category values('BCT3', 'Career Counseling');
INSERT INTO Business_Category values('BCT4', 'Food and More');
INSERT INTO Business_Category values('BCT5', 'Bars');
INSERT INTO Business_Category values('BCT6', 'Restaurants');
INSERT INTO Business_Category values('BCT7', 'Pool Cleaners');
INSERT INTO Business_Category values('BCT8', 'Coffee Shops');


-- INSERT INTO Business Sub-category table
INSERT INTO Business_Subcategories values('BCT1', 'Water Parks');
INSERT INTO Business_Subcategories values('BCT2', 'Wildlife National Parks');
INSERT INTO Business_Subcategories values('BCT3', 'Career Counseling for kids');
INSERT INTO Business_Subcategories values('BCT4', 'Ice-cream');
INSERT INTO Business_Subcategories values('BCT4', 'Yogurt');
INSERT INTO Business_Subcategories values('BCT5', 'Sports Bar');
INSERT INTO Business_Subcategories values('BCT6', 'Ice-cream');
INSERT INTO Business_Subcategories values('BCT6', 'Yogurt');
INSERT INTO Business_Subcategories values('BCT7', 'Swimming Pool Cleaners');
INSERT INTO Business_Subcategories values('BCT8', 'Cold Coffee Shops');


-- INSERT INTO Yelp User table
INSERT INTO Yelp_User values('Y1', 'John', 'Smith', TO_DATE('12/12/1992','MM/DD/YYYY'), 'FL', 'M', 'john@yahoo.com');
INSERT INTO Yelp_User values('Y2', 'Juan', 'Carlos', TO_DATE('02/07/1988','MM/DD/YYYY'), 'AK', 'M', 'juan@gmail.com');
INSERT INTO Yelp_User values('Y3', 'Jane', 'Chapel', TO_DATE('06/01/1980','MM/DD/YYYY'), 'IL', 'F', 'jane@gmail.com');
INSERT INTO Yelp_User values('Y4', 'Aditya', 'Awasthi', TO_DATE('04/12/1994','MM/DD/YYYY'), 'CA', 'M', 'adi@yahoo.com');
INSERT INTO Yelp_User values('Y5', 'James', 'Williams', TO_DATE('05/05/1991','MM/DD/YYYY'), 'NY', 'M', 'james@hotmail.com');
INSERT INTO Yelp_User values('Y6', 'Mike', 'Brown', TO_DATE('03/01/1988','MM/DD/YYYY'), 'NC', 'M', 'mike@yahoo.com');
INSERT INTO Yelp_User values('Y7', 'Bob', 'Jones', TO_DATE('02/19/1970','MM/DD/YYYY'), 'NY', 'M', 'bob@yahoo.com');
INSERT INTO Yelp_User values('Y8', 'Wei', 'Zhang', TO_DATE('03/18/1975','MM/DD/YYYY'), 'NV', 'F', 'wei@gmail.com');
INSERT INTO Yelp_User values('Y9', 'Mark', 'Davis', TO_DATE('11/02/1993','MM/DD/YYYY'), 'CA', 'M', 'mark@gmail.com');
INSERT INTO Yelp_User values('Y10', 'Daniel', 'Garcia', TO_DATE('05/10/1984','MM/DD/YYYY'), 'NJ', 'M', 'daniel@yahoo.com');
INSERT INTO Yelp_User values('Y11', 'Maria', 'Rodriguez', TO_DATE('08/12/1985','MM/DD/YYYY'), 'CA', 'F', 'maria@gmail.com');
INSERT INTO Yelp_User values('Y12', 'Freya', 'Wilson', TO_DATE('10/05/1995','MM/DD/YYYY'), 'NJ', 'F', 'freya@yahoo.com');


-- INSERT INTO Business table
INSERT INTO Business values('B1', 'Big Surf', '1500 N McClintock Dr', 'Tempe', 'AZ', 85281, 1, 3, 'BCT1');
INSERT INTO Business values('B2', 'Smith Thomson', '1595 Spring Hill Road Suite 110', 'Vienna', 'VA', 22182, 1, 3, 'BCT6');
INSERT INTO Business values('B3', 'Bay Area Coffee Shop', '1522 W.Sam Rayburn Dr.', 'Bonham', 'CA', 95051, 1, 3, 'BCT8');
INSERT INTO Business values('B4', 'China Coffee Toffee', '2570 El Camino Real', 'Santa Clara', 'CA', 95051, 1, 3, 'BCT4');
INSERT INTO Business values('B5', 'Hastings Water Works', '10331 Brecksville Road', 'Brecksville', 'OH', 44141, 1, 2, 'BCT7');
INSERT INTO Business values('B6', 'Catch Your Big Break', '2341 Roosevelt Ct', 'Santa Clara', 'CA', 95051, 1, 2, 'BCT3');
INSERT INTO Business values('B7', 'The Cinebar', '20285 South Western Ave. Suite #200', 'Torrance', 'CA', 90501, 1, 2, 'BCT5');
INSERT INTO Business values('B8', 'Coffee Bar and Bistro', '2585 El Camino Real', 'Santa Clara', 'CA', 90501, 1, 2, 'BCT5');
INSERT INTO Business values('B9', 'Hobees', '90 Skyport Dr', 'San Jose', 'CA', 95110, 1, 2, 'BCT6');
INSERT INTO Business values('B10', 'Cafe Gourmet', '80 N Market St', 'San Jose', 'CA', 95113, 1, 2, 'BCT6');
INSERT INTO Business values('B11', 'Yellow Stone National Park', 'Yellow Stone National Park', 'Yellowstone', 'WY', 82190, 1, 2, 'BCT2');
INSERT INTO Business values('B12', 'Petrified Forest National Park', 'P.O Box 221', 'Phoenix', 'AZ', 86028, 1, 2, 'BCT2');
INSERT INTO Business values('B13', 'Grand Canyon National Park', 'Highway 64', 'Tempe', 'AZ', 86023, 1, 2, 'BCT2');
INSERT INTO Business values('B35', 'Connecticut Bar', '5847 San Felipe, Suite 2400', 'Houston', 'TX', 77057, 1, 2, 'BCT5');
INSERT INTO Business values('B36', 'Sherleys Bar and Restaurant', '1132 Terry Road', 'Hartford', 'CT', 06105, 1, 2, 'BCT5');
INSERT INTO Business values('B14', 'Connecticut Bar and Restaurant', '1133 Terry Road', 'Hartford', 'CT', 06105, 1, 2, 'BCT5');


-- INSERT INTO Review table
INSERT INTO Reviews values('R1', 3, 'Y11', to_timestamp_tz('Oct-02-07 09:10:54 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B3', 'Very good');
INSERT INTO Reviews values('R2', 2, 'Y10', to_timestamp_tz('Sep-29-07 13:45:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B1', 'Just ok');
INSERT INTO Reviews values('R3', 4, 'Y2', to_timestamp_tz('Sep-29-07 10:38:25 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B10', 'Very good');
INSERT INTO Reviews values('R4', 5, 'Y11', to_timestamp_tz('Oct-02-07 13:05:56 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B4', 'Very good');
INSERT INTO Reviews values('R5', 5, 'Y1', to_timestamp_tz('Oct-25-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B3', 'Very good');
INSERT INTO Reviews values('R6', 5, 'Y4', to_timestamp_tz('Sep-26-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B4', 'Very good');
INSERT INTO Reviews values('R7', 5, 'Y9', to_timestamp_tz('Sep-26-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B5', 'Very good');
INSERT INTO Reviews values('R8', 5, 'Y5', to_timestamp_tz('Sep-27-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B6', 'Very good');
INSERT INTO Reviews values('R9', 5, 'Y12', to_timestamp_tz('Sep-28-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B7', 'Just ok');
INSERT INTO Reviews values('R10', 5, 'Y5', to_timestamp_tz('Oct-29-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B8', 'Not good');
INSERT INTO Reviews values('R11', 5, 'Y1', to_timestamp_tz('Sep-30-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B9', 'Not good');
INSERT INTO Reviews values('R12', 5, 'Y12', to_timestamp_tz('Oct-25-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B10', 'Very good');
INSERT INTO Reviews values('R13', 5, 'Y4', to_timestamp_tz('Sep-25-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B11', 'Very good');
INSERT INTO Reviews values('R14', 5, 'Y5', to_timestamp_tz('Sep-25-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B12', 'Very good');
INSERT INTO Reviews values('R15', 5, 'Y1', to_timestamp_tz('Sep-29-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B13', 'Not good');
INSERT INTO Reviews values('R16', 2, 'Y11', to_timestamp_tz('Jun-07-15 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B2', 'Very good');
INSERT INTO Reviews values('R17', 1, 'Y4', to_timestamp_tz('May-05-15 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B2', 'Very good');
INSERT INTO Reviews values('R18', 1, 'Y1', to_timestamp_tz('May-05-15 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B2', 'Very good');
INSERT INTO Reviews values('R19', 1, 'Y10', to_timestamp_tz('Oct-25-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B3', 'Very good');
INSERT INTO Reviews values('R20', 1, 'Y1', to_timestamp_tz('Sep-28-07 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B4', 'Very good');
INSERT INTO Reviews values('R21', 4, 'Y11', to_timestamp_tz('Jun-07-15 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B14', 'Not good');
INSERT INTO Reviews values('R22', 1, 'Y4', to_timestamp_tz('May-05-15 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B14', 'Just ok');
INSERT INTO Reviews values('R23', 1, 'Y1', to_timestamp_tz('May-05-15 17:15:00 PDT','Mon-DD-YY HH24:MI:SS TZD'), 'B14', 'Not good');

--INSERT INTO Review Votes
INSERT INTO Review_Votes values(1, 'R1', 'Y11', 1);
INSERT INTO Review_Votes values(2, 'R2', 'Y10', 1);
INSERT INTO Review_Votes values(3, 'R3', 'Y2', 0);
INSERT INTO Review_Votes values(4, 'R4', 'Y11', 0);
INSERT INTO Review_Votes values(5, 'R5', 'Y1', 0);
INSERT INTO Review_Votes values(6, 'R6', 'Y4', 1);
INSERT INTO Review_Votes values(7, 'R7', 'Y9', 1);
INSERT INTO Review_Votes values(8, 'R8', 'Y5', 0);
INSERT INTO Review_Votes values(9, 'R9', 'Y12', 0);
INSERT INTO Review_Votes values(10, 'R10', 'Y5', 0);
INSERT INTO Review_Votes values(11, 'R11', 'Y1', 1);
INSERT INTO Review_Votes values(12, 'R12', 'Y12', 1);
INSERT INTO Review_Votes values(13, 'R13', 'Y4', 1);
INSERT INTO Review_Votes values(14, 'R14', 'Y5', 1);
INSERT INTO Review_Votes values(15, 'R15', 'Y1', 0);
INSERT INTO Review_Votes values(16, 'R16', 'Y11', 0);
INSERT INTO Review_Votes values(17, 'R17', 'Y4', 1);
INSERT INTO Review_Votes values(18, 'R18', 'Y1', 1);
INSERT INTO Review_Votes values(19, 'R19', 'Y10', 0);
INSERT INTO Review_Votes values(20, 'R20', 'Y1', 1);
INSERT INTO Review_Votes values(21, 'R21', 'Y11', 0);
INSERT INTO Review_Votes values(22, 'R22', 'Y4', 1);
INSERT INTO Review_Votes values(23, 'R23', 'Y1', 0);

--INSERT INTO USER FRIENDS
INSERT INTO User_Friends values('Y1', 'Y2', 'Y', 'Y');
INSERT INTO User_Friends values('Y1', 'Y7', 'Y', 'Y');
INSERT INTO User_Friends values('Y1', 'Y9', 'N', 'N');
INSERT INTO User_Friends values('Y3', 'Y6', 'Y', 'Y');
INSERT INTO User_Friends values('Y3', 'Y11', 'Y', 'Y');
INSERT INTO User_Friends values('Y3', 'Y5', 'N', 'N');
INSERT INTO User_Friends values('Y4', 'Y7', 'Y', 'Y');
INSERT INTO User_Friends values('Y4', 'Y11', 'Y', 'Y');
INSERT INTO User_Friends values('Y6', 'Y2', 'Y', 'Y');
INSERT INTO User_Friends values('Y6', 'Y4', 'Y', 'Y');
INSERT INTO User_Friends values('Y7', 'Y1', 'Y', 'Y');
INSERT INTO User_Friends values('Y7', 'Y3', 'Y', 'Y');
INSERT INTO User_Friends values('Y8', 'Y6', 'Y', 'Y');
INSERT INTO User_Friends values('Y8', 'Y1', 'Y', 'Y');
INSERT INTO User_Friends values('Y9', 'Y1', 'Y', 'Y');
INSERT INTO User_Friends values('Y9', 'Y2', 'Y', 'Y');
INSERT INTO User_Friends values('Y11', 'Y3', 'Y', 'Y');
INSERT INTO User_Friends values('Y11', 'Y5', 'Y', 'Y');
INSERT INTO User_Friends values('Y12', 'Y11', 'Y', 'Y');


--INSERT INTO USER BUSINESS CHECK IN
INSERT INTO User_Business_Check_In values(1, 'Y1', 'B3');
INSERT INTO User_Business_Check_In values(2, 'Y1', 'B2');
INSERT INTO User_Business_Check_In values(3, 'Y1', 'B13');
INSERT INTO User_Business_Check_In values(4, 'Y1', 'B35');
INSERT INTO User_Business_Check_In values(5, 'Y1', 'B36');
INSERT INTO User_Business_Check_In values(6, 'Y1', 'B5');
INSERT INTO User_Business_Check_In values(7, 'Y1', 'B4');
INSERT INTO User_Business_Check_In values(8, 'Y1', 'B9');

INSERT INTO User_Business_Check_In values(9, 'Y2', 'B10');
INSERT INTO User_Business_Check_In values(10, 'Y2', 'B5');
INSERT INTO User_Business_Check_In values(11, 'Y2', 'B11');
INSERT INTO User_Business_Check_In values(12, 'Y2', 'B2');
INSERT INTO User_Business_Check_In values(13, 'Y2', 'B36');
INSERT INTO User_Business_Check_In values(14, 'Y2', 'B35');

INSERT INTO User_Business_Check_In values(15, 'Y4', 'B4');
INSERT INTO User_Business_Check_In values(16, 'Y4', 'B11');
INSERT INTO User_Business_Check_In values(17, 'Y4', 'B12');
INSERT INTO User_Business_Check_In values(18, 'Y4', 'B5');
INSERT INTO User_Business_Check_In values(19, 'Y4', 'B36');
INSERT INTO User_Business_Check_In values(20, 'Y4', 'B35');
INSERT INTO User_Business_Check_In values(21, 'Y4', 'B2');

INSERT INTO User_Business_Check_In values(22, 'Y5', 'B6');
INSERT INTO User_Business_Check_In values(23, 'Y5', 'B11');
INSERT INTO User_Business_Check_In values(24, 'Y5', 'B12');
INSERT INTO User_Business_Check_In values(25, 'Y5', 'B5');
INSERT INTO User_Business_Check_In values(26, 'Y5', 'B36');
INSERT INTO User_Business_Check_In values(27, 'Y5', 'B35');
INSERT INTO User_Business_Check_In values(28, 'Y5', 'B8');

INSERT INTO User_Business_Check_In values(29, 'Y6', 'B36');
INSERT INTO User_Business_Check_In values(30, 'Y6', 'B11');
INSERT INTO User_Business_Check_In values(31, 'Y6', 'B2');
INSERT INTO User_Business_Check_In values(32, 'Y6', 'B3');
INSERT INTO User_Business_Check_In values(33, 'Y6', 'B13');

INSERT INTO User_Business_Check_In values(34, 'Y7', 'B13');
INSERT INTO User_Business_Check_In values(35, 'Y7', 'B35');
INSERT INTO User_Business_Check_In values(36, 'Y7', 'B36');
INSERT INTO User_Business_Check_In values(37, 'Y7', 'B11');
INSERT INTO User_Business_Check_In values(38, 'Y7', 'B2');
INSERT INTO User_Business_Check_In values(39, 'Y7', 'B3');

INSERT INTO User_Business_Check_In values(40, 'Y8', 'B11');
INSERT INTO User_Business_Check_In values(41, 'Y8', 'B2');
INSERT INTO User_Business_Check_In values(42, 'Y8', 'B13');
INSERT INTO User_Business_Check_In values(43, 'Y8', 'B35');
INSERT INTO User_Business_Check_In values(44, 'Y8', 'B36');
INSERT INTO User_Business_Check_In values(45, 'Y8', 'B4');

INSERT INTO User_Business_Check_In values(46, 'Y9', 'B5');
INSERT INTO User_Business_Check_In values(47, 'Y9', 'B11');
INSERT INTO User_Business_Check_In values(48, 'Y9', 'B2');
INSERT INTO User_Business_Check_In values(49, 'Y9', 'B13');
INSERT INTO User_Business_Check_In values(50, 'Y9', 'B35');
INSERT INTO User_Business_Check_In values(51, 'Y9', 'B36');

INSERT INTO User_Business_Check_In values(52, 'Y10', 'B1');
INSERT INTO User_Business_Check_In values(53, 'Y10', 'B5');
INSERT INTO User_Business_Check_In values(54, 'Y10', 'B11');
INSERT INTO User_Business_Check_In values(55, 'Y10', 'B2');
INSERT INTO User_Business_Check_In values(56, 'Y10', 'B36');
INSERT INTO User_Business_Check_In values(57, 'Y10', 'B35');
INSERT INTO User_Business_Check_In values(58, 'Y10', 'B3');

INSERT INTO User_Business_Check_In values(59, 'Y11', 'B3');
INSERT INTO User_Business_Check_In values(60, 'Y11', 'B4');
INSERT INTO User_Business_Check_In values(61, 'Y11', 'B1');
INSERT INTO User_Business_Check_In values(62, 'Y11', 'B5');
INSERT INTO User_Business_Check_In values(63, 'Y11', 'B11');
INSERT INTO User_Business_Check_In values(64, 'Y11', 'B2');
INSERT INTO User_Business_Check_In values(65, 'Y11', 'B36');
INSERT INTO User_Business_Check_In values(66, 'Y11', 'B35');

INSERT INTO User_Business_Check_In values(67, 'Y12', 'B7');
INSERT INTO User_Business_Check_In values(68, 'Y12', 'B10');
INSERT INTO User_Business_Check_In values(69, 'Y12', 'B5');
INSERT INTO User_Business_Check_In values(70, 'Y12', 'B11');
INSERT INTO User_Business_Check_In values(71, 'Y12', 'B2');
INSERT INTO User_Business_Check_In values(72, 'Y12', 'B13');
INSERT INTO User_Business_Check_In values(73, 'Y12', 'B35');
INSERT INTO User_Business_Check_In values(74, 'Y12', 'B36');


-- INSERT INTO Business Operation days table (id, day of week)
INSERT INTO Business_Operation_Days values('B1', 'Mon');
INSERT INTO Business_Operation_Days values('B1', 'Tue');
INSERT INTO Business_Operation_Days values('B1', 'Wed');

INSERT INTO Business_Operation_Days values('B2', 'Mon');
INSERT INTO Business_Operation_Days values('B2', 'Tue');
INSERT INTO Business_Operation_Days values('B2', 'Wed');
INSERT INTO Business_Operation_Days values('B2', 'Thu');

INSERT INTO Business_Operation_Days values('B3', 'Mon');
INSERT INTO Business_Operation_Days values('B3', 'Tue');
INSERT INTO Business_Operation_Days values('B3', 'Wed');

INSERT INTO Business_Operation_Days values('B4', 'Mon');
INSERT INTO Business_Operation_Days values('B4', 'Tue');
INSERT INTO Business_Operation_Days values('B4', 'Wed');

INSERT INTO Business_Operation_Days values('B5', 'Mon');
INSERT INTO Business_Operation_Days values('B5', 'Tue');
INSERT INTO Business_Operation_Days values('B5', 'Wed');

INSERT INTO Business_Operation_Days values('B6', 'Mon');
INSERT INTO Business_Operation_Days values('B6', 'Tue');
INSERT INTO Business_Operation_Days values('B6', 'Wed');
INSERT INTO Business_Operation_Days values('B6', 'Thu');
INSERT INTO Business_Operation_Days values('B6', 'Fri');
INSERT INTO Business_Operation_Days values('B6', 'Sat');
INSERT INTO Business_Operation_Days values('B6', 'Sun');

INSERT INTO Business_Operation_Days values('B7', 'Mon');
INSERT INTO Business_Operation_Days values('B7', 'Tue');
INSERT INTO Business_Operation_Days values('B7', 'Wed');
INSERT INTO Business_Operation_Days values('B7', 'Thu');

INSERT INTO Business_Operation_Days values('B8', 'Mon');
INSERT INTO Business_Operation_Days values('B8', 'Tue');
INSERT INTO Business_Operation_Days values('B8', 'Wed');

INSERT INTO Business_Operation_Days values('B9', 'Mon');
INSERT INTO Business_Operation_Days values('B9', 'Tue');
INSERT INTO Business_Operation_Days values('B9', 'Wed');
INSERT INTO Business_Operation_Days values('B9', 'Thu');
INSERT INTO Business_Operation_Days values('B9', 'Fri');

INSERT INTO Business_Operation_Days values('B10', 'Mon');
INSERT INTO Business_Operation_Days values('B10', 'Tue');

INSERT INTO Business_Operation_Days values('B11', 'Mon');
INSERT INTO Business_Operation_Days values('B11', 'Fri');
INSERT INTO Business_Operation_Days values('B11', 'Sat');
INSERT INTO Business_Operation_Days values('B11', 'Sun');

INSERT INTO Business_Operation_Days values('B12', 'Mon');
INSERT INTO Business_Operation_Days values('B12', 'Tue');
INSERT INTO Business_Operation_Days values('B12', 'Sun');

INSERT INTO Business_Operation_Days values('B13', 'Mon');
INSERT INTO Business_Operation_Days values('B13', 'Sat');
INSERT INTO Business_Operation_Days values('B13', 'Sun');

INSERT INTO Business_Operation_Days values('B35', 'Mon');
INSERT INTO Business_Operation_Days values('B35', 'Thu');
INSERT INTO Business_Operation_Days values('B35', 'Sun');

INSERT INTO Business_Operation_Days values('B36', 'Mon');
INSERT INTO Business_Operation_Days values('B36', 'Wed');
INSERT INTO Business_Operation_Days values('B36', 'Sun');

INSERT INTO Business_Operation_Days values('B14', 'Mon');
INSERT INTO Business_Operation_Days values('B14', 'Wed');
INSERT INTO Business_Operation_Days values('B14', 'Sun');

--INSERT INTO Review Comments table
INSERT INTO Review_Comments values(1, 'R2', 'Y3', 'I love this place', TO_DATE('12/12/2010','MM/DD/YYYY'));
INSERT INTO Review_Comments values(2, 'R2', 'Y2', 'I hate this place', TO_DATE('12/13/2010','MM/DD/YYYY'));
INSERT INTO Review_Comments values(3, 'R3', 'Y3', 'I love this place', TO_DATE('08/12/2010','MM/DD/YYYY'));
INSERT INTO Review_Comments values(4, 'R7', 'Y8', 'I hate this place', TO_DATE('07/12/2010','MM/DD/YYYY'));
INSERT INTO Review_Comments values(5, 'R7', 'Y11', 'I love this place', TO_DATE('07/12/2010','MM/DD/YYYY'));
INSERT INTO Review_Comments values(6, 'R15', 'Y8', 'I hate this place', TO_DATE('06/12/2010','MM/DD/YYYY'));
INSERT INTO Review_Comments values(7, 'R16', 'Y8', 'I love this place', TO_DATE('06/12/2010','MM/DD/YYYY'));
INSERT INTO Review_Comments values(8, 'R20', 'Y7', 'I love this place', TO_DATE('12/12/2010','MM/DD/YYYY'));
INSERT INTO Review_Comments values(9, 'R20', 'Y10','I love this place', TO_DATE('12/12/2010','MM/DD/YYYY'));