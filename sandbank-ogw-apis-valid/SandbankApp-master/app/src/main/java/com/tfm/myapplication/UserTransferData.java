package com.tfm.myapplication;

public class UserTransferData {
    private String destinationIBAN;
    private String recipientPhoneNumber;
    private String purposeOfTransfer;
    private String amountToTransfer;
    private String date;

    public UserTransferData(String date,String destinationIBAN, String recipientPhoneNumber, String purposeOfTransfer, String amountToTransfer) {
        this.destinationIBAN = destinationIBAN;
        this.recipientPhoneNumber = recipientPhoneNumber;
        this.purposeOfTransfer = purposeOfTransfer;
        this.amountToTransfer = amountToTransfer;
        this.date = date;
    }

    public String getDestinationIBAN() {
        return destinationIBAN;
    }

    public void setDestinationIBAN(String destinationIBAN) {
        this.destinationIBAN = destinationIBAN;
    }

    public String getRecipientPhoneNumber() {
        return recipientPhoneNumber;
    }

    public void setRecipientPhoneNumber(String recipientPhoneNumber) {
        this.recipientPhoneNumber = recipientPhoneNumber;
    }

    public String getPurposeOfTransfer() {
        return purposeOfTransfer;
    }

    public void setPurposeOfTransfer(String purposeOfTransfer) {
        this.purposeOfTransfer = purposeOfTransfer;
    }

    public String getAmountToTransfer() {
        return amountToTransfer;
    }

    public void setAmountToTransfer(String amountToTransfer) {
        this.amountToTransfer = amountToTransfer;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
