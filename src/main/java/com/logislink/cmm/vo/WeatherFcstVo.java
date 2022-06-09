package com.logislink.cmm.vo;

import java.io.Serializable;

public class WeatherFcstVo implements Serializable {

    private WeatherFcstResponseVo response;

    public WeatherFcstResponseVo getResponse() {
        return response;
    }

    public void setResponse(WeatherFcstResponseVo response) {
        this.response = response;
    }
}
