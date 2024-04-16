package com.tfm.kyc.model;

public class ResponseDTO {

//
//    {
//        "idDocumentMatch": "true",
//            "nameMatch": "true",
//            "giventNameMatch": "not_available",
//            "familyNameMatch": "not_available",
//            "nameKanaHankakuMatch": "true",
//            "nameKanaZenkakuMatch": "false",
//            "middleNamesMatch": "true",
//            "familyNameAtBirthMatch": "false",
//            "addressMatch": "true",
//            "streetNameMatch": "true",
//            "streetNumberMatch": "true",
//            "postalCodeMatch": "true",
//            "regionMatch": "true",
//            "localityMatch": "not_available",
//            "countryMatch": "true",
//            "houseNumberExtensionMatch": "not_available",
//            "birthdateMatch": "false",
//            "emailMatch": "false",
//            "genderMatch": "false"
//

    private String idDocumentMatch;
    private String nameMatch;
    private String givenNameMatch;
    private String familyNameMatch;
    private String nameKanaHankakuMatch;
    private String nameKanaZenkakuMatch;
    private String middleNamesMatch;
    private String familyNameAtBirthMatch;

    private String addressMatch;
    private String streetNameMatch;
    private String streetNumberMatch;
    private String postalCodeMatch;
    private String regionMatch;
    private String localityMatch;

    private String countryMatch;

    private String houseNumberExtensionMatch;
    private String birthdateMatch;
    private String emailMatch;
    private String genderMatch;


    public ResponseDTO() {

    }

    public ResponseDTO(String idDocumentMatch, String nameMatch, String givenNameMatch, String familyNameMatch, String nameKanaHankakuMatch, String nameKanaZenkakuMatch, String middleNamesMatch, String familyNameAtBirthMatch, String addressMatch, String streetNameMatch, String streetNumberMatch, String postalCodeMatch, String regionMatch, String localityMatch, String countryMatch, String houseNumberExtensionMatch, String birthdateMatch, String emailMatch, String genderMatch) {
        this.idDocumentMatch = idDocumentMatch;
        this.nameMatch = nameMatch;
        this.givenNameMatch = givenNameMatch;
        this.familyNameMatch = familyNameMatch;
        this.nameKanaHankakuMatch = nameKanaHankakuMatch;
        this.nameKanaZenkakuMatch = nameKanaZenkakuMatch;
        this.middleNamesMatch = middleNamesMatch;
        this.familyNameAtBirthMatch = familyNameAtBirthMatch;
        this.addressMatch = addressMatch;
        this.streetNameMatch = streetNameMatch;
        this.streetNumberMatch = streetNumberMatch;
        this.postalCodeMatch = postalCodeMatch;
        this.regionMatch = regionMatch;
        this.localityMatch = localityMatch;
        this.countryMatch = countryMatch;
        this.houseNumberExtensionMatch = houseNumberExtensionMatch;
        this.birthdateMatch = birthdateMatch;
        this.emailMatch = emailMatch;
        this.genderMatch = genderMatch;
    }

    public String getIdDocumentMatch() {
        return idDocumentMatch;
    }

    public void setIdDocumentMatch(String idDocumentMatch) {
        this.idDocumentMatch = idDocumentMatch;
    }

    public String getNameMatch() {
        return nameMatch;
    }

    public void setNameMatch(String nameMatch) {
        this.nameMatch = nameMatch;
    }

    public String getGivenNameMatch() {
        return givenNameMatch;
    }

    public void setGivenNameMatch(String givenNameMatch) {
        this.givenNameMatch = givenNameMatch;
    }

    public String getFamilyNameMatch() {
        return familyNameMatch;
    }

    public void setFamilyNameMatch(String familyNameMatch) {
        this.familyNameMatch = familyNameMatch;
    }

    public String getNameKanaHankakuMatch() {
        return nameKanaHankakuMatch;
    }

    public void setNameKanaHankakuMatch(String nameKanaHankakuMatch) {
        this.nameKanaHankakuMatch = nameKanaHankakuMatch;
    }

    public String getNameKanaZenkakuMatch() {
        return nameKanaZenkakuMatch;
    }

    public void setNameKanaZenkakuMatch(String nameKanaZenkakuMatch) {
        this.nameKanaZenkakuMatch = nameKanaZenkakuMatch;
    }

    public String getMiddleNamesMatch() {
        return middleNamesMatch;
    }

    public void setMiddleNamesMatch(String middleNamesMatch) {
        this.middleNamesMatch = middleNamesMatch;
    }

    public String getFamilyNameAtBirthMatch() {
        return familyNameAtBirthMatch;
    }

    public void setFamilyNameAtBirthMatch(String familyNameAtBirthMatch) {
        this.familyNameAtBirthMatch = familyNameAtBirthMatch;
    }

    public String getAddressMatch() {
        return addressMatch;
    }

    public void setAddressMatch(String addressMatch) {
        this.addressMatch = addressMatch;
    }

    public String getStreetNameMatch() {
        return streetNameMatch;
    }

    public void setStreetNameMatch(String streetNameMatch) {
        this.streetNameMatch = streetNameMatch;
    }

    public String getStreetNumberMatch() {
        return streetNumberMatch;
    }

    public void setStreetNumberMatch(String streetNumberMatch) {
        this.streetNumberMatch = streetNumberMatch;
    }

    public String getPostalCodeMatch() {
        return postalCodeMatch;
    }

    public void setPostalCodeMatch(String postalCodeMatch) {
        this.postalCodeMatch = postalCodeMatch;
    }

    public String getRegionMatch() {
        return regionMatch;
    }

    public void setRegionMatch(String regionMatch) {
        this.regionMatch = regionMatch;
    }

    public String getLocalityMatch() {
        return localityMatch;
    }

    public void setLocalityMatch(String localityMatch) {
        this.localityMatch = localityMatch;
    }

    public String getCountryMatch() {
        return countryMatch;
    }

    public void setCountryMatch(String countryMatch) {
        this.countryMatch = countryMatch;
    }

    public String getHouseNumberExtensionMatch() {
        return houseNumberExtensionMatch;
    }

    public void setHouseNumberExtensionMatch(String houseNumberExtensionMatch) {
        this.houseNumberExtensionMatch = houseNumberExtensionMatch;
    }

    public String getBirthdateMatch() {
        return birthdateMatch;
    }

    public void setBirthdateMatch(String birthdateMatch) {
        this.birthdateMatch = birthdateMatch;
    }

    public String getEmailMatch() {
        return emailMatch;
    }

    public void setEmailMatch(String emailMatch) {
        this.emailMatch = emailMatch;
    }

    public String getGenderMatch() {
        return genderMatch;
    }

    public void setGenderMatch(String genderMatch) {
        this.genderMatch = genderMatch;
    }
}
