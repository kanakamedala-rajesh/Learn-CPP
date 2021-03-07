#include <iostream>
#include "LoggerSetup.h"
#include "ProjectConfigurations.hpp"

int main() {
    String appName = PROJECT_NAME; // if modified make sure to change configuration/log_conf.toml file with new name
    std::unique_ptr<LoggerSetup> logger = std::make_unique<LoggerSetup>(appName);

    if (logger->isLoggerConfigured()) {
        logger->getLogger()->info("Welcome to {}, Version: {}", PROJECT_NAME, PROJECT_VERSION);
    }
    return 0;
}
