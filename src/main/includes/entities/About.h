//
// Created by Rajesh Kanakamedala on 3/8/21.
//

#ifndef LEARN_CPP_ABOUT_H
#define LEARN_CPP_ABOUT_H

#include "Location.h"
#include "SocialNetworks.h"
#include "map"

struct About {
    int contactNumber;
    int contactNumberSecondary;
    String email;
    String emailSecondary;
    String fullName;
    Location location;
    String objective;
    String resumeURL;
    std::map<SocialNetworks, String> socialNetworkURLs;
    int experienceMonths;
    String introduction;
    std::vector<String> workTechnologies;
};
#endif //LEARN_CPP_ABOUT_H
