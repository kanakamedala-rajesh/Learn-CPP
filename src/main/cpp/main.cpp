#include "string"
#include "LoggerSetup.h"
#include "ProjectConfigurations.hpp"

#include "DatabaseService.h"
#include "UsersDatabase.h"

int main() {
    String appName = PROJECT_NAME; // if modified make sure to change configuration/log_conf.toml file with new name
    std::unique_ptr<LoggerSetup> logger = std::make_unique<LoggerSetup>(appName);

    if (logger->isLoggerConfigured()) {
        logger->getLogger()->info("Welcome to {}, Version: {}", PROJECT_NAME, PROJECT_VERSION);
        logger->getLogger()->info("C++ standard: {}", __cplusplus);
    }

    std::unique_ptr<DatabaseService<User>> userDatabase = std::make_unique<UsersDatabase>(logger.get());

    userDatabase->getItems();
    userDatabase->addItem(User("ID_7567876"));
    userDatabase->getItem("ID_7567876");
    userDatabase->deleteItem("ID_7567876");

    return 0;
}
