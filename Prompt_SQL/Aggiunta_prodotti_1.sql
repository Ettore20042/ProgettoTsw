-- Utilizza il database corretto per assicurarsi che i comandi vengano eseguiti nel contesto giusto.
USE `tswproject`;

-- ============================================================================================
-- BLOCCO 1: INSERIMENTO NUOVI BRAND
-- Aggiungiamo nuovi brand che verranno associati ai nuovi prodotti.
-- ============================================================================================
INSERT INTO `brand` (`BrandName`, `LogoPath`) VALUES
('Grohe', 'img/logos/grohe.png'),
('Cisa', 'img/logos/cisa.png'),
('Sikkens', 'img/logos/sikkens.png');

SELECT 'Blocco 1: Nuovi brand (Grohe, Cisa, Sikkens) inseriti con successo.' AS Stato_Esecuzione;

-- ============================================================================================
-- BLOCCO 2: INSERIMENTO NUOVE CATEGORIE
-- Questo blocco è diviso in due parti: prima le categorie principali (radice),
-- poi le sottocategorie che fanno riferimento a quelle principali.
-- ============================================================================================

-- Parte A: Inserimento delle nuove Categorie Principali
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`) VALUES
('Idraulica', 'img/icon/categories/idraulica.png', NULL),
('Sicurezza', 'img/icon/categories/sicurezza.png', NULL),
('Vernici e Pitture', 'img/icon/categories/vernici.png', NULL);

SELECT 'Blocco 2A: Nuove categorie principali (Idraulica, Sicurezza, Vernici) inserite.' AS Stato_Esecuzione;

-- Parte B: Inserimento delle Sottocategorie
-- Usiamo le variabili per recuperare dinamicamente gli ID delle categorie principali,
-- rendendo lo script robusto e indipendente dagli ID auto-incrementali specifici.

-- Recuperiamo gli ID delle categorie principali (sia esistenti che nuove)
SET @elettrodomesticiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Elettrodomestici' AND ParentCategory IS NULL);
SET @casalinghiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Casalinghi' AND ParentCategory IS NULL);
SET @idraulicaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Idraulica' AND ParentCategory IS NULL);
SET @sicurezzaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Sicurezza' AND ParentCategory IS NULL);
SET @verniciID = (SELECT CategoryID FROM category WHERE CategoryName = 'Vernici e Pitture' AND ParentCategory IS NULL);

-- Inseriamo le nuove sottocategorie usando le variabili
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`) VALUES
('Cura della Persona', 'elettrodomestici/cura-persona', @elettrodomesticiID),
('Organizzazione Spazi', 'casalinghi/organizzazione', @casalinghiID),
('Rubinetteria', 'idraulica/rubinetteria', @idraulicaID),
('Sistemi di Scarico', 'idraulica/scarico', @idraulicaID),
('Serrature e Cilindri', 'sicurezza/serrature', @sicurezzaID),
('Pitture Murali', 'vernici/murali', @verniciID);

SELECT 'Blocco 2B: Nuove sottocategorie inserite con successo.' AS Stato_Esecuzione;

-- ============================================================================================
-- BLOCCO 3: INSERIMENTO NUOVI PRODOTTI
-- Inseriamo nuovi prodotti che utilizzano i brand e le categorie (sia esistenti che nuovi).
-- Anche qui, usiamo le variabili per garantire la coerenza delle chiavi esterne.
-- ============================================================================================

-- Recuperiamo gli ID dei brand e delle categorie che ci servono per i nuovi prodotti
SET @brandGroheID = (SELECT BrandID FROM brand WHERE BrandName = 'Grohe');
SET @brandCisaID = (SELECT BrandID FROM brand WHERE BrandName = 'Cisa');
SET @brandSikkensID = (SELECT BrandID FROM brand WHERE BrandName = 'Sikkens');
SET @brandPhilipsID = (SELECT BrandID FROM brand WHERE BrandName = 'Philips');
SET @brandFoppapedrettiID = (SELECT BrandID FROM brand WHERE BrandName = 'Foppapedretti');
SET @brandMakitaID = (SELECT BrandID FROM brand WHERE BrandName = 'Makita');

SET @catRubinetteriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Rubinetteria');
SET @catSerratureID = (SELECT CategoryID FROM category WHERE CategoryName = 'Serrature e Cilindri');
SET @catPittureMuraliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Pitture Murali');
SET @catCuraPersonaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Cura della Persona');
SET @catOrganizzazioneID = (SELECT CategoryID FROM category WHERE CategoryName = 'Organizzazione Spazi');
SET @catUtensiliManualiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili Manuali');

-- Inseriamo i nuovi prodotti
INSERT INTO `product` (`ProductName`, `Price`, `Color`, `Material`, `Quantity`, `Description`, `BrandID`, `CategoryID`, `SalePrice`) VALUES
('Miscelatore Lavello Eurosmart', 119.90, 'Cromo', 'Ottone Cromato', 40, 'Miscelatore monocomando per lavello con canna alta girevole e limitatore di temperatura. Tecnologia GROHE SilkMove per un movimento morbido e preciso.', @brandGroheID, @catRubinetteriaID, 99.90),
('Cilindro di Sicurezza Europeo Asix P8', 59.99, 'Ottone Nichelato', 'Ottone', 60, 'Cilindro a profilo europeo con 8 perni e sistema anti-bumping e anti-picking. Include 3 chiavi punzonate e carta di proprietà.', @brandCisaID, @catSerratureID, NULL),
('Idropittura Murale Lavabile Alpha Rezisto', 75.50, 'Bianco', 'Acrilico', 30, 'Pittura murale super lavabile e resistente alle macchie, ideale per ambienti ad alto traffico come cucine e corridoi. Latte da 10 litri.', @brandSikkensID, @catPittureMuraliID, 68.00),
('Rasoio Elettrico Shaver Series 5000', 89.90, 'Blu Elettrico', 'Plastica/Acciaio', 50, 'Rasoio con testine flessibili a 5 direzioni, tecnologia SkinIQ e utilizzo Wet & Dry. 60 minuti di autonomia con 1 ora di ricarica.', @brandPhilipsID, @catCuraPersonaID, NULL),
('Set 3 Scatole Contenitore in Tessuto', 24.99, 'Grigio Chiaro', 'Tessuto/Cartone', 120, 'Set di tre scatole pieghevoli per organizzare armadi e scaffali. Dimensioni varie per abiti, accessori e documenti.', @brandFoppapedrettiID, @catOrganizzazioneID, 19.99),
('Set Chiavi a Bussola 40 Pezzi', 45.00, 'Cromo/Nero', 'Acciaio al Cromo-Vanadio', 70, 'Valigetta completa con chiavi a bussola, cricchetto, prolunghe e inserti per viti. Ideale per manutenzione auto e fai-da-te.', @brandMakitaID, @catUtensiliManualiID, NULL);

SELECT 'Blocco 3: Nuovi prodotti inseriti con successo.' AS Stato_Esecuzione;

-- ============================================================================================
-- Script di popolamento completato.
-- ============================================================================================