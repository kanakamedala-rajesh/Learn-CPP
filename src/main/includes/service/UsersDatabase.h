//
// Created by Rajesh Kanakamedala on 3/8/21.
//

#ifndef LEARN_CPP_USERSDATABASE_H
#define LEARN_CPP_USERSDATABASE_H

#include "LoggerSetup.h"
#include "User.h"
#include "DatabaseService.h"

class UsersDatabase : public DatabaseService<User> {
public:
    explicit UsersDatabase(LoggerSetup *loggerSetup);

    std::vector<User> getItems() override;

    User getItem(String userID) override;

    bool addItem(User item) override;

    bool deleteItem(String userId) override;

    User updateItem(User item) override;
};


#endif //LEARN_CPP_USERSDATABASE_H
