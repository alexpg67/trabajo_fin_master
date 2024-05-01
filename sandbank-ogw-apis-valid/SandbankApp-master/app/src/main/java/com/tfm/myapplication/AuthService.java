package com.tfm.myapplication;


import com.tfm.myapplication.Model.AccessTokenResponse;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.POST;
public interface AuthService {
    @POST("realms/TFM/protocol/openid-connect/token")
    @FormUrlEncoded
    Call<AccessTokenResponse> getToken(
            @Field("client_id") String clientId,
            @Field("client_secret") String clientSecret,
            @Field("grant_type") String grantType
    );
}