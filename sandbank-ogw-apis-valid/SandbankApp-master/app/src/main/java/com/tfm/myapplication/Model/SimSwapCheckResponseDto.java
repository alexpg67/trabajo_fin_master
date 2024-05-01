package com.tfm.myapplication.Model;

public class SimSwapCheckResponseDto {

    private Boolean swapped;

    public SimSwapCheckResponseDto(Boolean swapped) {
        this.swapped = swapped;
    }

    public SimSwapCheckResponseDto() {

    }

    public Boolean getSwapped() {
        return swapped;
    }

    public void setSwapped(Boolean swapped) {
        this.swapped = swapped;
    }
}
