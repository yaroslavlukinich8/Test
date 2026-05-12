

CREATE TABLE Characters (
    CharacterID Int PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(100),
    Age Int
) AS NODE;
GO

CREATE TABLE Locations (
    LocationID Int PRIMARY KEY,
    Name VARCHAR(100),
    Type VARCHAR(50)
) AS NODE;
GO

CREATE TABLE Events (
    EventID Int PRIMARY KEY,
    Name VARCHAR(150),
    EventType VARCHAR(50),
    EventDate DATE
) AS NODE;
GO

CREATE TABLE Friendship (
    FriendshipID INT PRIMARY KEY,
    FromCharacterID INT NOT NULL FOREIGN KEY REFERENCES Characters(CharacterID),
    ToCharacterID INT NOT NULL FOREIGN KEY REFERENCES Characters(CharacterID),
    SinceDate DATE
);

CREATE TABLE LivesIn (
    LivesInID INT PRIMARY KEY,
    CharacterID INT NOT NULL FOREIGN KEY REFERENCES Characters(CharacterID),
    LocationID INT NOT NULL FOREIGN KEY REFERENCES Locations(LocationID),
    FromDate DATE
);

CREATE TABLE ParticipatedIn (
    ParticipatedInID INT PRIMARY KEY,
    CharacterID INT NOT NULL FOREIGN KEY REFERENCES Characters(CharacterID),
    EventID INT NOT NULL FOREIGN KEY REFERENCES Events(EventID),
    Status VARCHAR(50)
);



CREATE TABLE Friendship AS EDGE;
GO

ALTER TABLE Friendship
ADD FriendshipID INT NOT NULL,
    SinceDate DATE;

ALTER TABLE Friendship
ADD CONSTRAINT PK_Friendship PRIMARY KEY (FriendshipID);

CREATE TABLE LivesIn AS EDGE;
GO

ALTER TABLE LivesIn
ADD LivesInID INT NOT NULL,
    FromDate DATE;

ALTER TABLE LivesIn
ADD CONSTRAINT PK_LivesIn PRIMARY KEY (LivesInID);

CREATE TABLE ParticipatedIn AS EDGE;
GO

ALTER TABLE ParticipatedIn
ADD ParticipatedInID INT NOT NULL,
    Status VARCHAR(50);

ALTER TABLE ParticipatedIn
ADD CONSTRAINT PK_ParticipatedIn PRIMARY KEY (ParticipatedInID);






INSERT INTO Characters (CharacterID, Name, Role, Age) VALUES
(1,'Аэллин Риверс','Маг',27),
(2,'Кай Торн','Воин',31),
(3,'Лира Сноу','Лекарь',24),
(4,'Морвен Дарк','Ассасин',29),
(5,'Торн Вейл','Следопыт',33),
(6,'Элира Мун','Чародейка',22),
(7,'Дарион Холд','Рыцарь',35),
(8,'Селена Фрост','Охотница',26),
(9,'Ривен Грей','Монах',40),
(10,'Фаррен Блэк','Некромант',38);

INSERT INTO Locations (LocationID, Name, Type) VALUES
(1,'Элдор','Город'),
(2,'Сноуфолл','Деревня'),
(3,'Чернолесье','Лес'),
(4,'Крепость Ветров','Замок'),
(5,'Огненные Пески','Пустыня'),
(6,'Лунное Озеро','Озеро'),
(7,'Горный Предел','Горы'),
(8,'Тихий Порт','Гавань'),
(9,'Затерянный Храм','Руины'),
(10,'Серебряная Долина','Долина');

INSERT INTO Events (EventID, Name, EventType, EventDate) VALUES
(1,'Битва у моста','Битва','2024-03-10'),
(2,'Падение башни','Катастрофа','2024-04-01'),
(3,'Совет магов','Собрание','2024-05-15'),
(4,'Огненный шторм','Катастрофа','2024-06-20'),
(5,'Нападение теней','Бой','2024-07-11'),
(6,'Праздник урожая','Праздник','2024-08-30'),
(7,'Открытие портала','Магия','2024-09-14'),
(8,'Поход на север','Путешествие','2024-10-05'),
(9,'Схватка у храма','Бой','2024-11-22'),
(10,'Коронация короля','Церемония','2024-12-01');


-- Аэллин → Кай
INSERT INTO Friendship ($from_id, $to_id, FriendshipID, SinceDate)
VALUES ((SELECT $node_id FROM Characters WHERE CharacterID = 1),
        (SELECT $node_id FROM Characters WHERE CharacterID = 2),
        1, '2024-01-10');

-- Аэллин → Лира
INSERT INTO Friendship ($from_id, $to_id, FriendshipID, SinceDate)
VALUES ((SELECT $node_id FROM Characters WHERE CharacterID = 1),
        (SELECT $node_id FROM Characters WHERE CharacterID = 3),
        2, '2024-01-12');

-- Кай → Лира
INSERT INTO Friendship ($from_id, $to_id, FriendshipID, SinceDate)
VALUES ((SELECT $node_id FROM Characters WHERE CharacterID = 2),
        (SELECT $node_id FROM Characters WHERE CharacterID = 3),
        3, '2024-01-15');

-- Кай → Морвен
INSERT INTO Friendship ($from_id, $to_id, FriendshipID, SinceDate)
VALUES ((SELECT $node_id FROM Characters WHERE CharacterID = 2),
        (SELECT $node_id FROM Characters WHERE CharacterID = 4),
        4, '2024-01-20');

-- Лира → Морвен
INSERT INTO Friendship ($from_id, $to_id, FriendshipID, SinceDate)
VALUES ((SELECT $node_id FROM Characters WHERE CharacterID = 3),
        (SELECT $node_id FROM Characters WHERE CharacterID = 4),
        5, '2024-02-01');

-- Лира → Торн Вейл
INSERT INTO Friendship ($from_id, $to_id, FriendshipID, SinceDate)
VALUES ((SELECT $node_id FROM Characters WHERE CharacterID = 3),
        (SELECT $node_id FROM Characters WHERE CharacterID = 5),
        6, '2024-02-05');

-- Морвен → Торн Вейл
INSERT INTO Friendship ($from_id, $to_id, FriendshipID, SinceDate)
VALUES ((SELECT $node_id FROM Characters WHERE CharacterID = 4),
        (SELECT $node_id FROM Characters WHERE CharacterID = 5),
        7, '2024-02-10');

-- Морвен → Элира
INSERT INTO Friendship ($from_id, $to_id, FriendshipID, SinceDate)
VALUES ((SELECT $node_id FROM Characters WHERE CharacterID = 4),
        (SELECT $node_id FROM Characters WHERE CharacterID = 6),
        8, '2024-02-15');

-- Торн Вейл → Элира
INSERT INTO Friendship ($from_id, $to_id, FriendshipID, SinceDate)
VALUES ((SELECT $node_id FROM Characters WHERE CharacterID = 5),
        (SELECT $node_id FROM Characters WHERE CharacterID = 6),
        9, '2024-02-20');



INSERT INTO LivesIn ($from_id, $to_id, LivesInID, FromDate)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 1),
    (SELECT $node_id FROM Locations WHERE LocationID = 1),
    1, '2023-05-01'
);

INSERT INTO LivesIn ($from_id, $to_id, LivesInID, FromDate)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 1),
    (SELECT $node_id FROM Locations WHERE LocationID = 6),
    2, '2023-06-01'
);

INSERT INTO LivesIn ($from_id, $to_id, LivesInID, FromDate)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 2),
    (SELECT $node_id FROM Locations WHERE LocationID = 2),
    3, '2023-05-10'
);

INSERT INTO LivesIn ($from_id, $to_id, LivesInID, FromDate)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 3),
    (SELECT $node_id FROM Locations WHERE LocationID = 1),
    4, '2023-06-01'
);

INSERT INTO LivesIn ($from_id, $to_id, LivesInID, FromDate)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 3),
    (SELECT $node_id FROM Locations WHERE LocationID = 8),
    5, '2023-07-01'
);

INSERT INTO LivesIn ($from_id, $to_id, LivesInID, FromDate)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 4),
    (SELECT $node_id FROM Locations WHERE LocationID = 3),
    6, '2023-06-15'
);

INSERT INTO LivesIn ($from_id, $to_id, LivesInID, FromDate)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 5),
    (SELECT $node_id FROM Locations WHERE LocationID = 4),
    7, '2023-07-01'
);

INSERT INTO LivesIn ($from_id, $to_id, LivesInID, FromDate)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 5),
    (SELECT $node_id FROM Locations WHERE LocationID = 7),
    8, '2023-08-01'
);

INSERT INTO LivesIn ($from_id, $to_id, LivesInID, FromDate)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 6),
    (SELECT $node_id FROM Locations WHERE LocationID = 6),
    9, '2023-08-15'
);


INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 1),
    (SELECT $node_id FROM Events WHERE EventID = 1),
    1, 'Active'
);

INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 1),
    (SELECT $node_id FROM Events WHERE EventID = 3),
    2, 'Support'
);

INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 2),
    (SELECT $node_id FROM Events WHERE EventID = 1),
    3, 'Witness'
);

INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 2),
    (SELECT $node_id FROM Events WHERE EventID = 5),
    4, 'Active'
);

INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 3),
    (SELECT $node_id FROM Events WHERE EventID = 2),
    5, 'Active'
);

INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 3),
    (SELECT $node_id FROM Events WHERE EventID = 6),
    6, 'Healer'
);

INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 4),
    (SELECT $node_id FROM Events WHERE EventID = 3),
    7, 'Guard'
);

INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 4),
    (SELECT $node_id FROM Events WHERE EventID = 9),
    8, 'Assassin'
);

INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 6),
    (SELECT $node_id FROM Events WHERE EventID = 7),
    11, 'Mage'
);

INSERT INTO ParticipatedIn ($from_id, $to_id, ParticipatedInID, Status)
VALUES (
    (SELECT $node_id FROM Characters WHERE CharacterID = 6),
    (SELECT $node_id FROM Events WHERE EventID = 6),
    12, 'Guest'
);






SELECT c1.Name AS CharacterName,
       c2.Name AS FriendName,
       loc.Name AS LocationName
FROM Characters c1,
     Friendship f,
     Characters c2,
     LivesIn l,
     Locations loc
WHERE MATCH(c1-(f)->c2-(l)->loc);


SELECT c1.Name AS Participant1,
       c2.Name AS Participant2,
       e.Name AS EventName,
       loc.Name AS LocationName
FROM Characters c1,
     ParticipatedIn p1,
     Events e,
     ParticipatedIn p2,
     Characters c2,
     LivesIn l,
     Locations loc
WHERE MATCH(c1-(p1)->e<-(p2)-c2-(l)->loc);


SELECT c1.Name AS StartCharacter,
       c2.Name AS Friend1,
       c3.Name AS Friend2,
       c4.Name AS Friend3
FROM Characters c1,
     Friendship f1,
     Characters c2,
     Friendship f2,
     Characters c3,
     Friendship f3,
     Characters c4
WHERE MATCH(c1-(f1)->c2-(f2)->c3-(f3)->c4);
    

SELECT c1.Name AS Character1,
       c2.Name AS Character2,
       loc.Name AS LocationName,
       e.Name AS EventName
FROM Characters c1,
     LivesIn l1,
     Locations loc,
     LivesIn l2,
     Characters c2,
     ParticipatedIn p,
     Events e
WHERE MATCH(c1-(l1)->loc<-(l2)-c2-(p)->e);


SELECT c1.Name AS CharacterName,
       c2.Name AS FriendName,
       e.Name AS EventName
FROM Characters c1,
     Friendship f,
     Characters c2,
     ParticipatedIn p,
     Events e
WHERE MATCH(c1-(f)->c2-(p)->e);


SELECT 
    cStart.Name AS StartCharacter,
    LAST_NODE(n).Name AS EndCharacter,
    STRING_AGG(n.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS PathNodes
FROM Characters AS cStart,
     Friendship FOR PATH AS f,
     Characters FOR PATH AS n
WHERE MATCH(SHORTEST_PATH(cStart-(f)->n+))
  AND cStart.CharacterID = 1
GROUP BY cStart.Name;



SELECT 
    cStart.Name AS StartCharacter,
    LAST_NODE(n).Name AS EndNode,
    STRING_AGG(n.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS PathNodes
FROM Characters AS cStart,
     (Friendship | LivesIn | ParticipatedIn) FOR PATH AS e,
     Characters FOR PATH AS n
WHERE MATCH(SHORTEST_PATH(cStart-(e){1,5}->n))
  AND cStart.CharacterID = 3
GROUP BY cStart.Name;

