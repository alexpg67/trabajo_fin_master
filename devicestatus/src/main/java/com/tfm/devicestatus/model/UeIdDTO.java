package com.tfm.devicestatus.model;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;

public class UeIdDTO {


    private String externalId;

    @Pattern(regexp = "^\\+?[0-9]{5,15}$")
    @NotEmpty
    private String msisdn;

//    @Pattern(regexp = "^([01]?\\d\\d?|2[0-4]\\d|25[0-5])(?:\\.(?:[01]?\\d\\d?|2[0-4]\\d|25[0-5])){3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
    private String ipv4Addr;

//    @Pattern(regexp = "^((([^:]+:){7}([^:]+))|((([^:]+:)*[^:]+)?::(([^:]+:)*[^:]+)?))(\\/.+)?$")
    private String ipv6Addr;


    public UeIdDTO(String externalId, String msisdn, String ipv4Addr, String ipv6Addr) {
        this.externalId = externalId;
        this.msisdn = msisdn;
        this.ipv4Addr = ipv4Addr;
        this.ipv6Addr = ipv6Addr;
    }

    public UeIdDTO(){

    }

    public UeIdDTO(String msisdn) {
        this.msisdn = msisdn;
    }

    public String getExternalId() {
        return externalId;
    }

    public void setExternalId(String externalId) {
        this.externalId = externalId;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public String getIpv4Addr() {
        return ipv4Addr;
    }

    public void setIpv4Addr(String ipv4Addr) {
        this.ipv4Addr = ipv4Addr;
    }

    public String getIpv6Addr() {
        return ipv6Addr;
    }

    public void setIpv6Addr(String ipv6Addr) {
        this.ipv6Addr = ipv6Addr;
    }
}
