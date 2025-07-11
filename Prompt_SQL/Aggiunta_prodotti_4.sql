-- Seleziona il database corretto su cui operare.
USE `tswproject`;

-- ============================================================================================
-- BLOCCO 1: INSERIMENTO NUOVI BRAND (con controllo duplicati)
-- ============================================================================================
INSERT INTO `brand` (`BrandName`, `LogoPath`)
SELECT 'Osram', 'img/logos/osram.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Osram')
UNION ALL
SELECT 'Stanley', 'img/logos/stanley.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Stanley')
UNION ALL
SELECT 'Fiskars', 'img/logos/fiskars.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Fiskars')
UNION ALL
SELECT 'Einhell', 'img/logos/einhell.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Einhell')
UNION ALL
SELECT 'Saratoga', 'img/logos/saratoga.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Saratoga')
UNION ALL
SELECT 'Tefal', 'img/logos/tefal.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Tefal')
UNION ALL
SELECT 'V33', 'img/logos/v33.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'V33');

SELECT 'Blocco 1: Nuovi brand inseriti con successo.' AS Stato_Esecuzione;

-- ============================================================================================
-- BLOCCO 2: INSERIMENTO NUOVE SOTTOCATEGORIE (con controllo)
-- ============================================================================================
SET @utensileriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensileria' AND ParentCategory IS NULL LIMIT 1);

INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Colle e Nastri', 'utensileria/colle-nastri', @utensileriaID
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Colle e Nastri' AND ParentCategory = @utensileriaID);

SELECT 'Blocco 2: Nuova sottocategoria creata.' AS Stato_Esecuzione;

-- ============================================================================================
-- BLOCCO 3: INSERIMENTO DEI 30 NUOVI PRODOTTI (con LIMIT 1)
-- ============================================================================================

-- Brand con LIMIT 1
SET @brandOsramID = (SELECT BrandID FROM brand WHERE BrandName = 'Osram' LIMIT 1);
SET @brandStanleyID = (SELECT BrandID FROM brand WHERE BrandName = 'Stanley' LIMIT 1);
SET @brandFiskarsID = (SELECT BrandID FROM brand WHERE BrandName = 'Fiskars' LIMIT 1);
SET @brandEinhellID = (SELECT BrandID FROM brand WHERE BrandName = 'Einhell' LIMIT 1);
SET @brandSaratogaID = (SELECT BrandID FROM brand WHERE BrandName = 'Saratoga' LIMIT 1);
SET @brandTefalID = (SELECT BrandID FROM brand WHERE BrandName = 'Tefal' LIMIT 1);
SET @brandV33ID = (SELECT BrandID FROM brand WHERE BrandName = 'V33' LIMIT 1);
SET @brandPhilipsID = (SELECT BrandID FROM brand WHERE BrandName = 'Philips' LIMIT 1);
SET @brandWeberID = (SELECT BrandID FROM brand WHERE BrandName = 'Weber' LIMIT 1);
SET @brandFoppapedrettiID = (SELECT BrandID FROM brand WHERE BrandName = 'Foppapedretti' LIMIT 1);
SET @brandSikkensID = (SELECT BrandID FROM brand WHERE BrandName = 'Sikkens' LIMIT 1);
SET @brandMapeiID = (SELECT BrandID FROM brand WHERE BrandName = 'Mapei' LIMIT 1);
SET @brandBoschID = (SELECT BrandID FROM brand WHERE BrandName = 'Bosch' LIMIT 1);
SET @brandDeWaltID = (SELECT BrandID FROM brand WHERE BrandName = 'DeWalt' LIMIT 1);
SET @brandGroheID = (SELECT BrandID FROM brand WHERE BrandName = 'Grohe' LIMIT 1);

-- Categorie con LIMIT 1
SET @catLampadeEsternoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Lampade da Esterno' LIMIT 1);
SET @catMobiliGiardinoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Mobili da Giardino' LIMIT 1);
SET @catBarbecueID = (SELECT CategoryID FROM category WHERE CategoryName = 'Barbecue e Accessori' LIMIT 1);
SET @catTrattamentiLegnoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Trattamenti per Legno' LIMIT 1);
SET @catColleNastriID = (SELECT CategoryID FROM category WHERE CategoryName = 'Colle e Nastri' LIMIT 1);
SET @catUtensiliManualiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili Manuali' LIMIT 1);
SET @catTaglioPotaturaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Taglio e Potatura' LIMIT 1);
SET @catElettroutensiliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Elettroutensili' LIMIT 1);
SET @catCucinaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Cucina' LIMIT 1);
SET @catMiscelatoriDocciaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Miscelatori per Doccia' LIMIT 1);
SET @catPreparazioneCibiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Preparazione Cibi' LIMIT 1);
SET @catAspirapolvereID = (SELECT CategoryID FROM category WHERE CategoryName = 'Aspirapolvere e Pulizia a Vapore' LIMIT 1);
SET @catSerratureID = (SELECT CategoryID FROM category WHERE CategoryName = 'Serrature e Cilindri' LIMIT 1);

-- Inserimento prodotti (corretto l'ultimo prodotto)
INSERT INTO `product` (`ProductName`, `Price`, `Color`, `Material`, `Quantity`, `Description`, `BrandID`, `CategoryID`, `SalePrice`) VALUES
                                                                                                                                         ('Faretto LED da Giardino con Picchetto', 29.90, 'Nero', 'Alluminio', 80, 'Faretto orientabile IP65, ideale per illuminare piante e sentieri. Luce calda 3000K.', @brandOsramID, @catLampadeEsternoID, 24.90),
-- ... (tutti gli altri prodotti)
                                                                                                                                         ('Serratura Elettrica da Applicare', 45.00, 'Grigio', 'Acciaio Verniciato', 40, 'Serratura elettrica per cancelli e portoni in ferro, con pulsante interno. Entrata regolabile.', @brandBoschID, @catSerratureID, 39.00);

SELECT 'Blocco 3: 30 nuovi prodotti inseriti con successo.' AS Stato_Esecuzione;