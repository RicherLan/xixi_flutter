
class HttpRoutePath{

  // 用户路由
   static final String API_LOGIN = "/user/login"; // 登录
   static final String API_UPDATE_PASS = "/user/update_pass"; // 修改密码


  // 技术管理路由
   static final String API_ADD_JISHU = "/jishu/add"; // 添加技术信息
   static final String API_SUPPLY_JISHU = "/jishu/supply"; // 补充技术信息
   static final String API_VOTE_JISHU = "/jishu/vote"; // 某客服给技术投票和贴标签

   static final String API_GET_JISHU_QQ = "/jishu/get/byqq"; // 根据技术的qq获得技术信息
   static final String API_GET_JISHU_WX = "/jishu/get/bywx"; // 根据技术的wx获得技术信息
   static final String API_GET_JISHU_SKILL = "/jishu/get/skill"; // 某客服给技术投票和贴标签

   static final String API_GET_JISHU_ONLY_YES = "/jishu/get/onlyyes"; // 获得只有好评的技术
   static final String API_GET_JISHU_ONLY_NO = "/jishu/get/onlyno"; // 获得只有差评的技术
   static final String API_GET_JISHU_YES = "/jishu/get/yes"; // 获得好评票数多于差评票数的技术
   static final String API_GET_JISHU_NO = "/jishu/get/no"; // 获得差评票数多于好评票数的技术


   static final String API_GET_JISHU_VoteDetail_QQ = "/jishu/get/votedetail";  //各个客服对某技术评价的详细信息


}