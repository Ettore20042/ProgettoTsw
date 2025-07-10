-- Seleziona il database corretto su cui operare.
USE `tswproject`;

-- ============================================================================================
-- BLOCCO 1: INSERIMENTO NUOVI BRAND
-- Introduciamo nuovi brand per diversificare l'offerta di prodotti.
-- ============================================================================================
INSERT INTO `brand` (`BrandName`, `LogoPath`) VALUES
('Osram', 'img/logos/osram.png'),
('Stanley', 'img/logos/stanley.png'),
('Fiskars', 'img/logos/fiskars.png'),
('Einhell', 'img/logos/einhell.png'),
('Saratoga', 'img/logos/saratoga.png'),
('Tefal', 'img/logos/tefal.png'),
('V33', 'img/logos/v33.png');

SELECT 'Blocco 1: 7 nuovi brand inseriti con successo.' AS Stato_Esecuzione;

-- ============================================================================================
-- BLOCCO 2: INSERIMENTO NUOVE SOTTOCATEGORIE
-- Aggiungiamo una nuova sottocategoria per classificare meglio i nuovi prodotti.
-- ============================================================================================
SET @utensileriaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensileria' AND ParentCategory IS NULL);
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`) VALUES
('Colle e Nastri', 'utensileria/colle-nastri', @utensileriaID);

SELECT 'Blocco 2: Nuova sottocategoria "Colle e Nastri" creata.' AS Stato_Esecuzione;

-- ============================================================================================
-- BLOCCO 3: INSERIMENTO DEI 30 NUOVI PRODOTTI
-- Prima definiamo tutte le variabili per gli ID, poi eseguiamo un unico grande INSERT.
-- ============================================================================================

-- Recuperiamo gli ID di Brand e Categorie che ci serviranno.
-- Brand (sia vecchi che nuovi)
SET @brandOsramID = (SELECT BrandID FROM brand WHERE BrandName = 'Osram');
SET @brandStanleyID = (SELECT BrandID FROM brand WHERE BrandName = 'Stanley');
SET @brandFiskarsID = (SELECT BrandID FROM brand WHERE BrandName = 'Fiskars');
SET @brandEinhellID = (SELECT BrandID FROM brand WHERE BrandName = 'Einhell');
SET @brandSaratogaID = (SELECT BrandID FROM brand WHERE BrandName = 'Saratoga');
SET @brandTefalID = (SELECT BrandID FROM brand WHERE BrandName = 'Tefal');
SET @brandV33ID = (SELECT BrandID FROM brand WHERE BrandName = 'V33');
SET @brandPhilipsID = (SELECT BrandID FROM brand WHERE BrandName = 'Philips');
SET @brandWeberID = (SELECT BrandID FROM brand WHERE BrandName = 'Weber');
SET @brandFoppapedrettiID = (SELECT BrandID FROM brand WHERE BrandName = 'Foppapedretti');
SET @brandSikkensID = (SELECT BrandID FROM brand WHERE BrandName = 'Sikkens');
SET @brandMapeiID = (SELECT BrandID FROM brand WHERE BrandName = 'Mapei');
SET @brandBoschID = (SELECT BrandID FROM brand WHERE BrandName = 'Bosch');
SET @brandDeWaltID = (SELECT BrandID FROM brand WHERE BrandName = 'DeWalt');
SET @brandGroheID = (SELECT BrandID FROM brand WHERE BrandName = 'Grohe');

-- Categorie (sia vecchie che nuove)
SET @catLampadeEsternoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Lampade da Esterno');
SET @catMobiliGiardinoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Mobili da Giardino');
SET @catBarbecueID = (SELECT CategoryID FROM category WHERE CategoryName = 'Barbecue e Accessori');
SET @catTrattamentiLegnoID = (SELECT CategoryID FROM category WHERE CategoryName = 'Trattamenti per Legno');
SET @catAdesiviSigillantiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Adesivi e Sigillanti');
SET @catColleNastriID = (SELECT CategoryID FROM category WHERE CategoryName = 'Colle e Nastri');
SET @catUtensiliManualiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Utensili Manuali');
SET @catTaglioPotaturaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Taglio e Potatura');
SET @catElettroutensiliID = (SELECT CategoryID FROM category WHERE CategoryName = 'Elettroutensili');
SET @catCucinaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Cucina');
SET @catMiscelatoriDocciaID = (SELECT CategoryID FROM category WHERE CategoryName = 'Miscelatori per Doccia');
SET @catPreparazioneCibiID = (SELECT CategoryID FROM category WHERE CategoryName = 'Preparazione Cibi');
SET @catAspirapolvereID = (SELECT CategoryID FROM category WHERE CategoryName = 'Aspirapolvere e Pulizia a Vapore');
SET @catSerratureID = (SELECT CategoryID FROM category WHERE CategoryName = 'Serrature e Cilindri');

-- Inseriamo i 30 nuovi prodotti
INSERT INTO `product` (`ProductName`, `Price`, `Color`, `Material`, `Quantity`, `Description`, `BrandID`, `CategoryID`, `SalePrice`) VALUES
-- Lampade da Esterno (4 prodotti)
('Faretto LED da Giardino con Picchetto', 29.90, 'Nero', 'Alluminio', 80, 'Faretto orientabile IP65, ideale per illuminare piante e sentieri. Luce calda 3000K.', @brandOsramID, @catLampadeEsternoID, 24.90),
('Applique da Parete Esterna "Endura Style"', 55.00, 'Antracite', 'Acciaio Inox', 45, 'Lampada da parete dal design moderno con diffusione della luce verso l\'alto e il basso.', @brandOsramID, @catLampadeEsternoID, NULL),
('Catena Luminosa 10 Lampadine LED Vintage', 38.50, 'Nero', 'Gomma/Vetro', 60, 'Lunghezza 10 metri, ideale per feste in giardino e terrazzi. Lampadine a filamento LED incluse.', @brandPhilipsID, @catLampadeEsternoID, NULL),
('Proiettore LED 50W con Sensore di Movimento', 49.99, 'Nero', 'Alluminio/Vetro', 30, 'Potente proiettore IP65 con sensore PIR regolabile per sicurezza e illuminazione automatica.', @brandPhilipsID, @catLampadeEsternoID, 42.00),

-- Mobili da Giardino (3 prodotti)
('Sdraio Prendisole Pieghevole', 89.00, 'Blu', 'Alluminio/Textilene', 25, 'Lettino prendisole leggero con schienale regolabile in 5 posizioni e tettuccio parasole.', @brandFoppapedrettiID, @catMobiliGiardinoID, NULL),
('Tavolo da Giardino Estensibile 150-200cm', 259.00, 'Grigio Antracite', 'Alluminio', 15, 'Tavolo robusto e leggero, si estende per ospitare fino a 8 persone.', @brandFoppapedrettiID, @catMobiliGiardinoID, 229.00),
('Baule da Esterno Portacuscini', 79.90, 'Marrone', 'Resina Effetto Rattan', 40, 'Capacità 280 litri, resistente agli agenti atmosferici, ideale per riporre cuscini e attrezzi.', @brandFoppapedrettiID, @catMobiliGiardinoID, NULL),

-- Barbecue e Accessori (3 prodotti)
('Griglia a Gas Spirit II E-310', 599.00, 'Nero', 'Acciaio Smaltato', 10, 'Barbecue a gas con 3 bruciatori, griglie di cottura in ghisa e sistema di accensione GS4.', @brandWeberID, @catBarbecueID, 549.00),
('Custodia Premium per Barbecue', 65.00, 'Nero', 'Poliestere', 30, 'Custodia impermeabile e traspirante per proteggere il barbecue dalle intemperie.', @brandWeberID, @catBarbecueID, NULL),
('Set 3 Utensili Inox per BBQ', 34.90, 'Acciaio', 'Acciaio Inox/Gomma', 50, 'Set composto da pinza, spatola e forchettone in acciaio inox con impugnatura antiscivolo.', @brandWeberID, @catBarbecueID, 29.90),

-- Trattamenti per Legno e Colle (4 prodotti)
('Olio Protettivo per Teak e Legni Esotici', 19.99, 'Trasparente', 'Olio Naturale', 40, 'Nutre e protegge i mobili da giardino in legno, ripristinandone il colore originale. Latta da 1L.', @brandV33ID, @catTrattamentiLegnoID, 17.50),
('Vernice Flatting per Esterni ad Alta Protezione', 25.50, 'Trasparente Satinato', 'Resina uretanica', 35, 'Vernice protettiva per legno esposto a sole e pioggia, con filtro UV. Latta da 0,75L.', @brandSikkensID, @catTrattamentiLegnoID, NULL),
('Colla per Legno D3 Vinilica', 9.80, 'Bianco (Trasp. da asciutta)', 'Vinilica', 100, 'Colla ad alta resistenza all\'acqua, ideale per costruzioni in legno per interni ed esterni. Flacone da 750g.', @brandMapeiID, @catColleNastriID, NULL),
('Nastro Americano Extra Forte', 8.50, 'Grigio Argento', 'Tela Rinforzata', 200, 'Nastro adesivo multiuso ultra resistente per riparazioni temporanee. Rotolo da 50m x 50mm.', @brandSaratogaID, @catColleNastriID, NULL),

-- Utensileria Manuale e Elettroutensili (6 prodotti)
('Cutter a Lama Retrattile FatMax', 15.90, 'Giallo/Nero', 'Metallo', 90, 'Cutter professionale con corpo in metallo e meccanismo di cambio rapido della lama.', @brandStanleyID, @catUtensiliManualiID, NULL),
('Sega a Mano per Legno JetCut', 18.00, 'Giallo/Nero', 'Acciaio/Plastica', 70, 'Sega con dentatura a 3 angoli per tagli rapidi e precisi. Lunghezza lama 500mm.', @brandStanleyID, @catUtensiliManualiID, 15.00),
('Troncarami a Ingranaggi PowerGear X', 55.00, 'Nero/Arancione', 'Acciaio/FiberComp', 30, 'Troncarami con meccanismo brevettato che triplica la potenza di taglio. Ideale per rami fino a 50mm.', @brandFiskarsID, @catTaglioPotaturaID, 49.90),
('Avvitatore a Percussione a Batteria TE-CD 18', 119.00, 'Rosso/Nero', 'Plastica/Metallo', 25, 'Potente avvitatore della famiglia Power X-Change (batteria non inclusa), con percussione attivabile.', @brandEinhellID, @catForaturaAvvitaturaID, 99.00),
('Levigatrice Roto-orbitale TE-RS 40 E', 79.99, 'Rosso/Nero', 'Plastica', 35, 'Levigatrice potente con regolazione elettronica dei giri per adattarsi a diversi materiali.', @brandEinhellID, @catElettroutensiliID, NULL),
('Soffiatore a Batteria GE-CL 18', 65.00, 'Rosso/Nero', 'Plastica', 40, 'Soffiatore leggero e maneggevole per la pulizia di giardini e terrazzi. Batteria non inclusa.', @brandEinhellID, @catUtensiliGiardinoID, 55.00),

-- Cucina e Preparazione Cibi (4 prodotti)
('Bistecchiera Antiaderente XL', 49.90, 'Nero', 'Alluminio Pressofuso', 50, 'Bistecchiera 28x28 cm con rivestimento rinforzato al titanio, adatta a tutte le fonti di calore, inclusa induzione.', @brandTefalID, @catCucinaID, 42.00),
('Friggitrice ad Aria Easy Fry', 99.99, 'Nero', 'Plastica', 40, 'Friggitrice ad aria da 4.2L per cucinare con poco o senza olio. 8 programmi preimpostati.', @brandTefalID, @catPreparazioneCibiID, 89.00),
('Robot da Cucina Multifunzione', 129.00, 'Bianco/Grigio', 'Plastica/Acciaio', 30, 'Robot compatto con ciotola da 2.1L, include lame, dischi per affettare/grattugiare e frullatore.', @brandBoschID, @catPreparazioneCibiID, 110.00),
('Spremiagrumi Elettrico con Leva', 65.00, 'Acciaio Inox', 'Acciaio Inox', 45, 'Spremiagrumi professionale con leva a pressione per una spremitura facile e senza sforzo.', @brandDeWaltID, @catPreparazioneCibiID, NULL), -- Usiamo un brand "robusto" per un apparecchio solido

-- Prodotti Vari (3 prodotti)
('Soffione Doccia a 3 Getti Vitalio Start', 29.90, 'Cromo', 'ABS Cromato', 80, 'Soffione doccia con tecnologia DreamSpray per una distribuzione uniforme dell\'acqua e sistema anticalcare SpeedClean.', @brandGroheID, @catMiscelatoriDocciaID, NULL),
('Aspiratore Solidi e Liquidi 1250W', 85.00, 'Rosso/Nero', 'Plastica/Acciaio', 20, 'Aspiratutto con serbatoio da 20L, funzione soffiante e set completo di accessori per ogni tipo di pulizia.', @brandEinhellID, @catAspirapolvereID, NULL),
('Serratura Elettrica da Applicare', 45.00, 'Grigio', 'Acciaio Verniciato', 40, 'Serratura elettrica per cancelli e portoni in ferro, con pulsante interno. Entrata regolabile.', @brandCisaID, @catSerratureID, 39.00);

SELECT 'Blocco 3: 30 nuovi prodotti inseriti con successo in varie categorie.' AS Stato_Esecuzione;