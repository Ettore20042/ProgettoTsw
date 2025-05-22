-- Utilizza il database corretto
USE `tswproject`;

-- Popolamento tabella address
INSERT INTO `address` (`City`, `Street`, `StreetNumber`, `ZipCode`, `Country`, `Province`) VALUES
('Roma', 'Via Appia Nuova', '123', '00184', 'Italia', 'RM'),
('Milano', 'Corso Buenos Aires', '45', '20124', 'Italia', 'MI'),
('Napoli', 'Via Toledo', '256', '80134', 'Italia', 'NA'),
('Torino', 'Via Po', '18', '10123', 'Italia', 'TO'),
('Firenze', 'Borgo Ognissanti', '77', '50123', 'Italia', 'FI'),
('Bologna', 'Via dell Indipendenza', '60', '40121', 'Italia', 'BO'),
('Genova', 'Via XX Settembre', '100', '16121', 'Italia', 'GE'),
('Palermo', 'Via Maqueda', '300', '90133', 'Italia', 'PA'),
('Verona', 'Corso Porta Borsari', '32', '37121', 'Italia', 'VR'),
('Bari', 'Corso Cavour', '150', '70121', 'Italia', 'BA'),
('Venezia', 'Calle Larga XXII Marzo', '2350', '30124', 'Italia', 'VE'),
('Catania', 'Via Etnea', '210', '95131', 'Italia', 'CT');

-- Popolamento tabella brand
INSERT INTO `brand` (`BrandName`, `LogoPath`) VALUES
('Bosch', 'logos/bosch.png'),
('Makita', 'logos/makita.png'),
('DeWalt', 'logos/dewalt.png'),
('Gardena', 'logos/gardena.png'),
('Samsung', 'logos/samsung.png'),
('LG', 'logos/lg.png'),
('Bialetti', 'logos/bialetti.png'),
('Lagostina', 'logos/lagostina.png'),
('Foppapedretti', 'logos/foppapedretti.png'),
('Black+Decker', 'logos/black_decker.png'),
('Philips', 'logos/philips.png'),
('Weber', 'logos/weber.png');

-- Popolamento tabella category (prima le categorie principali, poi le sottocategorie)
-- Categorie Principali (ParentCategory IS NULL)
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`) VALUES
('Elettrodomestici', 'elettrodomestici', NULL),    -- CategoryID presumibilmente 1
('Giardinaggio', 'giardinaggio', NULL),             -- CategoryID presumibilmente 2
('Utensileria', 'utensileria', NULL),               -- CategoryID presumibilmente 3
('Casalinghi', 'casalinghi', NULL),                 -- CategoryID presumibilmente 4
('Illuminazione', 'illuminazione', NULL),           -- CategoryID presumibilmente 5
('Arredo Esterno', 'arredo-esterno', NULL);       -- CategoryID presumibilmente 6

-- Sottocategorie (ParentCategory fa riferimento agli ID delle categorie principali)
-- Assumendo che gli ID siano sequenziali a partire da 1 per le principali
INSERT INTO `category` (`CategoryName`, `CategoryPath`, `ParentCategory`) VALUES
('Grandi Elettrodomestici', 'elettrodomestici/grandi', 1),    -- Sotto Elettrodomestici
('Piccoli Elettrodomestici', 'elettrodomestici/piccoli', 1),   -- Sotto Elettrodomestici
('Utensili da Giardino', 'giardinaggio/utensili', 2),        -- Sotto Giardinaggio
('Irrigazione', 'giardinaggio/irrigazione', 2),             -- Sotto Giardinaggio
('Elettroutensili', 'utensileria/elettroutensili', 3),      -- Sotto Utensileria
('Utensili Manuali', 'utensileria/manuali', 3),           -- Sotto Utensileria
('Cucina', 'casalinghi/cucina', 4),                       -- Sotto Casalinghi
('Decorazioni Casa', 'casalinghi/decorazioni', 4),        -- Sotto Casalinghi
('Lampade da Interno', 'illuminazione/interno', 5),       -- Sotto Illuminazione
('Lampade da Esterno', 'illuminazione/esterno', 5),       -- Sotto Illuminazione
('Mobili da Giardino', 'arredo-esterno/mobili', 6),       -- Sotto Arredo Esterno
('Barbecue e Accessori', 'arredo-esterno/barbecue', 6);    -- Sotto Arredo Esterno


-- Popolamento tabella useraccount
-- Password esempi: UtentE123!, Prova$456, Test#789A, User_Pass01, MyAcc!23B
-- Admin è 0 per false, 1 per true
INSERT INTO `useraccount` (`FirstName`, `LastName`, `Phone`, `Admin`, `Password`, `Email`) VALUES
('Mario', 'Rossi', '3331234567', 0, 'UtentE123!', 'mario.rossi@email.com'),
('Luisa', 'Bianchi', '3387654321', 0, 'Prova$456B', 'luisa.bianchi@email.com'),
('Giovanni', 'Verdi', '3471122334', 0, 'Test#789A!', 'giovanni.verdi@email.com'),
('Anna', 'Neri', '3295566778', 0, 'User_Pass01X', 'anna.neri@email.com'),
('Paolo', 'Gialli', '3669988776', 0, 'MyAcc!23B.', 'paolo.gialli@email.com'),
('Francesca', 'Azzurri', '3351231231', 0, 'SicurA321?', 'francesca.azzurri@email.com'),
('Roberto', 'Marroni', '3484564564', 0, 'Dati@2024S', 'roberto.marroni@email.com'),
('Simona', 'Viola', '3337897890', 0, 'Segret0!XY', 'simona.viola@email.com'),
('Alessandro', 'Grigi', '3406543210', 0, 'PortalE$99', 'alessandro.grigi@email.com'),
('Laura', 'Arancioni', '3390001122', 0, 'Login?Pass1', 'laura.arancioni@email.com');

-- Popolamento tabella product
-- Gli ID di BrandID e CategoryID devono corrispondere a quelli inseriti sopra.
-- Userò ID generici per BrandID e CategoryID, assumendo l'ordine di inserimento precedente.
-- BrandID: Bosch(1), Makita(2), DeWalt(3), Gardena(4), Samsung(5), LG(6), Bialetti(7), Lagostina(8), Foppapedretti(9), Black+Decker(10), Philips(11), Weber(12)
-- CategoryID: Grandi Elettrodomestici(7), Piccoli Elettrodomestici(8), Utensili da Giardino(9), Irrigazione(10), Elettroutensili(11), Utensili Manuali(12), Cucina(13), Decorazioni Casa(14), Lampade da Interno(15), Lampade da Esterno(16), Mobili da Giardino(17), Barbecue e Accessori(18)
INSERT INTO `product` (`ProductName`, `Price`, `Color`, `Material`, `Quantity`, `Description`, `BrandID`, `CategoryID`, `SalePrice`) VALUES
('Trapano Avvitatore 18V', 129.99, 'Blu/Nero', 'Plastica/Metallo', 50, 'Potente trapano avvitatore a batteria, con 2 batterie.', 1, 11, 110.00),
('Frigorifero Combinato No Frost', 699.00, 'Argento', 'Acciaio Inox', 20, 'Classe A++, capacità 300L, tecnologia No Frost.', 5, 7, NULL),
('Set Attrezzi Giardinaggio 5 Pezzi', 39.50, 'Verde/Nero', 'Metallo/Plastica', 100, 'Set completo per piccoli lavori di giardinaggio.', 4, 9, 35.00),
('Macchina da Caffè Espresso', 89.90, 'Rosso', 'Plastica/Alluminio', 75, 'Macchina per caffè espresso manuale, 15 bar.', 7, 8, NULL),
('Smerigliatrice Angolare 115mm', 75.00, 'Giallo/Nero', 'Plastica/Metallo', 40, 'Smerigliatrice potente e maneggevole per tagli e sbavature.', 3, 11, NULL),
('Tosaerba Elettrico 1200W', 149.00, 'Verde', 'Plastica', 30, 'Tosaerba elettrico con larghezza taglio 32cm.', 10, 9, 130.00),
('Forno a Microonde Digitale', 119.99, 'Bianco', 'Metallo/Vetro', 60, '20L, con grill e funzioni di scongelamento.', 6, 8, 99.99),
('Set Padelle Antiaderenti 3 Pezzi', 59.90, 'Nero', 'Alluminio', 80, 'Padelle da 20, 24, 28 cm, rivestimento antiaderente.', 8, 13, NULL),
('Lampada da Tavolo LED Design', 45.00, 'Bianco', 'Metallo/Plastica', 90, 'Luce calda, dimmerabile, design moderno.', 11, 15, 39.00),
('Idropulitrice 140 Bar', 199.00, 'Giallo', 'Plastica', 25, 'Idropulitrice ad alta pressione per pulizia esterna.', 1, 10, NULL),
('Asse da Stiro Richiudibile', 79.00, 'Legno Naturale', 'Legno/Cotone', 35, 'Asse da stiro robusto e richiudibile, salvaspazio.', 9, 14, 70.00),
('Barbecue a Carbone Portatile', 99.99, 'Nero', 'Acciaio Smaltato', 40, 'Ideale per grigliate in giardino o campeggio.', 12, 18, NULL);