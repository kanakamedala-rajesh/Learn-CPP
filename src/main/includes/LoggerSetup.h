//
// Created by Rajesh Kanakamedala on 3/7/21.
//

#ifndef LEARN_CPP_LOGGERSETUP_H
#define LEARN_CPP_LOGGERSETUP_H

#include "iostream"
#include "spdlog_setup/conf.h"
#include "ProjectConfigurations.hpp"

using String = std::string;

class LoggerSetup {
public:
    explicit LoggerSetup(const String &appName) {
        try {
            spdlog_setup::from_file(LOG_CONFIG_FILE);
            this->logger = spdlog::get(appName);
            this->loggerConfigured = true;
            logger->info("Successfully loaded logger for {}", appName);
        } catch (const spdlog_setup::setup_error &error) {
            std::cout << "=====================================================" << std::endl;
            std::cout << "Error setting up logger, cause: " << error.what() << std::endl;
            std::cout << "=====================================================" << std::endl;
        } catch (const std::exception &exception) {
            std::cout << "=====================================================" << std::endl;
            std::cout << "Exception setting up logger." << exception.what() << std::endl;
            std::cout << "=====================================================" << std::endl;
        }
    }

    bool isLoggerConfigured() const {
        return loggerConfigured;
    }

    const std::shared_ptr<spdlog::logger> &getLogger() const {
        return logger;
    }

private:
    bool loggerConfigured = false;
    std::shared_ptr<spdlog::logger> logger;
};

#endif //LEARN_CPP_LOGGERSETUP_H
