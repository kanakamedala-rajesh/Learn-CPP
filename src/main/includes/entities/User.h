//
// Created by Rajesh Kanakamedala on 3/8/21.
//

#ifndef LEARN_CPP_USER_H
#define LEARN_CPP_USER_H

#include <utility>

#include "About.h"
#include "EducationDetails.h"
#include "WorkExperience.h"

struct User {

    String userID;
    String userName;
    bool isVerified{};

    About about;
    EducationDetails educationDetails;
    WorkExperience workExperience;

    User() = default;

    explicit User(String userId,
                  String userName = "",
                  bool isVerified = false,
                  About about = About(),
                  EducationDetails educationDetails = EducationDetails(),
                  WorkExperience workExperience = WorkExperience())
            : userID(std::move(userId)), userName(std::move(userName)), isVerified(isVerified), about(std::move(about)), educationDetails(std::move(educationDetails)), workExperience(std::move(workExperience)) {

    }
};

#endif //LEARN_CPP_USER_H
