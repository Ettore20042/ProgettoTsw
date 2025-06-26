CREATE TABLE user_address (
                              UserID INT NOT NULL,
                              AddressID INT NOT NULL,
                              address_type ENUM('shipping', 'billing') NOT NULL,
                              is_primary BOOLEAN NOT NULL DEFAULT FALSE,
                              address_nickname VARCHAR(50) NULL,

                              PRIMARY KEY (UserID, AddressID, address_type),

                              FOREIGN KEY (UserID) REFERENCES user_account(UserID)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE,

                              FOREIGN KEY (AddressID) REFERENCES address(AddressID)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE
);