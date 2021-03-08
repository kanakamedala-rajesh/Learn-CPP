//
// Created by Rajesh Kanakamedala on 3/8/21.
//

#ifndef LEARN_CPP_DATABASESERVICE_H
#define LEARN_CPP_DATABASESERVICE_H

#include "vector"
#include "string"

#include "LoggerSetup.h"

using String = std::string;

template<typename T>
class DatabaseService {
protected:
    LoggerSetup *loggerSetup;

public:
    virtual std::vector<T> getItems() = 0;

    virtual T getItem(String userID) = 0;

    virtual bool addItem(T item) = 0;

    virtual bool deleteItem(String userId) = 0;

    virtual T updateItem(T item) = 0;

    explicit DatabaseService(LoggerSetup *loggerSetup) : loggerSetup(loggerSetup) {
        loggerSetup->getLogger()->template info("DatabaseService Constructor");
    }
};


#endif //LEARN_CPP_DATABASESERVICE_H
