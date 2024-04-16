package com.tfm.devicestatus.model;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public class ApiInputDTO {



    @NotNull
    @Valid
    private UeIdDTO ueId;


    private int uePort;

    public ApiInputDTO() {

    }

    public ApiInputDTO(UeIdDTO ueId, int uePort) {
        this.ueId = ueId;
        this.uePort = uePort;
    }

    public UeIdDTO getUeId() {
        return ueId;
    }

    public void setUeId(UeIdDTO ueId) {
        this.ueId = ueId;
    }

    public int getUePort() {
        return uePort;
    }

    public void setUePort(int uePort) {
        this.uePort = uePort;
    }
}
