-- Seleziona il database corretto su cui operare.
USE `tswproject`;

-- ============================================================================================
-- BLOCCO 1: CREAZIONE DI SOTTOCATEGORIE DI TERZO LIVELLO
-- ============================================================================================

-- Recuperiamo gli ID delle categorie di secondo livello con LIMIT 1
SET @catPiccoliElettroID = (SELECT CategoryID FROM category WHERE CategoryName = 'Piccoli Elettrodomestici' LIMIT 1);
SET @catUtensiliGiardinoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili da Giardino' LIMIT 1);
SET @catElettroutensiliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Elettroutensili' LIMIT 1);
SET @catCucinaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Cucina' LIMIT 1);
SET @catRubinetteriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Rubinetteria' LIMIT 1);

-- Inserimento condizionale delle sottocategorie di terzo livello
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Aspirapolvere e Pulizia a Vapore', 'elettrodomestici/piccoli/aspirapolvere', @catPiccoliElettroID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Aspirapolvere e Pulizia a Vapore' AND ParentCategory = @catPiccoliElettroID)
UNION ALL
SELECT 'Preparazione Cibi', 'elettrodomestici/piccoli/preparazione-cibi', @catPiccoliElettroID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Preparazione Cibi' AND ParentCategory = @catPiccoliElettroID)
UNION ALL
SELECT 'Taglio e Potatura', 'giardinaggio/utensili/taglio-potatura', @catUtensiliGiardinoID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Taglio e Potatura' AND ParentCategory = @catUtensiliGiardinoID)
UNION ALL
SELECT 'Foratura e Avvitatura', 'utensileria/elettroutensili/foratura-avvitatura', @catElettroutensiliID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Foratura e Avvitatura' AND ParentCategory = @catElettroutensiliID)
UNION ALL
SELECT 'Utensili per Pasticceria', 'casalinghi/cucina/pasticceria', @catCucinaID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Utensili per Pasticceria' AND ParentCategory = @catCucinaID)
UNION ALL
SELECT 'Miscelatori per Doccia', 'idraulica/rubinetteria/doccia', @catRubinetteriaID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Miscelatori per Doccia' AND ParentCategory = @catRubinetteriaID);

SELECT 'Blocco 1: Sottocategorie di terzo livello create con successo.' AS Stato_Esecuzione;

-- ============================================================================================
-- BLOCCO 2: INSERIMENTO DI NUOVI PRODOTTI NELLE CATEGORIE SPECIFICHE
-- ============================================================================================

-- Recuperiamo gli ID dei brand con LIMIT 1
SET @brandBoschID = (SELECT BrandID FROM brand WHERE BrandName = 'Bosch' LIMIT 1);
SET @brandMakitaID = (SELECT BrandID FROM brand WHERE BrandName = 'Makita' LIMIT 1);
SET @brandPhilipsID = (SELECT BrandID FROM brand WHERE BrandName = 'Philips' LIMIT 1);
SET @brandDeLonghiID = (SELECT BrandID FROM brand WHERE BrandName = 'De''Longhi' LIMIT 1);
SET @brandGardenaID = (SELECT BrandID FROM brand WHERE BrandName = 'Gardena' LIMIT 1);
SET @brandGroheID = (SELECT BrandID FROM brand WHERE BrandName = 'Grohe' LIMIT 1);
SET @brandLagostinaID = (SELECT BrandID FROM brand WHERE BrandName = 'Lagostina' LIMIT 1);

-- Nuove Categorie di Livello 3 con LIMIT 1
SET @catAspirapolvereID = (SELECT CategoryID FROM category WHERE CategoryName = 'Aspirapolvere e Pulizia a Vapore' LIMIT 1);
SET @catPreparazioneCibiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Preparazione Cibi' LIMIT 1);
SET @catTaglioPotaturaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Taglio e Potatura' LIMIT 1);
SET @catForaturaAvvitaturaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Foratura e Avvitatura' LIMIT 1);
SET @catPasticceriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili per Pasticceria' LIMIT 1);
SET @catMiscelatoriDocciaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Miscelatori per Doccia' LIMIT 1);

-- Inserimento dei prodotti
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