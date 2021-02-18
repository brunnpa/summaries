
use praktikum10;

CREATE TABLE Mitarbeiter(
Name	varchar(60) NOT NULL,
vorname	varchar(60) NOT NULL,
constraint pk_mitarbeiter primary key (name, vorname)
);

CREATE TABLE Firma(
Name 	varchar(120) NOT NULL PRIMARY KEY
);

CREATE TABLE arbeitet(
MName	varchar(60) NOT NULL,
MVorname varchar(60) NOT NULL,
FName 	varchar(120) NOT NULL,
CONSTRAINT uc_arbeitet UNIQUE (MName, MVorname, FName),
CONSTRAINT fk_mitarbeiter FOREIGN KEY (MName, MVorname) REFERENCES Mitarbeiter(Name, Vorname),
CONSTRAINT fk_firma FOREIGN KEY (FName) REFERENCES Firma(Name)
);

ALTER TABLE Firma ADD Gruendungsjahr date NOT NULL;

ALTER TABLE Firma DROP column Gruendungsjahr;

ALTER TABLE Firma ADD Gruendungsjahr date NOT NULL;

ALTER TABLE arbeitet ADD Jahreslohn integer NOT NULL;

ALTER TABLE mitarbeiter add plz int not null;
alter table mitarbeiter add ort varchar(100) not null;
alter table mitarbeiter add strasse varchar(100) not null;
alter table mitarbeiter add Hausnr varchar(100) not null default '';


Insert into firma (name, gruendungsjahr) values ('Migros', 1925);
insert into mitarbeiter (name, vorname, plz, ort, strasse, hausnr) values ('mueller', 'heinz', 6312, 'Steinhausen', 'Hochwachtstrasse', 34);

Update 
mitarbeiter
set
plz	= '8401',
ort = 'Winterthur'
where 
name = 'mueller' AND vorname = 'heinz';

Alter table arbeitet
drop constraint uc_arbeitet;

alter Table arbeitet
add constraint uc_arbeitet unique(MName, MVorname);