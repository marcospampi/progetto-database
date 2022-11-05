INSERT INTO `Attivita` VALUES (1,'Sala pesi',25.00),(2,'Kickbox',25.00),(3,'Zumba',30.00),(4,'Danza',30.00);
INSERT INTO `CategoriaPesi` VALUES (1,'Ragazzi');
INSERT INTO `Contributo` VALUES (1,1,1,1,'Mensile',NULL,25.00,'2022-11-05 11:42:12','2022-12-05'),(2,1,1,NULL,'Annuale',NULL,15.00,'2022-11-05 11:42:12','2023-11-05'),(3,6,2,1,'Mensile',NULL,25.00,'2022-11-05 17:38:28','2022-12-05'),(4,6,2,3,'Mensile',NULL,30.00,'2022-11-05 17:38:28','2022-12-05'),(5,6,2,NULL,'Annuale',NULL,15.00,'2022-11-05 17:38:28','2023-11-05');
INSERT INTO `Esercizio` VALUES (1,'Bilanciere panca piana','Petto',NULL),(2,'Spinte manubri su inclinata','Petto',NULL),(3,'Pettorali alla macchina da seduto','Petto',NULL),(4,'Croci alla macchina','Petto',NULL),(5,'Pettorali alla macchina inclinata','Petto',NULL),(6,'Croci su panca inclinata','Petto',NULL),(7,'Curl bilanciere curvo presa larga','Bicipiti',NULL),(8,'Curl panca incllinata','Bicipiti',NULL),(9,'Curl panca Scott','Bicipiti',NULL),(10,'Squat','Gambe',NULL),(11,'Leg-Extension','Gambe',NULL),(12,'Leg-Curl','Gambe',NULL),(13,'Affondi con manubri','Gambe',NULL),(14,'Spinte sullo step','Gambe',NULL),(15,'Polpacci alla macchina','Gambe',NULL),(16,'Lat-Machine','Dorso',NULL),(17,'Pulley','Dorso',NULL),(18,'Rematori petto sulla panca','Dorso',NULL),(19,'Dorsali al cavo','Dorso',NULL),(20,'Spinte manubri da seduto','Spalle',NULL),(21,'Spinte alla macchina da seduto','Spalle',NULL),(22,'Spinte in piedi con manubri','Spalle',NULL),(23,'Alzate laterali con manubri','Spalle',NULL),(24,'Alzate frontali al cavo','Spalle',NULL),(25,'Alzate laterali a busto flesso','Spalle','Petto sulla panca reclinata, usare pesi leggeri'),(26,'Bilanciere panca piana presa stretta','Tricipiti',NULL),(27,'Spinte in basso al cavo','Tricipiti',NULL),(28,'Spinte indietro con manubri petto sulla panca','Tricipiti','Tenere i gomiti altezza busto, alzare il peso.');
INSERT INTO `EsercizioScheda` VALUES (1,1,1,5,8,120),(1,2,1,4,10,120),(1,7,2,5,8,120),(1,8,2,4,10,120),(1,10,3,5,8,120),(1,11,3,4,10,120),(1,16,4,5,8,120),(1,17,4,6,10,120),(1,20,5,5,8,120),(1,25,5,3,15,120),(1,27,6,5,8,120),(1,28,6,5,8,120);
INSERT INTO `Ingresso` VALUES ('2022-11-03 17:13:26',1,60);
INSERT INTO `PartecipazioneAttivita` VALUES (1,1),(1,5),(1,6),(3,2),(3,5),(3,6);
INSERT INTO `Ricevuta` VALUES (1,2022,1,1,NULL,40.00,'2022-11-05 11:34:02'),(2,2022,2,6,NULL,70.00,'2022-11-05 17:38:28');
INSERT INTO `Scheda` VALUES (1,1,'Scheda Novembre','2022-11-05');
INSERT INTO `Socio` VALUES (1,'SPNGBBSQPNTS','Spongebob','Squarepants','1998-05-29',NULL,'Annoying Avenue 5, Bikini Bottom',NULL),(2,'SQDWRDQTNTC','Squidward','Quincy Tentacles','1998-02-21',NULL,'Annoying Avenue 6, Bikini Bottom',NULL),(4,'SPMR0001ABCD0000','Mario','Jumpman','1981-05-29','+39 123 456 7890','Via Patate Fritte 5, Catania CT',1),(5,'EVWR0001ABCD0000','Wario','Hiroji Kiyotake','1992-05-29','+39 123 456 7890','Via Trifolata 8, Regno dei Funghi',1),(6,'BOWSERCRASHESIE','Bowser','Shigeru Miyamoto','1985-09-13','+39 123 456 7890','Via Del Re 1, Regno dei Koopa',1);