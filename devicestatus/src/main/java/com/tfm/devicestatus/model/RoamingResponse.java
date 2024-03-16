package com.tfm.devicestatus.model;

import java.util.List;

public class RoamingResponse {

    private boolean roaming;
    private int countryCode;
    private List<String> countryName;

    public RoamingResponse(boolean roaming, int countryCode, List<String> countryName) {
        this.roaming = roaming;
        this.countryCode = countryCode;
        this.countryName = countryName;


    }

    public boolean isRoaming() {
        return roaming;
    }

    public void setRoaming(boolean roaming) {
        this.roaming = roaming;
    }

    public int getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(int countryCode) {
        this.countryCode = countryCode;
    }

    public List<String> getCountryName() {
        return countryName;
    }

    public void setCountryName(List<String> countryName) {
        this.countryName = countryName;
    }
}
