//
// Created by Rajesh Kanakamedala on 3/8/21.
//

#ifndef LEARN_CPP_WORKEXPERIENCE_H
#define LEARN_CPP_WORKEXPERIENCE_H

#include "EmployerInformation.h"

struct WorkExperience {
    EmployerInformation employerInformation;
    String jobTitle;
    bool isCurrentJob;
    time_t startDate;
    time_t endDate;
    std::vector<String> jobResponsibilities;
    std::vector<String> technologiesUsed;
    std::vector<String> toolsUsed;
};

#endif //LEARN_CPP_WORKEXPERIENCE_H
