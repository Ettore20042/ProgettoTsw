CREATE TABLE user_address (
                              UserID INT NOT NULL,
                              AddressID INT NOT NULL,
                              address_type ENUM('shipping', 'billing') NOT NULL,
                              is_primary BOOLEAN NOT NULL DEFAULT FALSE,
                              address_nickname VARCHAR(50) NULL,

                              PRIMARY KEY (UserID, AddressID, address_type),

                              FOREIGN KEY (UserID) REFERENCES UserAccount(UserID)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE,

                              FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE
);