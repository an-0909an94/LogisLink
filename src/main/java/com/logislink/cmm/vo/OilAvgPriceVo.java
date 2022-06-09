package com.logislink.cmm.vo;


import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

public class OilAvgPriceVo {

    @JsonProperty("RESULT")
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Result result;

    public Result getResult() {
        return result;
    }

    public void setResult(Result result) {
        this.result = result;
    }

    public static class Result {
        @JsonProperty("OIL")
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private List<Oil> oils;

        public List<Oil> getOils() {
            return oils;
        }

        public void setOils(List<Oil> oils) {
            this.oils = oils;
        }
    }

    public static class Oil {
        /**
         * 시도
         */
        @JsonProperty("SIDOCD")
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String sidoCd;
        @JsonProperty("SIDONM")
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String sidoNm;

        /**
         * 시군구
         */
        @JsonProperty("SIGUNCD")
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String sigunCd;
        @JsonProperty("SIGUNNM")
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String sigunNm;

        /**
         * 유가정보
         */
        @JsonProperty("PRODCD")
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String prodCd;                  // 제품구분
        @JsonProperty("PRICE")
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String price;                   // 평균가격
        @JsonProperty("DIFF")
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String diff;                    // 전일대비 등락값

        public String getSidoCd() {
            return sidoCd;
        }

        public void setSidoCd(String sidoCd) {
            this.sidoCd = sidoCd;
        }

        public String getSidoNm() {
            return sidoNm;
        }

        public void setSidoNm(String sidoNm) {
            this.sidoNm = sidoNm;
        }

        public String getSigunCd() {
            return sigunCd;
        }

        public void setSigunCd(String sigunCd) {
            this.sigunCd = sigunCd;
        }

        public String getSigunNm() {
            return sigunNm;
        }

        public void setSigunNm(String sigunNm) {
            this.sigunNm = sigunNm;
        }

        public String getProdCd() {
            return prodCd;
        }

        public void setProdCd(String prodCd) {
            this.prodCd = prodCd;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public String getDiff() {
            return diff;
        }

        public void setDiff(String diff) {
            this.diff = diff;
        }
    }
}
