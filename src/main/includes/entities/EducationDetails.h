//
// Created by Rajesh Kanakamedala on 3/8/21.
//

#ifndef LEARN_CPP_EDUCATIONDETAILS_H
#define LEARN_CPP_EDUCATIONDETAILS_H

#include "CollegeDetails.h"

struct EducationDetails {
    String degreeName;
    String specialization;
    CollegeDetails collegeDetails;
    time_t startDate;
    time_t endDate;
    std::vector<String> courses;
    String extraInformation;
};
#endif //LEARN_CPP_EDUCATIONDETAILS_H
