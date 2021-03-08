//
// Created by Rajesh Kanakamedala on 3/8/21.
//

#ifndef LEARN_CPP_LOCATION_H
#define LEARN_CPP_LOCATION_H

#include "string"

using String = std::string;

struct Location {
    String city;
    String fullAddress;
    String state;
    int zipcode;
    float latitude;
    float longitude;
};

#endif //LEARN_CPP_LOCATION_H
