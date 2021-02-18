-- Initialisierung der Datenbank inkl. abfuellen der Daten
CREATE database doppelnotexists2;

use doppelnotexists2;

create table pizzalieferanten (
	name	varchar(20)		not null primary key,
    ort		varchar (20)	not null);
    
create table kunden (
	name	varchar(20)	not null primary key);
    
create table pizza (
	art		varchar(20) not null primary key);

create table bestellung (
	pizzalieferant varchar(20) not null,
    kunde varchar(20) not null,
    pizza varchar(20) not null,
    constraint primary key (pizzalieferant, kunde, pizza),
    constraint foreign key (pizza) references pizza(art),
    constraint foreign key (kunde) references kunden(name),
    constraint foreign key (pizzalieferant) references pizzalieferanten(name));
    
insert into pizzalieferanten values ('meier', 'winterthur');
insert into pizzalieferanten values ('müller', 'zurich');
insert into pizzalieferanten values ('maxi', 'zug');
insert into pizzalieferanten values ('dax', 'winterthur');
insert into pizzalieferanten values ('fax', 'winterthur');

insert into kunden values ('ale');
insert into kunden values ('pozzi');
insert into kunden values ('raoul');
insert into kunden values ('pascal');
insert into kunden values ('linda');

insert into pizza values ('marga');
insert into pizza values ('prosc');
insert into pizza values ('fung');


insert into bestellung values ('meier', 'ale', 'marga');
insert into bestellung values ('meier', 'ale', 'prosc');
insert into bestellung values ('meier', 'ale', 'fung');
insert into bestellung values ('müller', 'pozzi', 'marga');
insert into bestellung values ('maxi', 'pascal', 'fung');
insert into bestellung values ('dax', 'pascal', 'marga');
insert into bestellung values ('fax', 'raoul', 'fung');
insert into bestellung values ('müller', 'ale', 'marga');
insert into bestellung values ('müller', 'ale', 'prosc');
insert into bestellung values ('müller', 'ale', 'fung');
insert into bestellung values ('maxi', 'ale', 'marga');
insert into bestellung values ('maxi', 'ale', 'prosc');
insert into bestellung values ('maxi', 'ale', 'fung');
insert into bestellung values ('dax', 'ale', 'marga');
insert into bestellung values ('dax', 'ale', 'prosc');
insert into bestellung values ('dax', 'ale', 'fung');
insert into bestellung values ('fax', 'ale', 'marga');
insert into bestellung values ('fax', 'ale', 'prosc');
insert into bestellung values ('fax', 'ale', 'fung');


-- Abfrage Variante 1
-- resultat korrekt
select name
from kunden
where not exists(
	select ''
    from pizzalieferanten
    where not exists(
		select ''
        from bestellung
        where kunden.name = bestellung.kunde and pizzalieferanten.name = bestellung.pizzalieferant)
        );
 
-- Abfrage Variante 2 
-- resultat null 
-- Erkenntnis! -> Reihenfolge ist relevant. Die Tabelle mit allen Infos (in diesem Fall bestellung) muss im zweiten not exists vor kommen! 
select name
from kunden
where not exists(
	select ''
    from bestellung
    where not exists(
		select ''
        from pizzalieferanten
        where kunden.name = bestellung.kunde and pizzalieferanten.name = bestellung.pizzalieferant)
        );
        
	