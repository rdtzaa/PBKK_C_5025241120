CREATE DATABASE StudentRegistrationDB;
GO

USE StudentRegistrationDB;
GO

SELECT DB_NAME() AS CurrentDatabase;

--11
CREATE TABLE Programs
(
	ProgramId INT IDENTITY(1,1)
		CONSTRAINT PK_Programs PRIMARY KEY,
	ProgramCode VARCHAR(20) NOT NULL
		CONSTRAINT UQ_Programs_ProgramCode UNIQUE,
	ProgramName VARCHAR(100) NOT NULL,
	IsActive BIT NOT NULL
		CONSTRAINT DF_Programs_IsActive DEFAULT 1,
	CreatedAt DATETIME2 NOT NULL
		CONSTRAINT DF_Programs_CreatedAt
		DEFAULT SYSDATETIME()
);
GO

--12
INSERT INTO Programs
(
	ProgramCode,
	ProgramName
)
VALUES
('TI', 'Teknik Informatika'),
('SI', 'Sistem Informasi'),
('MNJ', 'Manajemen'),
('TE', 'Teknik Elektro'),
('DKV', 'Desain Komunikasi Visual');
GO

--13
SELECT * FROM Programs;

--14
CREATE TABLE Students
(
	StudentId INT IDENTITY(1,1)
		CONSTRAINT PK_Students PRIMARY KEY,
	NIM VARCHAR(20) NOT NULL
		CONSTRAINT UQ_Students_NIM UNIQUE,
	Name VARCHAR(100) NOT NULL,
	ProgramId INT NOT NULL,
	BirthDate DATE NULL,
	Address VARCHAR(250) NULL,
	PhoneNumber VARCHAR(20) NULL,
	CreatedAt DATETIME2 NOT NULL
		CONSTRAINT DF_Students_CreatedAt
		DEFAULT SYSDATETIME(),
	UpdatedAt DATETIME2 NULL,
	CONSTRAINT FK_Students_Programs
		FOREIGN KEY (ProgramId)
		REFERENCES Programs(ProgramId)
);
GO

--16
INSERT INTO Students (
    NIM,
    Name,
    ProgramId,
    BirthDate,
    Address,
    PhoneNumber
)
VALUES
    ('20231001', 'Ahmad Rizki',   1, '2003-03-12', 'Jl. Merdeka No. 123, Surabaya',    '081234567890'),
    ('20231002', 'Siti Aisyah',   2, '2004-07-21', 'Jl. Diponegoro No. 45, Surabaya',  '082233445566'),
    ('20231003', 'Budi Santoso',  1, '2003-11-05', 'Jl. Ahmad Yani No. 10, Surabaya',  '081355667788'),
    ('20231004', 'Citra Lestari', 3, '2004-01-18', 'Jl. Darmo No. 20, Surabaya',        '089900112233'),
    ('20231005', 'Dimas Prayoga', 4, '2003-09-27', 'Jl. Raya ITS, Surabaya',          '081288776655');
GO

SELECT * FROM Students;

--18
SELECT
	s.StudentId,
	s.NIM,
	s.Name,
	p.ProgramCode,
	p.ProgramName,
	s.BirthDate,
	s.PhoneNumber
FROM Students s
INNER JOIN Programs p
	ON s.ProgramId = p.ProgramId;

--19
INSERT INTO Students
(
	NIM,
	Name,
	ProgramId
)
VALUES
(
	'20231099',
	'Test Student',
	99
);

--20
INSERT INTO Students
(
	NIM,
	Name,
	ProgramId
)
VALUES
(
	'20231001',
	'Mahasiswa Duplikat',
	1
);

--24
SELECT * FROM Students;

SELECT
	s.NIM,
	s.Name,
	p.ProgramName
FROM Students s
INNER JOIN Programs p
	ON s.ProgramId = p.ProgramId
WHERE p.ProgramCode = 'TI';

SELECT COUNT(*) AS TotalMahasiswa FROM Students;

SELECT
	p.ProgramName,
	COUNT(s.StudentId) AS JumlahMahasiswa
FROM Programs p
LEFT JOIN Students s
	ON p.ProgramId = s.ProgramId
GROUP BY
	p.ProgramId,
	p.ProgramName;

--Mini assignment
INSERT INTO Students
    (NIM, Name, ProgramId, BirthDate, Address, PhoneNumber)
VALUES
    ('20231006', 'Andi Pratama', 1, '2004-02-15',
     'Jl. Mawar No. 10, Surabaya', '081234560001'),

    ('20231007', 'Dewi Anggraini', 2, '2004-05-20',
     'Jl. Melati No. 12, Surabaya', '081234560002'),

    ('20231008', 'Fajar Ramadhan', 4, '2003-08-25',
     'Jl. Kenanga No. 15, Surabaya', '081234560003');
GO

SELECT
    s.NIM,
    s.Name,
    p.ProgramName,
    s.BirthDate,
    s.PhoneNumber
FROM Students s
INNER JOIN Programs p
    ON s.ProgramId = p.ProgramId
ORDER BY s.Name;