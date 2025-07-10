-- Seleziona il database su cui operare
USE `tswproject`;

-- ============================================================================================
-- BLOCCO 1: INSERIMENTO NUOVI BRAND
-- ============================================================================================
INSERT INTO `brand` (`BrandName`, `LogoPath`) VALUES
('Vimar', 'img/logos/vimar.png'),
('BTicino', 'img/logos/bticino.png'),
('Mapei', 'img/logos/mapei.png'),
('WD-40', 'img/logos/wd40.png'),
('De''Longhi', 'img/logos/delonghi.png'), -- Apostrofo "escapato" correttamente
('Boero', 'img/logos/boero.png');

-- ============================================================================================
-- BLOCCO 2: INSERIMENTO NUOVE CATEGORIE
-- ============================================================================================
-- Parte A: Nuove Categorie Principali
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`) VALUES
('Riscaldamento e Clima', 'img/icon/categories/clima.png', NULL),
('Pavimenti e Rivestimenti', 'img/icon/categories/pavimenti.png', NULL);

-- Parte B: Nuove Sottocategorie
SET @utensileriaID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensileria' AND ParentCategory IS NULL);
SET @verniciID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Vernici e Pitture' AND ParentCategory IS NULL);
SET @riscaldamentoID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Riscaldamento e Clima' AND ParentCategory IS NULL);
SET @pavimentiID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Pavimenti e Rivestimenti' AND ParentCategory IS NULL);
SET @illuminazioneID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Illuminazione' AND ParentCategory IS NULL);
SET @sicurezzaID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Sicurezza' AND ParentCategory IS NULL);
SET @elettrodomesticiID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Elettrodomestici' AND ParentCategory IS NULL);
SET @casalinghiID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Casalinghi' AND ParentCategory IS NULL);

INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`) VALUES
('Materiale Elettrico', 'utensileria/materiale-elettrico', @utensileriaID_B),
('Accessori per Elettroutensili', 'utensileria/accessori', @utensileriaID_B),
('Trattamenti per Legno', 'vernici/trattamenti-legno', @verniciID_B),
('Deumidificatori', 'riscaldamento/deumidificatori', @riscaldamentoID_B),
('Stufe Elettriche', 'riscaldamento/stufe', @riscaldamentoID_B),
('Adesivi e Sigillanti', 'pavimenti/adesivi-sigillanti', @pavimentiID_B),
('Strisce LED e Accessori', 'illuminazione/strisce-led', @illuminazioneID_B),
('Allarmi e Sensori', 'sicurezza/allarmi-sensori', @sicurezzaID_B),
('Cura della Persona', 'elettrodomestici/cura-persona', @elettrodomesticiID_B),
('Organizzazione Spazi', 'casalinghi/organizzazione', @casalinghiID_B);


-- ============================================================================================
-- BLOCCO 3: INSERIMENTO NUOVI PRODOTTI
-- ============================================================================================

-- Recuperiamo TUTTI gli ID necessari per i prodotti in una sola volta
-- Brand
SET @brandVimarID = (SELECT BrandID FROM brand WHERE BrandName = 'Vimar');
SET @brandBticinoID = (SELECT BrandID FROM brand WHERE BrandName = 'BTicino');
SET @brandMapeiID = (SELECT BrandID FROM brand WHERE BrandName = 'Mapei');
SET @brandWd40ID = (SELECT BrandID FROM brand WHERE BrandName = 'WD-40');
SET @brandDeLonghiID = (SELECT BrandID FROM brand WHERE BrandName = 'De''Longhi');
SET @brandBoeroID = (SELECT BrandID FROM brand WHERE BrandName = 'Boero');
SET @brandBoschID = (SELECT BrandID FROM brand WHERE BrandName = 'Bosch');
SET @brandMakitaID = (SELECT BrandID FROM brand WHERE BrandName = 'Makita');
SET @brandSikkensID = (SELECT BrandID FROM brand WHERE BrandName = 'Sikkens');
SET @brandWeberID = (SELECT BrandID FROM brand WHERE BrandName = 'Weber');
SET @brandPhilipsID = (SELECT BrandID FROM brand WHERE BrandName = 'Philips');
SET @brandBialettiID = (SELECT BrandID FROM brand WHERE BrandName = 'Bialetti');
SET @brandLagostinaID = (SELECT BrandID FROM brand WHERE BrandName = 'Lagostina');
SET @brandFoppapedrettiID = (SELECT BrandID FROM brand WHERE BrandName = 'Foppapedretti');
SET @brandGroheID = (SELECT BrandID FROM brand WHERE BrandName = 'Grohe');
SET @brandCisaID = (SELECT BrandID FROM brand WHERE BrandName = 'Cisa');

-- Categorie
SET @catMaterialeElettricoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Materiale Elettrico');
SET @catAccessoriElettroutensiliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Accessori per Elettroutensili');
SET @catTrattamentiLegnoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Trattamenti per Legno');
SET @catDeumidificatoriID = (SELECT CategoryID FROM category WHERE CategoryName = 'Deumidificatori');
SET @catStufeElettricheID = (SELECT CategoryID FROM category WHERE CategoryName = 'Stufe Elettriche');
SET @catAdesiviSigillantiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Adesivi e Sigillanti');
SET @catStrisceLedID = (SELECT CategoryID FROM category WHERE CategoryName = 'Strisce LED e Accessori');
SET @catAllarmiSensoriID = (SELECT CategoryID FROM category WHERE CategoryName = 'Allarmi e Sensori');
SET @catPiccoliElettroID = (SELECT CategoryID FROM category WHERE CategoryName = 'Piccoli Elettrodomestici');
SET @catUtensiliManualiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili Manuali');
SET @catBarbecueID = (SELECT CategoryID FROM category WHERE CategoryName = 'Barbecue e Accessori');
SET @catLampadeEsternoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Lampade da Esterno');
SET @catCucinaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Cucina');
SET @catRubinetteriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Rubinetteria');
SET @catSerratureID = (SELECT CategoryID FROM category WHERE CategoryName = 'Serrature e Cilindri');
SET @catPittureMuraliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Pitture Murali');
SET @catCuraPersonaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Cura della Persona');
SET @catOrganizzazioneID = (SELECT CategoryID FROM category WHERE CategoryName = 'Organizzazione Spazi');

-- Inseriamo i nuovi prodotti
INSERT INTO `product` (`ProductName`, `Price`, `Color`, `Material`, `Quantity`, `Description`, `BrandID`, `CategoryID`, `SalePrice`) VALUES
('Miscelatore Lavello Eurosmart', 119.90, 'Cromo', 'Ottone Cromato', 40, 'Miscelatore monocomando per lavello con canna alta girevole e limitatore di temperatura. Tecnologia GROHE SilkMove per un movimento morbido e preciso.', @brandGroheID, @catRubinetteriaID, 99.90),
('Cilindro di Sicurezza Europeo Asix P8', 59.99, 'Ottone Nichelato', 'Ottone', 60, 'Cilindro a profilo europeo con 8 perni e sistema anti-bumping e anti-picking. Include 3 chiavi punzonate e carta di proprietà.', @brandCisaID, @catSerratureID, NULL),
('Idropittura Murale Lavabile Alpha Rezisto', 75.50, 'Bianco', 'Acrilico', 30, 'Pittura murale super lavabile e resistente alle macchie, ideale per ambienti ad alto traffico come cucine e corridoi. Latte da 10 litri.', @brandSikkensID, @catPittureMuraliID, 68.00),
('Rasoio Elettrico Shaver Series 5000', 89.90, 'Blu Elettrico', 'Plastica/Acciaio', 50, 'Rasoio con testine flessibili a 5 direzioni, tecnologia SkinIQ e utilizzo Wet & Dry. 60 minuti di autonomia con 1 ora di ricarica.', @brandPhilipsID, @catCuraPersonaID, NULL),
('Set 3 Scatole Contenitore in Tessuto', 24.99, 'Grigio Chiaro', 'Tessuto/Cartone', 120, 'Set di tre scatole pieghevoli per organizzare armadi e scaffali. Dimensioni varie per abiti, accessori e documenti.', @brandFoppapedrettiID, @catOrganizzazioneID, 19.99),
('Set Chiavi a Bussola 40 Pezzi', 45.00, 'Cromo/Nero', 'Acciaio al Cromo-Vanadio', 70, 'Valigetta completa con chiavi a bussola, cricchetto, prolunghe e inserti per viti. Ideale per manutenzione auto e fai-da-te.', @brandMakitaID, @catUtensiliManualiID, NULL),
('Presa Bipasso P17/11', 5.90, 'Bianco', 'Tecnopolimero', 250, 'Presa standard italiano 2P+T 16A, colore bianco. Serie Plana.', @brandVimarID, @catMaterialeElettricoID, NULL),
('Videocitofono Connesso Classe 100X', 249.00, 'Bianco', 'Plastica', 20, 'Videocitofono Wi-Fi con display LCD da 5 pollici. Rispondi alle chiamate direttamente dal tuo smartphone.', @brandBticinoID, @catMaterialeElettricoID, 229.00),
('Adesivo per Piastrelle Keraflex Maxi S1', 28.50, 'Grigio', 'Cementizio', 80, 'Adesivo cementizio ad alte prestazioni a scivolamento verticale nullo per piastrelle in ceramica e materiale lapideo. Sacco da 25kg.', @brandMapeiID, @catAdesiviSigillantiID, NULL),
('Multifunzione Spray Lubrificante 450ml', 9.99, 'Blu/Giallo', 'Aerosol', 300, 'L\'originale spray multifunzione: elimina cigolii, espelle l\'umidità, pulisce e protegge dalla ruggine.', @brandWd40ID, @catUtensiliManualiID, 7.99),
('Deumidificatore Tasciugo AriaDry Multi 16L', 299.00, 'Bianco', 'Plastica', 25, 'Deumidifica fino a 16 litri al giorno, con filtro anti-polvere e funzione laundry per asciugare il bucato.', @brandDeLonghiID, @catDeumidificatoriID, NULL),
('Smalto Satinato all\'Acqua', 18.90, 'Bianco Ghiaccio', 'A base acquosa', 100, 'Smalto acrilico satinato per interni ed esterni, inodore e a rapida essiccazione. Barattolo da 0,75L.', @brandBoeroID, @catPittureMuraliID, 15.00),
('Set 10 Punte per Metallo HSS-G', 15.50, 'Oro/Argento', 'Acciaio HSS', 150, 'Set di 10 punte per trapano rettificate di alta precisione, per forare metalli ferrosi e non ferrosi. Misure da 1 a 10 mm.', @brandBoschID, @catAccessoriElettroutensiliID, NULL),
('Disco Diamantato Universale 115mm', 12.80, 'Argento', 'Acciaio/Diamante', 90, 'Disco diamantato per smerigliatrice, adatto al taglio a secco di cemento, mattoni e materiali edili generici.', @brandMakitaID, @catAccessoriElettroutensiliID, 9.90),
('Impregnante per Legno Esterno', 22.00, 'Noce Chiaro', 'A base solvente', 60, 'Impregnante protettivo a lunga durata per legno esposto alle intemperie. Finitura cerata. Latta da 0,75L.', @brandSikkensID, @catTrattamentiLegnoID, NULL),
('Termoconvettore Elettrico con Termostato', 55.00, 'Bianco', 'Metallo/Plastica', 40, 'Stufa elettrica a convezione, 3 livelli di potenza (750/1250/2000W) e termostato regolabile.', @brandDeLonghiID, @catStufeElettricheID, 49.00),
('Kit Striscia LED 5 Metri RGB con Telecomando', 29.99, 'Multicolore', 'Silicone/Plastica', 110, 'Striscia LED adesiva e flessibile, con telecomando per cambiare colore, intensità e modalità di illuminazione.', @brandPhilipsID, @catStrisceLedID, NULL),
('Sensore di Movimento PIR da Interno', 35.00, 'Bianco', 'Plastica', 50, 'Sensore di movimento a infrarossi passivo, ideale per sistemi di allarme. Copertura 12 metri.', @brandBticinoID, @catAllarmiSensoriID, NULL);