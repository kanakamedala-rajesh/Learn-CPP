//
// Created by Rajesh Kanakamedala on 3/8/21.
//

#include "service/UsersDatabase.h"

std::vector<User> UsersDatabase::getItems() {
    loggerSetup->getLogger()->info("getItems");
    return std::vector<User>();
}

User UsersDatabase::getItem(String userID) {
    loggerSetup->getLogger()->info("getItem: {}", userID);
    return User();
}

bool UsersDatabase::addItem(User item) {
    loggerSetup->getLogger()->info("addItem: {}", item.userID);
    return false;
}

bool UsersDatabase::deleteItem(String userId) {
    loggerSetup->getLogger()->info("deleteItem: {}", userId);
    return false;
}

User UsersDatabase::updateItem(User item) {
    loggerSetup->getLogger()->info("updateItem: {}", item.userID);
    return User();
}

UsersDatabase::UsersDatabase(LoggerSetup *loggerSetup) : DatabaseService(loggerSetup) {
    this->loggerSetup->getLogger()->info("UsersDatabase Constructor");
}


