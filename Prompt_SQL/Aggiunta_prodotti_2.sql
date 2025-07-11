-- Seleziona il database su cui operare
USE `tswproject`;

-- ============================================================================================
-- BLOCCO 1: INSERIMENTO NUOVI BRAND
-- ============================================================================================
INSERT INTO `brand` (`BrandName`, `LogoPath`)
SELECT 'Vimar', 'img/logos/vimar.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Vimar')
UNION ALL
SELECT 'BTicino', 'img/logos/bticino.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'BTicino')
UNION ALL
SELECT 'Mapei', 'img/logos/mapei.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Mapei')
UNION ALL
SELECT 'WD-40', 'img/logos/wd40.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'WD-40')
UNION ALL
SELECT 'De''Longhi', 'img/logos/delonghi.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'De''Longhi')
UNION ALL
SELECT 'Boero', 'img/logos/boero.png'
WHERE NOT EXISTS (SELECT 1 FROM brand WHERE BrandName = 'Boero');

-- ============================================================================================
-- BLOCCO 2: INSERIMENTO NUOVE CATEGORIE
-- ============================================================================================
-- Parte A: Nuove Categorie Principali
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Riscaldamento e Clima', 'img/icon/categories/clima.png', NULL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Riscaldamento e Clima' AND ParentCategory IS NULL)
UNION ALL
SELECT 'Pavimenti e Rivestimenti', 'img/icon/categories/pavimenti.png', NULL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Pavimenti e Rivestimenti' AND ParentCategory IS NULL);

-- Parte B: Nuove Sottocategorie con LIMIT 1
SET @utensileriaID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensileria' AND ParentCategory IS NULL LIMIT 1);
SET @verniciID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Vernici e Pitture' AND ParentCategory IS NULL LIMIT 1);
SET @riscaldamentoID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Riscaldamento e Clima' AND ParentCategory IS NULL LIMIT 1);
SET @pavimentiID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Pavimenti e Rivestimenti' AND ParentCategory IS NULL LIMIT 1);
SET @illuminazioneID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Illuminazione' AND ParentCategory IS NULL LIMIT 1);
SET @sicurezzaID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Sicurezza' AND ParentCategory IS NULL LIMIT 1);
SET @elettrodomesticiID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Elettrodomestici' AND ParentCategory IS NULL LIMIT 1);
SET @casalinghiID_B = (SELECT CategoryID FROM category WHERE CategoryName = 'Casalinghi' AND ParentCategory IS NULL LIMIT 1);

-- Inserimento condizionale sottocategorie
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`)
SELECT 'Materiale Elettrico', 'utensileria/materiale-elettrico', @utensileriaID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Materiale Elettrico' AND ParentCategory = @utensileriaID_B)
UNION ALL
SELECT 'Accessori per Elettroutensili', 'utensileria/accessori', @utensileriaID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Accessori per Elettroutensili' AND ParentCategory = @utensileriaID_B)
UNION ALL
SELECT 'Trattamenti per Legno', 'vernici/trattamenti-legno', @verniciID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Trattamenti per Legno' AND ParentCategory = @verniciID_B)
UNION ALL
SELECT 'Deumidificatori', 'riscaldamento/deumidificatori', @riscaldamentoID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Deumidificatori' AND ParentCategory = @riscaldamentoID_B)
UNION ALL
SELECT 'Stufe Elettriche', 'riscaldamento/stufe', @riscaldamentoID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Stufe Elettriche' AND ParentCategory = @riscaldamentoID_B)
UNION ALL
SELECT 'Adesivi e Sigillanti', 'pavimenti/adesivi-sigillanti', @pavimentiID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Adesivi e Sigillanti' AND ParentCategory = @pavimentiID_B)
UNION ALL
SELECT 'Strisce LED e Accessori', 'illuminazione/strisce-led', @illuminazioneID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Strisce LED e Accessori' AND ParentCategory = @illuminazioneID_B)
UNION ALL
SELECT 'Allarmi e Sensori', 'sicurezza/allarmi-sensori', @sicurezzaID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Allarmi e Sensori' AND ParentCategory = @sicurezzaID_B)
UNION ALL
SELECT 'Cura della Persona', 'elettrodomestici/cura-persona', @elettrodomesticiID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Cura della Persona' AND ParentCategory = @elettrodomesticiID_B)
UNION ALL
SELECT 'Organizzazione Spazi', 'casalinghi/organizzazione', @casalinghiID_B
WHERE NOT EXISTS (SELECT 1 FROM category WHERE CategoryName = 'Organizzazione Spazi' AND ParentCategory = @casalinghiID_B);

-- ============================================================================================
-- BLOCCO 3: INSERIMENTO NUOVI PRODOTTI
-- ============================================================================================

-- Recuperiamo gli ID con LIMIT 1 per evitare errori
SET @brandVimarID = (SELECT BrandID FROM brand WHERE BrandName = 'Vimar' LIMIT 1);
SET @brandBticinoID = (SELECT BrandID FROM brand WHERE BrandName = 'BTicino' LIMIT 1);
SET @brandMapeiID = (SELECT BrandID FROM brand WHERE BrandName = 'Mapei' LIMIT 1);
SET @brandWd40ID = (SELECT BrandID FROM brand WHERE BrandName = 'WD-40' LIMIT 1);
SET @brandDeLonghiID = (SELECT BrandID FROM brand WHERE BrandName = 'De''Longhi' LIMIT 1);
SET @brandBoeroID = (SELECT BrandID FROM brand WHERE BrandName = 'Boero' LIMIT 1);
SET @brandBoschID = (SELECT BrandID FROM brand WHERE BrandName = 'Bosch' LIMIT 1);
SET @brandMakitaID = (SELECT BrandID FROM brand WHERE BrandName = 'Makita' LIMIT 1);
SET @brandSikkensID = (SELECT BrandID FROM brand WHERE BrandName = 'Sikkens' LIMIT 1);
SET @brandPhilipsID = (SELECT BrandID FROM brand WHERE BrandName = 'Philips' LIMIT 1);
SET @brandFoppapedrettiID = (SELECT BrandID FROM brand WHERE BrandName = 'Foppapedretti' LIMIT 1);
SET @brandGroheID = (SELECT BrandID FROM brand WHERE BrandName = 'Grohe' LIMIT 1);
SET @brandCisaID = (SELECT BrandID FROM brand WHERE BrandName = 'Cisa' LIMIT 1);

-- Categorie con LIMIT 1
SET @catMaterialeElettricoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Materiale Elettrico' LIMIT 1);
SET @catAccessoriElettroutensiliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Accessori per Elettroutensili' LIMIT 1);
SET @catTrattamentiLegnoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Trattamenti per Legno' LIMIT 1);
SET @catDeumidificatoriID = (SELECT CategoryID FROM category WHERE CategoryName = 'Deumidificatori' LIMIT 1);
SET @catStufeElettricheID = (SELECT CategoryID FROM category WHERE CategoryName = 'Stufe Elettriche' LIMIT 1);
SET @catAdesiviSigillantiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Adesivi e Sigillanti' LIMIT 1);
SET @catStrisceLedID = (SELECT CategoryID FROM category WHERE CategoryName = 'Strisce LED e Accessori' LIMIT 1);
SET @catAllarmiSensoriID = (SELECT CategoryID FROM category WHERE CategoryName = 'Allarmi e Sensori' LIMIT 1);
SET @catUtensiliManualiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili Manuali' LIMIT 1);
SET @catRubinetteriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Rubinetteria' LIMIT 1);
SET @catSerratureID = (SELECT CategoryID FROM category WHERE CategoryName = 'Serrature e Cilindri' LIMIT 1);
SET @catPittureMuraliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Pitture Murali' LIMIT 1);
SET @catCuraPersonaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Cura della Persona' LIMIT 1);
SET @catOrganizzazioneID = (SELECT CategoryID FROM category WHERE CategoryName = 'Organizzazione Spazi' LIMIT 1);

-- Inserimento prodotti (stesso INSERT del tuo file)
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