package com.tfm.myapplication.Model;

import com.google.gson.annotations.SerializedName;

public class AccessTokenResponse {

    @SerializedName("access_token")
    private String accessToken;

    @SerializedName("expires_in")
    private int expiresIn;

    @SerializedName("refresh_expires_in")
    private int refreshExpiresIn;

    @SerializedName("token_type")
    private String tokenType;

    @SerializedName("not-before-policy")
    private int notBeforePolicy;

    @SerializedName("scope")
    private String scope;

    public AccessTokenResponse(String accessToken, int expiresIn, int refreshExpiresIn, String tokenType, int notBeforePolicy, String scope) {
        this.accessToken = accessToken;
        this.expiresIn = expiresIn;
        this.refreshExpiresIn = refreshExpiresIn;
        this.tokenType = tokenType;
        this.notBeforePolicy = notBeforePolicy;
        this.scope = scope;
    }

    public AccessTokenResponse() {
    }

    // Getters y setters
    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public int getExpiresIn() {
        return expiresIn;
    }

    public void setExpiresIn(int expiresIn) {
        this.expiresIn = expiresIn;
    }

    public int getRefreshExpiresIn() {
        return refreshExpiresIn;
    }

    public void setRefreshExpiresIn(int refreshExpiresIn) {
        this.refreshExpiresIn = refreshExpiresIn;
    }

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public int getNotBeforePolicy() {
        return notBeforePolicy;
    }

    public void setNotBeforePolicy(int notBeforePolicy) {
        this.notBeforePolicy = notBeforePolicy;
    }

    public String getScope() {
        return scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }
}
