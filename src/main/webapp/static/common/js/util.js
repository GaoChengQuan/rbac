var util = {
	SUCCESS : 0,
	ERROR : 1,
	NEED_LOGIN : 2,
	isNull : function(value) {
		//把value首尾的空格去掉
		var str = value.replace(/(^\s*)|(\s*$)/, '');
		//输入框中输入空格也为空
		if (str == '' || str == undefined || str == null) {
			return true;
		} else {
			return false;
		}
	},
	getSelectedIds : function(data) {
		var ids = [];//[1,2,3]
    	for(var i in data) {
    		ids.push(data[i].id);
    	}
    	return ids;
	},
	// 0-9 的日期和时间，在前面补0：9 -> 09
	formatZero: function(n){
	     if(n>=0&&n<=9){
	         return "0"+n;
	     }else{
	         return n;
	     }
	 },
	// 格式化时间
	getCurrentDateTime : function() {
	    var date = new Date();//Mon Oct 30 2017 22:08:37 GMT+0800
	    var year=date.getFullYear();
	    var month=date.getMonth()+1;
	    var day=date.getDate();
	    var hours=date.getHours();
	    var minutes=date.getMinutes();
	    var seconds=date.getSeconds();
	    // 2017-01-01 02:23:06   yyyy-MM-dd hh:mm:ss
	    return year+"-"+this.formatZero(month)+"-"+this.formatZero(day)+" "+this.formatZero(hours)+":"+this.formatZero(minutes)+":"+this.formatZero(seconds);
	},
}
