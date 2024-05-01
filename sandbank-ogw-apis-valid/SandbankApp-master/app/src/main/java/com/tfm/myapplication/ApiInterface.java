package com.tfm.myapplication;

import com.tfm.myapplication.Model.KycApiInputDto;
import com.tfm.myapplication.Model.KycApiResponseDto;
import com.tfm.myapplication.Model.SimSwapCheckDto;
import com.tfm.myapplication.Model.SimSwapCheckResponseDto;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.POST;

public interface ApiInterface {
//    @POST("kyc-match/v0/match")
//    Call<KycApiResponseDto> verifyUser(@Body KycApiInputDto userVerification);

    @POST("kyc-match/v0/match")
    Call<KycApiResponseDto> verifyUser(@Header("Authorization") String authToken, @Body KycApiInputDto userVerification);

    @POST("sim-swap/v0/check")
    Call<SimSwapCheckResponseDto> checkSimSwap(@Header("Authorization") String authToken, @Body SimSwapCheckDto simUserInformation);


}