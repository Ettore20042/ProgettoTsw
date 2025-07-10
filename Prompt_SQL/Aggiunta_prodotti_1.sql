-- Utilizza il database corretto per assicurarsi che i comandi vengano eseguiti nel contesto giusto.
USE `tswproject`;

-- ============================================================================================
-- BLOCCO 1: INSERIMENTO NUOVI BRAND
-- Prima verifichiamo se esistono già, poi inseriamo solo quelli mancanti
-- ============================================================================================

-- Inserimento condizionale dei brand per evitare duplicati
INSERT INTO `brand` (`BrandName`, `LogoPath`)
SELECT 'Grohe', 'img/logos/grohe.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Grohe');

INSERT INTO `brand` (`BrandName`, `LogoPath`)
SELECT 'Cisa', 'img/logos/cisa.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Cisa');

INSERT INTO `brand` (`BrandName`, `LogoPath`)
SELECT 'Sikkens', 'img/logos/sikkens.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Sikkens');

SELECT 'Blocco 1: Brand (Grohe, Cisa, Sikkens) verificati e inseriti se necessario.' AS Stato_Esecuzione;

-- ============================================================================================
-- BLOCCO 2: INSERIMENTO NUOVE CATEGORIE
-- ============================================================================================

-- Parte A: Inserimento delle nuove Categorie Principali
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Idraulica', 'img/icon/categories/idraulica.png', NULL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Idraulica' AND ParentCategory IS NULL);

INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Sicurezza', 'img/icon/categories/sicurezza.png', NULL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Sicurezza' AND ParentCategory IS NULL);

INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Vernici e Pitture', 'img/icon/categories/vernici.png', NULL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Vernici e Pitture' AND ParentCategory IS NULL);

SELECT 'Blocco 2A: Nuove categorie principali verificate e inserite se necessario.' AS Stato_Esecuzione;

-- Parte B: Inserimento delle Sottocategorie
SET @elettrodomesticiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Elettrodomestici' AND ParentCategory IS NULL LIMIT 1);
SET @casalinghiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Casalinghi' AND ParentCategory IS NULL LIMIT 1);
SET @idraulicaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Idraulica' AND ParentCategory IS NULL LIMIT 1);
SET @sicurezzaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Sicurezza' AND ParentCategory IS NULL LIMIT 1);
SET @verniciID = (SELECT CategoryID FROM category WHERE CategoryName = 'Vernici e Pitture' AND ParentCategory IS NULL LIMIT 1);

-- Inserimento condizionale delle sottocategorie
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Cura della Persona', 'elettrodomestici/cura-persona', @elettrodomesticiID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Cura della Persona' AND ParentCategory = @elettrodomesticiID);

INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Organizzazione Spazi', 'casalinghi/organizzazione', @casalinghiID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Organizzazione Spazi' AND ParentCategory = @casalinghiID);

INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Rubinetteria', 'idraulica/rubinetteria', @idraulicaID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Rubinetteria' AND ParentCategory = @idraulicaID);

INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Sistemi di Scarico', 'idraulica/scarico', @idraulicaID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Sistemi di Scarico' AND ParentCategory = @idraulicaID);

INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Serrature e Cilindri', 'sicurezza/serrature', @sicurezzaID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Serrature e Cilindri' AND ParentCategory = @sicurezzaID);

INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Pitture Murali', 'vernici/murali', @verniciID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Pitture Murali' AND ParentCategory = @verniciID);

SELECT 'Blocco 2B: Nuove sottocategorie verificate e inserite se necessario.' AS Stato_Esecuzione;

-- ============================================================================================
-- BLOCCO 3: INSERIMENTO NUOVI PRODOTTI
-- ============================================================================================

-- Recuperiamo gli ID dei brand con LIMIT 1 per evitare errori
SET @brandGroheID = (SELECT BrandID FROM brand WHERE BrandName = 'Grohe' LIMIT 1);
SET @brandCisaID = (SELECT BrandID FROM brand WHERE BrandName = 'Cisa' LIMIT 1);
SET @brandSikkensID = (SELECT BrandID FROM brand WHERE BrandName = 'Sikkens' LIMIT 1);
SET @brandPhilipsID = (SELECT BrandID FROM brand WHERE BrandName = 'Philips' LIMIT 1);
SET @brandFoppapedrettiID = (SELECT BrandID FROM brand WHERE BrandName = 'Foppapedretti' LIMIT 1);
SET @brandMakitaID = (SELECT BrandID FROM brand WHERE BrandName = 'Makita' LIMIT 1);

SET @catRubinetteriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Rubinetteria' LIMIT 1);
SET @catSerratureID = (SELECT CategoryID FROM category WHERE CategoryName = 'Serrature e Cilindri' LIMIT 1);
SET @catPittureMuraliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Pitture Murali' LIMIT 1);
SET @catCuraPersonaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Cura della Persona' LIMIT 1);
SET @catOrganizzazioneID = (SELECT CategoryID FROM category WHERE CategoryName = 'Organizzazione Spazi' LIMIT 1);
SET @catUtensiliManualiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili Manuali' LIMIT 1);

-- Inseriamo i nuovi prodotti
INSERT INTO `product` (`ProductName`, `Price`, `Color`, `Material`, `Quantity`, `Description`, `BrandID`, `CategoryID`, `SalePrice`) VALUES
                                                                                                                                         ('Miscelatore Lavello Eurosmart', 119.90, 'Cromo', 'Ottone Cromato', 40, 'Miscelatore monocomando per lavello con canna alta girevole e limitatore di temperatura. Tecnologia GROHE SilkMove per un movimento morbido e preciso.', @brandGroheID, @catRubinetteriaID, 99.90),
                                                                                                                                         ('Cilindro di Sicurezza Europeo Asix P8', 59.99, 'Ottone Nichelato', 'Ottone', 60, 'Cilindro a profilo europeo con 8 perni e sistema anti-bumping e anti-picking. Include 3 chiavi punzonate e carta di proprietà.', @brandCisaID, @catSerratureID, NULL),
                                                                                                                                         ('Idropittura Murale Lavabile Alpha Rezisto', 75.50, 'Bianco', 'Acrilico', 30, 'Pittura murale super lavabile e resistente alle macchie, ideale per ambienti ad alto traffico come cucine e corridoi. Latte da 10 litri.', @brandSikkensID, @catPittureMuraliID, 68.00),
                                                                                                                                         ('Rasoio Elettrico Shaver Series 5000', 89.90, 'Blu Elettrico', 'Plastica/Acciaio', 50, 'Rasoio con testine flessibili a 5 direzioni, tecnologia SkinIQ e utilizzo Wet & Dry. 60 minuti di autonomia con 1 ora di ricarica.', @brandPhilipsID, @catCuraPersonaID, NULL),
                                                                                                                                         ('Set 3 Scatole Contenitore in Tessuto', 24.99, 'Grigio Chiaro', 'Tessuto/Cartone', 120, 'Set di tre scatole pieghevoli per organizzare armadi e scaffali. Dimensioni varie per abiti, accessori e documenti.', @brandFoppapedrettiID, @catOrganizzazioneID, 19.99),
                                                                                                                                         ('Set Chiavi a Bussola 40 Pezzi', 45.00, 'Cromo/Nero', 'Acciaio al Cromo-Vanadio', 70, 'Valigetta completa con chiavi a bussola, cricchetto, prolunghe e inserti per viti. Ideale per manutenzione auto e fai-da-te.', @brandMakitaID, @catUtensiliManualiID, NULL);

SELECT 'Blocco 3: Nuovi prodotti inseriti con successo.' AS Stato_Esecuzione;