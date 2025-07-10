-- Seleziona il database corretto su cui operare.
USE `tswproject`;

-- ============================================================================================
-- BLOCCO 1: CREAZIONE DI SOTTOCATEGORIE DI TERZO LIVELLO
-- Creiamo una gerarchia più profonda. Ad esempio:
-- Elettrodomestici (Livello 1) -> Piccoli Elettrodomestici (Livello 2) -> Aspirapolvere (Livello 3)
-- ============================================================================================

-- Recuperiamo gli ID delle categorie di secondo livello che diventeranno "genitori"
SET @catPiccoliElettroID = (SELECT CategoryID FROM category WHERE CategoryName = 'Piccoli Elettrodomestici');
SET @catUtensiliGiardinoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili da Giardino');
SET @catElettroutensiliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Elettroutensili');
SET @catCucinaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Cucina');
SET @catRubinetteriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Rubinetteria');

-- Inseriamo le nuove sottocategorie di terzo livello
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`) VALUES
('Aspirapolvere e Pulizia a Vapore', 'elettrodomestici/piccoli/aspirapolvere', @catPiccoliElettroID),
('Preparazione Cibi', 'elettrodomestici/piccoli/preparazione-cibi', @catPiccoliElettroID),
('Taglio e Potatura', 'giardinaggio/utensili/taglio-potatura', @catUtensiliGiardinoID),
('Foratura e Avvitatura', 'utensileria/elettroutensili/foratura-avvitatura', @catElettroutensiliID),
('Utensili per Pasticceria', 'casalinghi/cucina/pasticceria', @catCucinaID),
('Miscelatori per Doccia', 'idraulica/rubinetteria/doccia', @catRubinetteriaID);

SELECT 'Blocco 1: Sottocategorie di terzo livello create con successo.' AS Stato_Esecuzione;


-- ============================================================================================
-- BLOCCO 2: INSERIMENTO DI NUOVI PRODOTTI NELLE CATEGORIE SPECIFICHE
-- Creiamo prodotti che appartengono a queste nuove categorie granulari.
-- ============================================================================================

-- Recuperiamo gli ID dei brand e delle nuove categorie di terzo livello
-- Brand
SET @brandBoschID = (SELECT BrandID FROM brand WHERE BrandName = 'Bosch');
SET @brandMakitaID = (SELECT BrandID FROM brand WHERE BrandName = 'Makita');
SET @brandPhilipsID = (SELECT BrandID FROM brand WHERE BrandName = 'Philips');
SET @brandDeLonghiID = (SELECT BrandID FROM brand WHERE BrandName = 'De''Longhi');
SET @brandGardenaID = (SELECT BrandID FROM brand WHERE BrandName = 'Gardena');
SET @brandGroheID = (SELECT BrandID FROM brand WHERE BrandName = 'Grohe');
SET @brandLagostinaID = (SELECT BrandID FROM brand WHERE BrandName = 'Lagostina');

-- Nuove Categorie di Livello 3
SET @catAspirapolvereID = (SELECT CategoryID FROM category WHERE CategoryName = 'Aspirapolvere e Pulizia a Vapore');
SET @catPreparazioneCibiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Preparazione Cibi');
SET @catTaglioPotaturaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Taglio e Potatura');
SET @catForaturaAvvitaturaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Foratura e Avvitatura');
SET @catPasticceriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili per Pasticceria');
SET @catMiscelatoriDocciaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Miscelatori per Doccia');

-- Inseriamo i nuovi prodotti
INSERT INTO `product` (`ProductName`, `Price`, `Color`, `Material`, `Quantity`, `Description`, `BrandID`, `CategoryID`, `SalePrice`) VALUES
('Scopa Elettrica Senza Fili Unlimited 7', 399.99, 'Bianco/Nero', 'Plastica/Alluminio', 25, 'Aspirapolvere multifunzione con tubo flessibile, spazzola motorizzata con LED e batteria intercambiabile compatibile con utensili Bosch.', @brandBoschID, @catAspirapolvereID, 349.00),
('Impastatrice Planetaria Kenwood', 289.00, 'Argento', 'Acciaio Inox', 30, 'Impastatrice con ciotola da 5L, motore da 1000W, movimento planetario e kit di accessori per impastare, montare e mescolare.', @brandDeLonghiID, @catPreparazioneCibiID, NULL),
('Seghetto alternativo a batteria 18V', 159.00, 'Verde/Nero', 'Plastica/Metallo', 40, 'Seghetto alternativo con movimento pendolare a 4 stadi, cambio lama rapido senza attrezzi. Batteria e caricatore non inclusi.', @brandMakitaID, @catForaturaAvvitaturaID, 139.00),
('Forbici per Erba a Batteria ClassicCut', 75.00, 'Verde Oliva', 'Plastica/Acciaio', 60, 'Forbici a batteria per rifinire con precisione i bordi del prato. Lame di qualità, leggere e maneggevoli.', @brandGardenaID, @catTaglioPotaturaID, NULL),
('Miscelatore Termostatico per Doccia Grohtherm 800', 149.90, 'Cromo', 'Ottone Cromato', 35, 'Miscelatore termostatico con tecnologia TurboStat per una temperatura costante e blocco di sicurezza a 38°C.', @brandGroheID, @catMiscelatoriDocciaID, 129.99),
('Set Tortiera Apribile e Stampi Muffin', 34.90, 'Grigio Scuro', 'Acciaio Antiaderente', 80, 'Set composto da tortiera a cerniera da 24cm e stampo per 12 muffin, con rivestimento antiaderente di alta qualità.', @brandLagostinaID, @catPasticceriaID, NULL),
('Avvitatore a Batteria IXO 7', 59.99, 'Verde', 'Plastica', 100, 'Iconico avvitatore a batteria con controllo della velocità variabile e set di 10 inserti. Ricarica tramite USB-C.', @brandBoschID, @catForaturaAvvitaturaID, 49.99),
('Macchina per la Pasta Atlas 150', 69.00, 'Cromo', 'Acciaio Cromato', 50, 'Macchina manuale per tirare la sfoglia e tagliare fettuccine e tagliolini. Made in Italy.', @brandLagostinaID, @catPreparazioneCibiID, 59.00);

SELECT 'Blocco 2: 8 nuovi prodotti inseriti nelle sottocategorie di terzo livello.' AS Stato_Esecuzione;

-- ============================================================================================
-- Script di popolamento aggiuntivo completato.
-- ============================================================================================