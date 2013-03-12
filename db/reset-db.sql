DROP USER 'jukebox'@'localhost';
DROP DATABASE jukebox;
DROP DATABASE jukebox_dev;
DROP DATABASE jukebox_test;

CREATE DATABASE jukebox CHARACTER SET utf8;
CREATE DATABASE jukebox_dev CHARACTER SET utf8;
CREATE DATABASE jukebox_test CHARACTER SET utf8;

CREATE USER 'jukebox'@'localhost' IDENTIFIED BY 'jukebox';

GRANT ALL PRIVILEGES ON jukebox.* TO 'jukebox'@'localhost';
GRANT ALL PRIVILEGES ON jukebox_dev.* TO 'jukebox'@'localhost';
GRANT ALL PRIVILEGES ON jukebox_test.* TO 'jukebox'@'localhost';


