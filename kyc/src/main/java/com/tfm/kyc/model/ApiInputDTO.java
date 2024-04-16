package com.tfm.kyc.model;

public class ApiInputDTO {



    private String phoneNumber; //Tengo info
    private String idDocument; //Tengo info
    private String name; //Tengo info
    private String givenName; //Tengo info
    private String familyName; //Tengo info
    private String nameKanaHankaku; //No Tengo info
    private String nameKanaZenkaku; //No Tengo info
    private String middleNames; // Tengo info
    private String familyNameAtBirth; //No Tengo info
    private String address; // No Tengo info
    private String streetName; //  Tengo info
    private String streetNumber; //  Tengo info
    private String postalCode; //  Tengo info
    private String region; //  Tengo info
    private String locality; //  Tengo info
    private String country; //  Tengo info
    private String houseNumberExtension; //  Tengo info
    private String birthdate; //  Tengo info
    private String email; //  Tengo info
    private String gender; //  Tengo info


    public ApiInputDTO() {
    }

    public ApiInputDTO(String phoneNumber, String idDocument, String name, String givenName, String familyName, String nameKanaHankaku, String nameKanaZenkaku, String middleNames, String familyNameAtBirth, String address, String streetName, String streetNumber, String postalCode, String region, String locality, String country, String houseNumberExtension, String birthdate, String email, String gender) {
        this.phoneNumber = phoneNumber;
        this.idDocument = idDocument;
        this.name = name;
        this.givenName = givenName;
        this.familyName = familyName;
        this.nameKanaHankaku = nameKanaHankaku;
        this.nameKanaZenkaku = nameKanaZenkaku;
        this.middleNames = middleNames;
        this.familyNameAtBirth = familyNameAtBirth;
        this.address = address;
        this.streetName = streetName;
        this.streetNumber = streetNumber;
        this.postalCode = postalCode;
        this.region = region;
        this.locality = locality;
        this.country = country;
        this.houseNumberExtension = houseNumberExtension;
        this.birthdate = birthdate;
        this.email = email;
        this.gender = gender;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getIdDocument() {
        return idDocument;
    }

    public void setIdDocument(String idDocument) {
        this.idDocument = idDocument;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getNameKanaHankaku() {
        return nameKanaHankaku;
    }

    public void setNameKanaHankaku(String nameKanaHankaku) {
        this.nameKanaHankaku = nameKanaHankaku;
    }

    public String getNameKanaZenkaku() {
        return nameKanaZenkaku;
    }

    public void setNameKanaZenkaku(String nameKanaZenkaku) {
        this.nameKanaZenkaku = nameKanaZenkaku;
    }

    public String getMiddleNames() {
        return middleNames;
    }

    public void setMiddleNames(String middleNames) {
        this.middleNames = middleNames;
    }

    public String getFamilyNameAtBirth() {
        return familyNameAtBirth;
    }

    public void setFamilyNameAtBirth(String familyNameAtBirth) {
        this.familyNameAtBirth = familyNameAtBirth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStreetName() {
        return streetName;
    }

    public void setStreetName(String streetName) {
        this.streetName = streetName;
    }

    public String getStreetNumber() {
        return streetNumber;
    }

    public void setStreetNumber(String streetNumber) {
        this.streetNumber = streetNumber;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getLocality() {
        return locality;
    }

    public void setLocality(String locality) {
        this.locality = locality;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getHouseNumberExtension() {
        return houseNumberExtension;
    }

    public void setHouseNumberExtension(String houseNumberExtension) {
        this.houseNumberExtension = houseNumberExtension;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(String birthdate) {
        this.birthdate = birthdate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
}
