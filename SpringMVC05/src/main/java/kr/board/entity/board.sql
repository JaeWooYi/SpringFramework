--
--
--create table myboard(
--idx int not null auto_increment,
--title varchar(100) not null,
--content varchar(2000) not null,
--writer varchar(30) not null,
--indate datetime default now(),
--count int default 0,
--primary key(idx)
--);
--
--insert into myboard (title, content, writer) values ('Test Board', 'Practice board', 'admin');
--insert into myboard (title, content, writer) values ('Test Board', 'Practice board', 'tester');
--insert into myboard (title, content, writer) values ('Test Board', 'Practice board', 'KKK');

create table test.mem_stbl
(
memIDX int not null,
memID varchar(20) not null,
memPASSWORD varchar(68) not null,
memNAME varchar(20) not null,
memAGE int,
memGENDER varchar(20),
memEMAIL varchar(50),
memPROFILE varchar(50)
primary key(memID)
);

create table test.mem_auth
(
no
memID
auth
primary key(no)
constraint fk_member_auth foreign key(memID) references mem_stbl(memID)
);