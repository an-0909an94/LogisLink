package com.logislink.cmm.vo;

import java.io.Serializable;
import java.util.List;

public class WeatherFcstResponseVo implements Serializable {

    private Header header;
    private Body body;

    public Header getHeader() {
        return header;
    }

    public void setHeader(Header header) {
        this.header = header;
    }

    public Body getBody() {
        return body;
    }

    public void setBody(Body body) {
        this.body = body;
    }
    

    @Override
	public String toString() {
		return "WeatherFcstResponseVo [header=" + header + ", body=" + body + "]";
	}


	public static class Header {
        private String resultCode;
        private String resultMsg;

        public String getResultCode() {
            return resultCode;
        }

        public void setResultCode(String resultCode) {
            this.resultCode = resultCode;
        }

        public String getResultMsg() {
            return resultMsg;
        }

        public void setResultMsg(String resultMsg) {
            this.resultMsg = resultMsg;
        }
    }

    public static class Body implements Serializable {
        private String dataType;
        private Item items;
        private String pageNo;
        private String numOfRows;
        private String totalCount;

        public String getDataType() {
            return dataType;
        }

        public void setDataType(String dataType) {
            this.dataType = dataType;
        }

        public Item getItems() {
            return items;
        }

        public void setItems(Item items) {
            this.items = items;
        }

        public String getPageNo() {
            return pageNo;
        }

        public void setPageNo(String pageNo) {
            this.pageNo = pageNo;
        }

        public String getNumOfRows() {
            return numOfRows;
        }

        public void setNumOfRows(String numOfRows) {
            this.numOfRows = numOfRows;
        }

        public String getTotalCount() {
            return totalCount;
        }

        public void setTotalCount(String totalCount) {
            this.totalCount = totalCount;
        }

        public static class Item {
            private List<WeatherFcstItemVo> item;

            public List<WeatherFcstItemVo> getItem() {
                return item;
            }

            public void setItem(List<WeatherFcstItemVo> item) {
                this.item = item;
            }
        }

		@Override
		public String toString() {
			return "Body [dataType=" + dataType + ", items=" + items + ", pageNo=" + pageNo + ", numOfRows=" + numOfRows
					+ ", totalCount=" + totalCount + "]";
		}
        
        
    }
}
