CREATE TABLE packages (
	name TEXT NOT NULL PRIMARY KEY,
	url TEXT NOT NULL,
	hash TEXT NOT NULL,
	binaries TEXT NOT NULL
);
