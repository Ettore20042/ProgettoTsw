-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: tswproject
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Roma','Via Appia Nuova','123','00184','Italia','RM'),(2,'Milano','Corso Buenos Aires','45','20124','Italia','MI'),(3,'Napoli','Via Toledo','256','80134','Italia','NA'),(4,'Torino','Via Po','18','10123','Italia','TO'),(5,'Firenze','Borgo Ognissanti','77','50123','Italia','FI'),(6,'Bologna','Via dell Indipendenza','60','40121','Italia','BO'),(7,'Genova','Via XX Settembre','100','16121','Italia','GE'),(8,'Palermo','Via Maqueda','300','90133','Italia','PA'),(9,'Verona','Corso Porta Borsari','32','37121','Italia','VR'),(10,'Bari','Corso Cavour','150','70121','Italia','BA'),(11,'Venezia','Calle Larga XXII Marzo','2350','30124','Italia','VE'),(12,'Catania','Via Etnea','210','95131','Italia','CT');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'logos/bosch.png','Bosch'),(2,'logos/makita.png','Makita'),(3,'logos/dewalt.png','DeWalt'),(4,'logos/gardena.png','Gardena'),(5,'logos/samsung.png','Samsung'),(6,'logos/lg.png','LG'),(7,'logos/bialetti.png','Bialetti'),(8,'logos/lagostina.png','Lagostina'),(9,'logos/foppapedretti.png','Foppapedretti'),(10,'logos/black_decker.png','Black+Decker'),(11,'logos/philips.png','Philips'),(12,'logos/weber.png','Weber');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Elettrodomestici','elettrodomestici',NULL),(2,'Giardinaggio','giardinaggio',NULL),(3,'Utensileria','utensileria',NULL),(4,'Casalinghi','casalinghi',NULL),(5,'Illuminazione','illuminazione',NULL),(6,'Arredo Esterno','arredo-esterno',NULL),(7,'Grandi Elettrodomestici','elettrodomestici/grandi',1),(8,'Piccoli Elettrodomestici','elettrodomestici/piccoli',1),(9,'Utensili da Giardino','giardinaggio/utensili',2),(10,'Irrigazione','giardinaggio/irrigazione',2),(11,'Elettroutensili','utensileria/elettroutensili',3),(12,'Utensili Manuali','utensileria/manuali',3),(13,'Cucina','casalinghi/cucina',4),(14,'Decorazioni Casa','casalinghi/decorazioni',4),(15,'Lampade da Interno','illuminazione/interno',5),(16,'Lampade da Esterno','illuminazione/esterno',5),(17,'Mobili da Giardino','arredo-esterno/mobili',6),(18,'Barbecue e Accessori','arredo-esterno/barbecue',6);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'img/categories/elettrodomestici/grandi/Samsung_frigorifero_combinato_1.webp',1,'Samsung frigorifero combinato ecoflex',2),(2,'img/categories/elettrodomestici/grandi/Samsung_frigorifero_combinato_2.webp',2,'Samsung frigorifero combinato ecoflex',2),(3,'img/categories/elettrodomestici/grandi/Samsung_frigorifero_combinato_3.webp',3,'Samsung frigorifero combinato ecoflex',2),(4,'img/categories/elettrodomestici/grandi/Samsung_frigorifero_combinato_4.webp',4,'Samsung frigorifero combinato ecoflex',2),(5,'img/categories/giardinaggio/utensili/Set_giardinaggio_5pezzi_1.webp',1,'Gardena Set attrezzi giardinaggio 5 pezzi',3),(6,'img/categories/giardinaggio/utensili/Set_giardinaggio_5pezzi_2.webp',2,'Gardena Set attrezzi giardinaggio 5 pezzi',3),(7,'img/categories/giardinaggio/utensili/Set_giardinaggio_5pezzi_3.webp',3,'Gardena Set attrezzi giardinaggio 5 pezzi',3),(8,'img/categories/giardinaggio/utensili/Set_giardinaggio_5pezzi_4.webp',4,'Gardena Set attrezzi giardinaggio 5 pezzi',3),(9,'img/categories/elettrodomestici/piccoli/Bialetti_macchina_espresso_1.webp',1,'Bialetti macchina caffè espresso',4),(10,'img/categories/elettrodomestici/piccoli/Bialetti_macchina_espresso_2.webp',2,'Bialetti macchina caffè espresso',4),(11,'img/categories/elettrodomestici/piccoli/Bialetti_macchina_espresso_3.webp',3,'Bialetti macchina caffè espresso',4),(12,'img/categories/elettrodomestici/piccoli/Bialetti_macchina_espresso_4.webp',4,'Bialetti macchina caffè espresso',4),(13,'img/categories/elettrodomestici/piccoli/Bialetti_macchina_espresso_5.webp',5,'Bialetti macchina caffè espresso',4),(14,'img/categories/elettrodomestici/piccoli/LG_forno_microonde_1.webp',1,'LG forno microonde',7),(15,'img/categories/elettrodomestici/piccoli/LG_forno_microonde_2.webp',2,'LG forno microonde',7),(16,'img/categories/elettrodomestici/piccoli/LG_forno_microonde_3.webp',3,'LG forno microonde',7),(17,'img/categories/elettrodomestici/piccoli/LG_forno_microonde_4.webp',4,'LG forno microonde',7),(18,'img/categories/elettrodomestici/piccoli/LG_forno_microonde_5.webp',5,'LG forno microonde',7),(19,'img/categories/utensileria/elettroutensili/DeWalt_smerigliatrice_angolare_115mm_1.webp',1,'DeWalt smerigliatrice angolare',5),(20,'img/categories/utensileria/elettroutensili/DeWalt_smerigliatrice_angolare_115mm_2.webp',2,'DeWalt smerigliatrice angolare',5),(21,'img/categories/utensileria/elettroutensili/DeWalt_smerigliatrice_angolare_115mm_3.webp',3,'DeWalt smerigliatrice angolare',5),(22,'img/categories/utensileria/elettroutensili/DeWalt_smerigliatrice_angolare_115mm_4.webp',4,'DeWalt smerigliatrice angolare',5),(23,'img/categories/giardinaggio/utensili/Black&Decker_tosaerba_elettrico_1200w_1.webp',1,'Black&Decker tosaerba elettrico 1200w',6),(24,'img/categories/giardinaggio/utensili/Black&Decker_tosaerba_elettrico_1200w_2.webp',2,'Black&Decker tosaerba elettrico 1200w',6),(25,'img/categories/giardinaggio/utensili/Black&Decker_tosaerba_elettrico_1200w_3.webp',3,'Black&Decker tosaerba elettrico 1200w',6),(26,'img/categories/giardinaggio/utensili/Black&Decker_tosaerba_elettrico_1200w_4.webp',4,'Black&Decker tosaerba elettrico 1200w',6),(27,'img/categories/giardinaggio/utensili/Black&Decker_tosaerba_elettrico_1200w_5.webp',5,'Black&Decker tosaerba elettrico 1200w',6),(28,'img/categories/casalinghi/cucina/Lagostina_set_padelle_antiaderenti_3pezzi_1.webp',1,'Lagostina set padelle antiaderenti',8),(29,'img/categories/casalinghi/cucina/Lagostina_set_padelle_antiaderenti_3pezzi_2.webp',2,'Lagostina set padelle antiaderenti',8),(30,'img/categories/casalinghi/cucina/Lagostina_set_padelle_antiaderenti_3pezzi_3.webp',3,'Lagostina set padelle antiaderenti',8),(31,'img/categories/casalinghi/cucina/Lagostina_set_padelle_antiaderenti_3pezzi_4.webp',4,'Lagostina set padelle antiaderenti',8);
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `orderitem`
--

LOCK TABLES `orderitem` WRITE;
/*!40000 ALTER TABLE `orderitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Trapano Avvitatore 18V',129.99,'Blu/Nero','Plastica/Metallo',50,'Potente trapano avvitatore a batteria, con 2 batterie.',1,11,110),(2,'Frigorifero Combinato No Frost',699,'Argento','Acciaio Inox',20,'Il frigorifero Combinato RB34C671DSA in classe D della serie EcoFlex è dotato di sistema Air Space, una straordinaria tecnologia che attraverso l’isolante più efficace permette di conservare di più, nello stesso spazio, risparmiando energia. Grazie a tecnologie esclusive come Space Max, la serie Ecoflex regala - nelle dimensioni esterne di un frigorifero standard - oltre 30 litri di capacità in più. In più il frigorifero è dotato di AI Energy Mode, la funzione della App SmartThings per gestire le impostazioni del frigo anche da remoto che permette di ridurre i consumi energetici fino al 15%. Per una conservazione ottimale, il sistema All Around Cooling garantisce una temperatura costante e uniforme in ogni zona del frigorifero. Senza dimenticarsi della tecnologia Total No Frost, che mantiene costanti i livelli di temperatura e umidità evitando la formazione di ghiaccio, muffa e batteri. A tutto questo si aggiunge il compressore Digital Inverter garantito 20 anni, che modula automaticamente la potenza in base alla necessità, riducendo i consumi e il rumore.',5,7,NULL),(3,'Set Attrezzi Giardinaggio 5 Pezzi',39.5,'Verde/Nero','Metallo/Plastica',100,'Il kit utensili GARDENA è un set ideale per tutti i piccoli lavori di giardinaggio. Il set comprende un trapiantatore, un dissodatore, un paio di forbici e una scopina. Tutti gli attrezzi trovano spazio nell\'ampio contenitore in plastica, il cui coperchio può essere utilizzato anche come paletta.\n\nPratico e funzionale\n\nLa spaziosa custodia di plastica protegge attrezzi manuali e altri utensili dalla sporcizia e dalle intemperie. La custodia può essere montata anche a parete.\n\nUtilizzo flessibile\n\nGrazie al profilo in gomma, il coperchio della custodia può essere utilizzato come paletta.\n\nTrapiantatore\n\nIl trapiantatore compatto GARDENA è particolarmente indicato per piantare e trapiantare in fioriere o vasi.\n\nEstirpatore\n\nCon il piccolo dissodatore GARDENA si può smuovere facilmente il terreno delle fioriere e dei vasi.\n\nSpazzola\n\nTerriccio e sporcizia possono essere comodamente rimossi con la spazzola manuale GARDENA. Le setole fitte e morbide offrono ottimi risultati di pulizia.\n\nForbici da giardino\n\nLe forbici da balcone GARDENA sono particolarmente indicate per essere utilizzate nei lavori di giardinaggio in balconi e terrazzi e tagliano fiori, erbe aromatiche, rami sottili e molto altro ancora. Le lame sono in acciaio inossidabile. L’impugnatura è regolabile in due posizioni per adattarsi agli oggetti da tagliare e il blocco di sicurezza è inseribile con una sola mano.\n\nLa garanzia di 25 anni assicura un\'elevata qualità\n*Dopo la registrazione su gardena.com/registrazione da effettuarsi entro 3 mesi dall\'acquisto. Condizioni di garanzia su gardena.com/garanzia.',4,9,35),(4,'Macchina da Caffè Espresso',89.9,'Rosso','Plastica/Alluminio',75,'Il design elegante e compatto della Macchina Espresso Dama si adatta perfettamente a qualsiasi cucina, mentre il sistema di preparazione rapido ti permette di preparare un espresso di alta qualità in pochi minuti. Le Cialde Bialetti sono pensate per garantire un aroma intenso e un gusto corposo, con una selezione che soddisfa anche i palati più esigenti.',7,8,NULL),(5,'Smerigliatrice Angolare 115mm',75,'Giallo/Nero','Plastica/Metallo',40,'Smerigliatrice angolare 115mm 800W DeWalt DWE4056 no volt.\n\nDimensioni ultra compatte per un bilanciamento ed un‘ergonomia migliori\nInterruttore No Volt che previene le partenze accidentali in caso di caduta di tensione e possibilità di utilizzo con accensione continua\nSistema a spazzole e portaspazzole con nuovo design in grado di garantire una durata maggiore\nScatola ingranaggi ribassata per le applicazioni in spazi ridotti\nAvvolgimento dello statore completamente ricoperto da resina epossidica per maggior durata\nDesign con cuscinetto a sfere per un‘efficienza estrema\nSpazzole auto-espellenti per una più lunga vita del motore\nPulsante di blocco dell‘albero posizionato sopra la scatola ingranaggi per la massima protezione quando si opera in spazi ristretti\nMotore con protezione dalle abrasioni a garanzia di una durata massima\nPartenza lenta per migliorare il controllo e la sicurezza\nLa confezione di vendita include smerigliatrice angolare + in dotazione: protezione disco, impugnatura laterale orientabile, flangia e controflangia, chiave di servizio.\n\nCaratteristiche tecniche smerigliatrice angolare DeWalt\nPeso: 1,8 kg\nPotenza assorbita: 800 Watt\nVelocità di rotazione: 11800 Giri/min\nMax. diametro del disco: 115 mm\nFiletto dell‘Alberino: M14\nLunghezza: 270 mm\nAltezza: 80 mm\nVibrazioni mano/braccio – smerigliatura: 9,4 m/s²\nIncertezza (Vibrazioni): 7,5 m/s²\nVibrazioni mano/braccio – levigatura: 1,5 m/s²\nIncertezza (vibrazioni): 1,5 m/s²\nPressione acustica: 91 dB(A)\nIncertezza (Potenza sonora): 3 dB(A)\nPotenza acustica: 101 dB(A\nColore: giallo/nero\nTipo alimentazione: elettrica con filo\nTipo di interruttore: Slitta Switch\nVoltaggio: 230 volt\nBatterie/pile non necessarie',3,11,NULL),(6,'Tosaerba Elettrico 1200W',149,'Nero/Arancione','Plastica',30,'Rasaerba 1200W con 32cm di taglio, ideale per giardini di piccole dimensioni, con nuova impugnatura Bike che permette un\'ottima manovrabilità. Il nuovo design delle lame garantisce l\'80% in più di capacità di raccolta rispetto alla gamma precedente.',10,9,130),(7,'Forno a Microonde Digitale',119.99,'Bianco','Metallo/Vetro',60,'CARATTERISTICHE: Microonde con grill - Dimensioni LxAxP 476 x 272 x 388 mm, Potenza Microonde 1000W, Grill 900W, Microonde + Grill 1450W - Capacità 23L - Colore Bianco\nNEOCHEF: Forno a microonde con tecnologia Smart Inverter e Grill. Scalda, scongela e cuoci i cibi risparmiando tempo ed energia grazie al controllo della potenza, per risultati da vero chef\nCONTROLLO TEMPERATURA: I comandi del pannello consentono di regolare la temperatura secondo le tue esigenze, per scaldare e scongelare i cibi in modo uniforme dalla superficie al cuore dell\'alimento\nCUCINA SANA: Cucina in modo più naturale con le funzioni Healthy Fry e Healthy Roasting. LG Smart Inverter offre una cottura in grado di scogliere il 72% di grassi in più per ricette leggere e gustose\nCOTTURA VERSATILE: Scalda, scongela, cuoci, friggi, griglia: non porre limiti alla fantasia! Grazie alla combinazione di microonde e grill e al controllo della potenza puoi preparare qualsiasi piatto',6,8,99.99),(8,'Set Padelle Antiaderenti 3 Pezzi',59.9,'Nero','Alluminio',80,'Ofelia completa la gamma dei nuovi arrivi nel comparto delle padelle antiaderenti. Il suo rivestimento le conferisce un’ottima resistenza agli utensili da cucina in metallo, favorendo la sua durata e la sua sicurezza. La manicatura soft touch garantisce una presa sicura. Il fondo in alluminio dallo spessore di 4 mm è tornito, per una migliore stabilità sul piano cottura. Ofelia è rivestita con METEORITE® RESISTIUM, un antiaderente di alta qualità a 4 strati perfettamente resistente all’uso di utensili metallici. Il rivestimento, come tutti gli antiaderenti Lagostina, è sicuro, grazie alla garanzia per l’assenza di PFOA, cadmio e piombo, ed è facile da pulire. Ofelia presenta la tecnologia Lagospot® che indica la temperatura di cottura ideale per preservare il sapore degli alimenti.',8,13,NULL),(9,'Lampada da Tavolo LED Design',45,'Bianco','Metallo/Plastica',90,'Luce calda, dimmerabile, design moderno.',11,15,39),(10,'Idropulitrice 140 Bar',199,'Giallo','Plastica',25,'Idropulitrice ad alta pressione per pulizia esterna.',1,10,NULL),(11,'Asse da Stiro Richiudibile',79,'Legno Naturale','Legno/Cotone',35,'Asse da stiro robusto e richiudibile, salvaspazio.',9,14,70),(12,'Barbecue a Carbone Portatile',99.99,'Nero','Acciaio Smaltato',40,'Ideale per grigliate in giardino o campeggio.',12,18,NULL),(13,'Lavatrice Carica Frontale 8kg',499,'Bianco','Acciaio/Plastica',25,'Classe A+++, 1200 giri, display LED, 15 programmi.',6,7,450),(14,'Martello Demolitore Perforatore SDS Plus',189.5,'Blu','Metallo/Plastica',15,'Potenza 1050W, ideale per lavori di demolizione leggera e foratura.',1,11,NULL),(15,'Tagliasiepi a Batteria 18V',99,'Verde Oliva','Plastica/Acciaio',30,'Lunghezza lama 50cm, leggero e maneggevole, senza batteria.',4,9,85),(16,'Aspirapolvere Senza Sacco Ciclonico',139,'Grigio/Rosso','Plastica',40,'Potente aspirazione, filtro HEPA, facile da svuotare.',11,8,NULL),(17,'Scala Pieghevole in Alluminio 5 Gradini',65,'Argento','Alluminio',50,'Leggera e robusta, con piedini antiscivolo, portata 150kg.',9,12,55),(18,'Miscelatore Monocomando per Lavello Cucina',78.9,'Cromo','Ottone Cromato',60,'Design moderno, canna alta girevole, cartuccia ceramica.',8,13,NULL),(19,'Plafoniera LED Quadrata 24W Luce Naturale',32,'Bianco','Acrilico/Metallo',70,'Luce uniforme 4000K, ideale per cucina, bagno, corridoio.',11,15,28),(20,'Set Irrigazione a Goccia per 20 Vasi',42.5,'Nero/Verde','Plastica',35,'Sistema completo per irrigare automaticamente piante in vaso.',4,10,NULL),(21,'Forbici da Potatura Professionali Bypass',28,'Rosso/Nero','Acciaio SK5/Alluminio',90,'Lame affilate per tagli precisi e puliti, impugnatura ergonomica.',2,9,25),(22,'Frullatore a Immersione 3-in-1',49.99,'Acciaio Inox/Nero','Acciaio Inox/Plastica',55,'Include tritatutto e frusta, potenza 800W.',1,8,NULL),(23,'Dondolo da Giardino 3 Posti con Tettuccio',199,'Beige','Acciaio/Poliestere',10,'Robusto dondolo con cuscini e tettuccio parasole regolabile.',9,17,179),(24,'Levigatrice Orbitale Palmare 200W',55,'Nero/Arancione','Plastica',40,'Ideale per finiture su legno e metallo, con sacchetto raccoglipolvere.',10,11,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `useraccount`
--

LOCK TABLES `useraccount` WRITE;
/*!40000 ALTER TABLE `useraccount` DISABLE KEYS */;
INSERT INTO `useraccount` VALUES (1,'Mario','Rossi','3331234567',0,'UtentE123!','mario.rossi@email.com'),(2,'Luisa','Bianchi','3387654321',0,'Prova$456B','luisa.bianchi@email.com'),(3,'Giovanni','Verdi','3471122334',0,'Test#789A!','giovanni.verdi@email.com'),(4,'Anna','Neri','3295566778',0,'User_Pass01X','anna.neri@email.com'),(5,'Paolo','Gialli','3669988776',0,'MyAcc!23B.','paolo.gialli@email.com'),(6,'Francesca','Azzurri','3351231231',0,'SicurA321?','francesca.azzurri@email.com'),(7,'Roberto','Marroni','3484564564',0,'Dati@2024S','roberto.marroni@email.com'),(8,'Simona','Viola','3337897890',0,'Segret0!XY','simona.viola@email.com'),(9,'Alessandro','Grigi','3406543210',0,'PortalE$99','alessandro.grigi@email.com'),(10,'Laura','Arancioni','3390001122',0,'Login?Pass1','laura.arancioni@email.com');
/*!40000 ALTER TABLE `useraccount` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-20 23:02:26
