	-- -----------------------------------------------------
-- Schema cityLib
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cityLib`;
CREATE SCHEMA IF NOT EXISTS `cityLib` DEFAULT CHARACTER SET utf8;
USE `cityLib`;

-- -----------------------------------------------------
-- Table Reader
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Reader`;
CREATE TABLE Reader
(
ReaderID int auto_increment PRIMARY KEY,
RType varchar(20),
RName varchar(50),
RAddress varchar(225),
Phone_Number bigint,
MemStart date,
Fine int,
NumResDocs int,
NumBorDocs int
);

-- -----------------------------------------------------
-- Table Branch
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Branch`;
CREATE TABLE Branch
(
LibID int auto_increment PRIMARY KEY,
LName varchar(50),
LLocation varchar(225)
);

-- -----------------------------------------------------
-- Table Publisher
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Publisher`;
CREATE TABLE Publisher
(
PublisherID int auto_increment PRIMARY KEY,
PubName varchar(50),
PubAddress varchar(225)
);

-- -----------------------------------------------------
-- Table Author
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Author`;
CREATE TABLE Author
(
AuthorID int auto_increment PRIMARY KEY,
Author_Name varchar(50)
);





-- -----------------------------------------------------
-- Table Chief_Editor
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Chief_Editor`;
CREATE TABLE Chief_Editor
(
Editor_ID int auto_increment PRIMARY KEY,
EName varchar(50)
);

-- -----------------------------------------------------
-- Table Document
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Document`;
CREATE TABLE Document
(
DocID int auto_increment PRIMARY KEY,
Title varchar(50),
PDate date,
PublisherID int,
FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);

-- -----------------------------------------------------
-- Table Proceedings
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Proceedings`;
CREATE TABLE Proceedings
(
DocID int auto_increment Primary Key,
CDate date,
CLocation varchar(25),
CEditor varchar(50),
FOREIGN KEY (DocID) REFERENCES Document(DocID)
);

-- -----------------------------------------------------
-- Table Copy
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copy`;
CREATE TABLE Copy
(
DocID int,
CopyNo int,
LibID int,
Position varchar(6),
Primary Key(DocID, CopyNo, LibID),
FOREIGN KEY (LibID) REFERENCES Branch(LibID)
);



-- -----------------------------------------------------
-- Table Borrows
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Borrows`;
CREATE TABLE Borrows
(
BorNumber int,
ReaderID int,
DocID int,
CopyNo int,
LibID int,
BDate date,
BTime time,
PRIMARY KEY(BorNumber,DocID,CopyNo,LibID),
Foreign Key (ReaderID) REFERENCES Reader(ReaderID)
);


-- -----------------------------------------------------
-- Table Reserves
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Reserves`;
CREATE TABLE Reserves
(
ResNumber int,
ReaderID int,
DocID int,
CopyNo int,
LibID int,
RDate date,
RTime time,
PRIMARY KEY(ResNumber,DocID,CopyNo,LibID),
Foreign Key (ReaderID) REFERENCES Reader(ReaderID)
);

-- -----------------------------------------------------
-- Table Book
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Book`;
CREATE TABLE Book
(
DocID int,
ISBN varchar(20),
FOREIGN KEY (DocID) REFERENCES Document(DocID)
);


-- -----------------------------------------------------
-- Table Writes
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Writes`;
CREATE TABLE Writes
(
AuthorID int,
DocID int,
Primary Key (AuthorID, DocID),
Foreign Key (AuthorID) REFERENCES Author(AuthorID),
Foreign Key (DocID) REFERENCES Book(DocID)
);




-- -----------------------------------------------------
-- Table Journal_Volume
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Journal_Volume`;
CREATE TABLE Journal_Volume
(
DocID int PRIMARY KEY,
JVolume int,
Editor_ID int,
Foreign Key (DocID) REFERENCES Document(DocID),
FOREIGN KEY (Editor_ID) REFERENCES Chief_Editor(Editor_ID)
);



-- -----------------------------------------------------
-- Table Journal_Issue
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Journal_Issue`;
CREATE TABLE Journal_Issue
(
DocID int,
Issue_Number int,
CHECK (Issue_Number>=0 AND Issue_Number<=10),
Scope varchar(100),
Primary Key(DocID,Issue_Number),
FOREIGN Key (DocID) REFERENCES Journal_Volume(DocID)
);


-- -----------------------------------------------------
-- Table Inv_Editor
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inv_Editor`;
CREATE TABLE Inv_Editor
(
DocID int,
Issue_Number int,
IE_Name varchar(50),
Foreign Key (DocID,Issue_Number) REFERENCES Journal_Issue(DocID,Issue_Number),
Primary Key(DocID,Issue_Number,IE_Name)
);



-- ------------------------------------------------------
-- Table Admin Login
-- ------------------------------------------------------

DROP TABLE IF EXISTS `AdminLogin`;
CREATE TABLE AdminLogin
(
AdminID varchar(10),
LoginPassword varchar(10),
Primary Key(AdminID, LoginPassword)
);


-- ------------------------------------------------------
-- Populated Data
-- ------------------------------------------------------

INSERT INTO `cityLib`.`Reader` (`RType`, `RName`, `RAddress`, `Phone_Number`, `MemStart`, `Fine`, `NumResDocs`, `NumBorDocs` )
VALUES
('Regular', 'Glen Howell', '648 South Oak St.', '7326975126', '2003-01-01',0,9, 6),
('Regular', 'Jan Sanders', '8044 Newbridge Road', '7321964875', '2002-05-06', 0,0,4),
('Regular', 'Patsy Peterson', '811 Coffee Street', '7326985874', '2004-06-04',0,0, 4),
('Employee', 'Randolph Hansen', '316 N. Indian Spring Rd.', '7327896541', '2004-04-08',0,0,4),
('Student', 'Noah Moss', '7419C Boston St.', '7324856925', '2006-08-06', 0,0, 4),
('Regular', 'Marcella Fields', '173 Greystone Street', '7324859632', '2009-09-04', 0,0, 2),
('Student', 'Eula Hardy', '397 Santa Clara St.', '7321859646', '2007-01-06', 0,0, 2),
('Employee', 'Diane Morris', '16 Highland Street', '7327892584', '2006-02-08', 0,0, 2),
('Student', 'Betsy Weber', '72 Somerset Dr.', '7325896147', '2008-03-01', 0,0, 2),
('Student', 'Erika Hoffman', '988 Woreaderodsman Dr.', '7324685216', '2006-06-06', 0, 0, 2),
('Employee', 'Erika Hoffman', '8718 Blue Spring St.', '7329853214', '2004-08-04', 0,0, 2),
('Student', 'Michelle Page', '339 W. North St.', '7324896156', '2006-07-06', 0,0, 2),
('Employee', 'Elizabeth Bush', '553 Elizabeth Street', '7328594146', '2004-09-04', 0,0,2),
('Student', 'Sonya Murray', '263 Fieldstone Rd.','7328945612', '2009-05-03', 0,0, 2),
('Regular', 'Jose Alexander', '547 Peg Shop Ave.','7325268943', '2008-04-04',0,1, 2);

INSERT INTO `cityLib`.`Branch` (`LName`, `LLocation`)
VALUES
('Patrick', 'Doral, FL'),
('Hawkins', 'Fort Lauderdale, FL');

INSERT INTO `cityLib`.`Publisher` (`PubName`, `PubAddress`)
VALUES
('Nathan Gardner', '456 Ketch Harbour Street'),
('Johnathan Evans', '7984 Riverview Street'),
('Betsy Waters', '35 Monroe Road'),
('Stephen Simpson', '70 Snake Hill St.'),
('Naomi Mccoy', '28 Bridgeton St.'),
('Leticia Wolfe', '14 Clay Street'),
('Cassandra Barnett', '8743 Ridgewood St.'),
('Shelly Colon', '675 Old York Drive'),
('Esther Johnson', '34 North Rd.'),
('Terry Townsend', '877 W. Old York St.'),

('Johanna Thompson', '374 Kerwin Ave'),
('Becky Carlson', '4896 Jamie St.'),
('Bianca Sitter', '159 Jesse Drive'),
('Emily Rider', '96 South Rd.'),
('Theo Frank', '479 Grey St.'),
('John Snow', '198 Bling St.'),

 ('Victor Reed', '159 Jesse Drive'),
('Sam Change', '96 South Rd.'),
('Mike Tailor', '479 Grey St.'),
('Alex Scott', '198 Bling St.'),

('Glen Martain', '957 Hanover St.'),
('Kelly Baker', '4763 Grand St.');

INSERT INTO `cityLib`.`Author` (`Author_Name`)
VALUES
('Freda Hunt'),
('Felicia Stewart'),
('Moses Gibbs'),
('Bertha Cox'),
('Monique Hogan'),
('Irene Grant');

INSERT INTO `cityLib`.`Chief_Editor` (`EName`)
VALUES
('Cesar Harvey'),
('Tabitha Bishop'),
('Dorothy Ray'),
('Darrel Washington');

INSERT INTO `cityLib`.`Document` (`Title`, `PDate`, `PublisherID`)
VALUES
('a workshop on technology', '1992-08-20', '1'),
('international conference on power transmission', '2001-07-02', '2'),
('accelerating programming', '1998-07-09', '3'),
('symposium on access space', '1948-01-03', '4'),
('ethics in the workplace', '2008-04-23', '5'),
('2nd institution on engineering', '2003-06-07', '6'),
('RF measurement', '1995-05-05', '7'),
('electromagnetic compatibility', '1985-11-27', '8'),
('acoustic sound enhancement', '1987-12-08', '9'),
('underwater geosciences', '2009-04-22', '10'),
('Hero Of Rainbows', '2011-09-02', '11'),
('Prized Person', '2012-05-02', '11'),
('The Elemental Child', '2012-05-02', '11'),
('Pleasure of Savior', '2012-05-02', '11'),
('The Dream Lover', '2012-05-02', '11'),
('The Guardian of the Dreaming', '2012-05-02', '11'),
('Door in the Tears', '2012-05-02', '12'),
('Bloody Tales', '2012-05-02', '12'),
('The Grey Soul', '2012-05-02', '12'),
('Weeping of Ship', '2012-05-02', '12'),
('The School Abyss', '2012-05-02', '12'),
('The Dreams of the Return', '2012-05-02', '12'),
('River in the Prophecy', '2012-05-02', '13'),
('No Names', '2012-05-02', '13'),
('The Growing Visions', '2012-05-02', '13'),
('Truth of Teacher', '2012-05-02', '13'),
('The Flame Abyss', '2012-05-02', '13'),
('The Woman of the Dream', '2012-05-02', '13'),
('Ice in the Angels', '2012-05-02', '14'),
('Invisible Dreams', '2012-05-02', '14'),
('The Erect Luck', '2012-05-02', '14'),
('Shores of Husband', '2012-05-02', '14'),
('The Sons Rose', '2012-05-02', '14'),
('The Slave of the Servants', '2012-05-02', '14'),
('Name in the Door', '2012-05-02', '15'),
('Naked Dreams', '2012-05-02', '15'),
('The Red Wings', '2012-05-02', '15'),
('Edge of Wind', '2012-05-02', '15'),
('The Edge Ship', '2012-05-02', '15'),
('The Shadow of the Bridge', '2012-05-02', '15'),
('Serpents in the Door', '2012-05-02', '16'),
('Luscious Name', '2012-05-02', '16'),
('The Cold Planet', '2012-05-02', '16'),
('Crying of Force', '2012-05-02', '16'),
('The Swordss Prophecy', '2012-05-02', '16'),
('The Healer of the Doors', '2012-05-02', '16'),
('Souls in the Game', '2012-05-02', '11'),
('thief of dawn', '1992-04-19', '11'),
('pirate with sins', '2001-08-05', '12'),
('girls of the curse', '1998-03-02', '13'),
('friends with honor', '1948-06-05', '14'),
('no new friends', '2008-02-20', '11'),
('snakes and dogs', '2003-02-25', '15'),
('man vs nature', '1991-06-03', '17'),
('around the world', '1948-01-09', '18'),
('future in space', '2008-06-19', '19'),
('recycling and refueling', '2002-06-20', '20'),
('life on mars', '2003-02-03', '21'),
('bioenergy', '2012-05-02', '22');




INSERT INTO `cityLib`.`Proceedings` (`CDate`, `CLocation`,`CEditor`)
VALUES
('2011-02-03', 'Easton, PA','Cesar Harvey'),
('2003-02-04', 'Jamaica Plain','Tabitha Bishop'),
('1992-05-08', 'Oshkosh, WI','Cesar Harvey'),
('1994-09-07', 'Torrington, CT','Tabitha Bishop'),
('1998-05-12', 'Wyoming, MI','Cesar Harvey'),
('1989-03-10', 'Marion, NC', 'Edna Lane'),
('2001-12-12', 'Orange Park','abc'),
('2004-12-09', 'Vienna, VA','Tabitha Bishop'),
('2001-08-09', 'Newton, NJ','def'),
('2006-04-07', 'Niles, MI','Cesar Harvey');


INSERT INTO `cityLib`.`Copy` (`DocID`,`CopyNo`, `LibID`, `Position`)
VALUES
('1', '6', '1','001A01'),
('2', '8', '1','001A02'),
('3', '10', '1','001A03'),
('4', '12', '1','001A04'),
('5', '15', '1','001A05'),
('6', '18', '1','001A06'),
('7', '17', '1','001A07'),
('8', '7', '1','001A08'),
('9', '21', '1','001A09'),
('10', '1', '1','001A10'),
('1', '7', '1','001A11'),
('2', '9', '1','001A12'),
('3', '11', '1','001A13'),
('4', '13', '1','001A14'),
('5', '16', '1','001A15'),
('6', '19', '1','001A16'),
('7', '18', '1','001A17'),
('8', '8', '1','001A18'),
('9', '22', '1','001A19'),
('10', '2', '1','001A20'),
('11', '21', '1','001A21'),
('12', '6', '2','001A22'),
('13', '8', '2','001A23'),
('14', '10', '2','001A24'),
('15', '12', '2','001A25'),
('16', '15', '2','001A26'),
('17', '18', '2','001A27'),
('18', '17', '2','001A28'),
('19', '7', '2','001A29'),
('20', '21', '2','001A30'),
('21', '1', '2','001A31'),
('12', '7', '2','001A32'),
('13', '9', '2','001A33'),
('14', '11', '2','001A34'),
('15', '13', '2','001A35'),
('16', '16', '2','001A36'),
('17', '19', '2','001A37'),
('18', '18', '2','001A38'),
('19', '8', '2','001A39'),
('20', '22', '2','001A40'),
('21', '23', '2','001A41'),
('22', '21', '2','001A42'),
('59', '1', '1', '001A43'),
('58', '2', '2', '001A44'),
('57', '3', '1', '001A45'),
('56', '4', '2', '001A46'),
('55', '5', '1', '001A47'),
('54', '9', '2', '001A48'),
('53', '19', '1', '001A49'),
('52', '11', '1', '001A50'),
('51', '13', '1', '001A51'),
('50', '20', '2', '001A52');









INSERT INTO `cityLib`.`Borrows` (`BorNumber`, `ReaderID`, `DocID`, `CopyNo`, `LibID`, `BDate`, `BTime`)
VALUES
('11', '1', '1', '6', '1', '2016-04-01', '04:02'),
('12', '1', '2', '8', '1', '2016-04-02', '05:03'),
('13', '2', '3', '10', '1', '2016-04-03', '12:22'),
('14', '2', '4', '12', '1', '2016-04-04', '18:53'),
('15', '3', '5', '15', '1', '2016-04-05', '14:24'),
('16', '3', '6', '18', '1', '2016-04-06', '17:25'),
('17', '4', '7', '17', '1', '2016-04-07', '12:46'),
('18', '4', '8', '7', '1', '2016-04-08', '13:27'),
('19', '5', '9', '21', '1', '2016-04-09', '15:08'),
('20', '5', '10', '2', '1', '2016-04-10', '09:48'),
('21', '6', '1', '7', '1', '2016-04-01', '04:02'),
('22', '7', '2', '8', '1', '2016-04-02', '05:03'),
('23', '8', '3', '10', '1', '2016-04-03', '12:22'),
('24', '9', '4', '12', '1', '2016-04-04', '18:53'),
('25', '10', '5', '15', '1', '2016-04-05', '14:24'),
('26', '11', '6', '18', '1', '2016-04-06', '17:25'),
('27', '12', '7', '17', '1', '2016-04-07', '12:46'),
('28', '13', '8', '7', '1', '2016-04-08', '13:27'),
('29', '14', '9', '21', '1', '2016-04-09', '15:08'),
('30', '15', '10', '22', '1', '2016-04-10', '09:48'),
('31', '1', '11', '21', '1', '2016-04-09', '15:08'),
('32', '1', '12', '6', '2', '2016-04-01', '04:02'),
('33', '1', '13', '8', '2', '2016-04-02', '05:03'),
('34', '2', '14', '10', '2', '2016-04-03', '12:22'),
('35', '2', '15', '12', '2', '2016-04-04', '18:53'),
('36', '3', '16', '15', '2', '2016-04-05', '14:24'),
('37', '3', '17', '18', '2', '2016-04-06', '17:25'),
('38', '4', '18', '17', '2', '2016-04-07', '12:46'),
('39', '4', '19', '7', '2', '2016-04-08', '13:27'),
('40', '5', '20', '21', '2', '2016-04-09', '15:08'),
('41', '5', '21', '1', '2', '2016-04-10', '09:48'),
('42', '6', '12', '7', '2', '2016-04-01', '04:02'),
('43', '7', '13', '9', '2', '2016-04-02', '05:03'),
('44', '8', '14', '11', '2', '2016-04-03', '12:22'),
('45', '9', '15', '13', '2', '2016-04-04', '18:53'),
('46', '10', '16', '16', '2', '2016-04-05', '14:24'),
('47', '11', '17', '19', '2', '2016-04-06', '17:25'),
('48', '12', '18', '18', '2', '2016-04-07', '12:46'),
('49', '13', '19', '8', '2', '2016-04-08', '13:27'),
('50', '14', '20', '22', '2', '2016-04-09', '15:08'),
('51', '15', '21', '23', '2', '2016-04-10', '09:48'),
('52', '1', '22', '21', '2', '2016-04-09', '15:08');







INSERT INTO `cityLib`.`Reserves` (`ResNumber`, `ReaderID`, `DocID`, `CopyNo`, `LibID`, `RDate`, `RTime`)
VALUES
('11', '1', '59', '1', '1', '2016-04-01', '04:02'),
('12', '1', '58', '2', '2', '2016-04-02', '05:03'),
('13', '1', '57', '3', '1', '2016-04-03', '12:22'),
('14', '1', '56', '4', '2', '2016-04-04', '18:53'),
('15', '1', '55', '5', '1', '2016-04-05', '14:24'),
('16', '1', '54', '9', '2', '2016-04-06', '17:25'),
('17', '1', '53', '19', '1', '2016-04-07', '12:46'),
('18', '1', '52', '11', '1', '2016-04-08', '13:27'),
('19', '1', '51', '13', '1', '2016-04-09', '15:08'),
('20', '15', '50', '20', '2', '2016-04-10', '09:48');

INSERT INTO `cityLib`.`Book` (`DocID`, `ISBN`)
VALUES
('11', '9576702756985'),
('12', '1610654262418'),
('13', '5009015624281'),
('14', '5162306315438'),
('15', '8756602944289'),
('16', '9245935090583'),
('11', '9576702756985'),
('12', '1610654262418'),
('13', '5009015624281'),
('14', '5162306315438'),
('15', '8756602944289'),
('16', '9245935090583'),
('17', '5655680268098'),
('18', '9602859820451'),
('19', '4142521914517'),
('20', '8926555749374'),
('21', '6587413932145'),
('22', '3214596321497'),
('23', '3210249632522'),
('24', '6541239874598'),
('25', '1973548620321'),
('26', '2456317896321'),
('27', '8796423145932'),
('28', '3210214569762'),
('29', '3210569879631'),
('30', '3658965471231'),
('31', '3021479431034'),
('32', '3214976548931'),
('33', '7896547132149'),
('34', '9685412364021'),
('35', '6547963125121'),
('36', '4569321078964'),
('37', '5321014789654'),
('38', '2321456987456'),
('39', '3210654796321'),
('40', '8479651230147'),
('41', '7458965893214'),
('42', '6547893210147'),
('43', '4569875984123'),
('44', '4789321021456'),
('45', '3659874562101'),
('46', '3114879632145'),
('47', '2231145698741'),
('48', '2233668877156'),
('49', '3322997788621'),
('50', '8879654123548'),
('51', '9987463156545'),
('52', '6987451251452'),
('53', '4563215522112');





INSERT INTO `cityLib`.`Writes` (`AuthorID`, `DocID`)
VALUES
('1', '11'),
('2', '12'),
('3', '13'),
('4', '14'),
('5', '15'),
('6', '16'),
('6', '17'),
('1', '18'),
('5', '19'),
('4', '20'),
('3', '21'),
('4', '22'),
('5', '23'),
('6', '24'),
('3', '25'),
('5', '26'),
('6', '27'),
('6', '28'),
('4', '29'),
('1', '30'),
('2', '31'),
('3', '32'),
('4', '33'),
('5', '34'),
('6', '35'),
('5', '36'),
('4', '37'),
('3', '38'),
('2', '39'),
('1', '40'),
('3', '41'),
('5', '42'),
('2', '43'),
('4', '44'),
('6', '45'),
('1', '46'),
('1', '47'),
('2', '48'),
('2', '49'),
('3', '50'),
('3', '51'),
('4', '52'),
('4', '53');



INSERT INTO `cityLib`.`Journal_Volume` (`DocID`, `JVolume`, `Editor_ID`)
VALUES
('54', '8', '1'),
('55', '6', '2'),
('56', '2', '3'),
('57', '9', '4');

INSERT INTO `cityLib`.`Journal_Issue` (`DocID`, `Issue_Number`, `Scope`)
VALUES
('54', '5', 'null'),
('55', '1', 'null'),
('56', '9', 'null'),
('57', '7', 'null');

INSERT INTO `cityLib`.`Inv_Editor` (`DocID`, `Issue_Number`, `IE_Name`)
VALUES
('54', '5', 'Harold Quibble'),
('57', '7', 'Sheena Arbor');

INSERT INTO `cityLib`.`AdminLogin` (`AdminID`, `LoginPassword`)
VALUES
('HP','himpatel'),
('JH', 'jerhoc'),
('AP', 'aapala');
