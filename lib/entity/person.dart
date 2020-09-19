/// id : 2
/// name : "周迅"
/// avatarUrl : "https://img9.doubanio.com/view/celebrity/s_ratio_celebrity/public/p53446.webp"
/// introduction : "　周迅，中国著名女演员、歌手。毕业于浙江艺术学校社会文化舞蹈专科，因挂历上的照片被导演谢铁骊发掘，1991年初登大银幕演出《古墓荒斋》。1998年主演中国第六代导演娄烨成名作《苏州河》，获得2000年巴黎国际电影节影后，为从影以来首个电影奖项。1998年至2000年出演《大明宫词》、《人间四月天》、《像雾像雨又像风》等热门电视剧，获得影视界和观众广泛肯定。2000年左右与章子怡、赵薇及徐静蕾一同被媒体称为四小花旦。<br>　　2006年，周迅凭电影《如果爱》获得香港电影金像奖及台湾电影金马奖等多个女主角奖。2009年凭电影《李米的猜想》获得大陆电影金鸡奖最佳女主角奖。至此，周迅成为华语电影界唯一包揽两岸三地最高电影奖项，即金马、金像、金鸡、百花、亚洲影后的演员。<br>　　周迅多次与香港导演合作，并在2001年香港导演陈果的电影《香港有个荷里活》中首次全程以粤语对白演出。其表演极富魅力及感染力，凭精湛演技得到众多导演赏识及华人观众欢迎，也是华人电影界举足轻重女演员。2009年，周迅凭香港优秀人才入境计划，获得香港居民身分。<br>　　2008年4月21日，周迅获联合国开发计划署（UNDP）邀请出任首位中国亲善大使，致力于推动环境的可持续发展，同时启动“OUR PART我们的贡献”环境意识推广项目。周迅多次在各种场合提倡并率先实行“礼服REUSE、公开场合衣着重复穿、随身携带水杯、减少开车、购树抵销碳排放、节水、节电”等环保生活方式。2010年4月22日世界地球日，联合国授予周迅“地球卫士”奖，表彰她在积极参与宣传环保、倡导绿色生活方式上的贡献。周迅是全球演艺圈获此殊荣的第一人，也是历届获奖者中的第二位中国人。周迅在颁奖典礼上表示她希望年轻人努力从日常生活做起，将环保生活方式感染和带动周边的人，相信一定能促进世界改变。同时还将联合国颁发的奖金捐赠给此前发生地震的青海玉树灾区，帮助灾区人民重建绿色家园。"
/// videoList : [{"id":1,"name":"风声","ratingNum":8.2,"coverUrl":"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p1599059779.webp","watchNum":420220,"favoriteNum":3024},{"id":2,"name":"风声2","ratingNum":8.2,"coverUrl":"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p1599059779.webp","watchNum":420220,"favoriteNum":3024},{"id":3,"name":"风声3","ratingNum":8.2,"coverUrl":"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p1599059779.webp","watchNum":420220,"favoriteNum":3024}]

class Person {
  int _id;
  String _name;
  String _avatarUrl;
  String _introduction;
  List<VideoList> _videoList;

  int get id => _id;
  String get name => _name;
  String get avatarUrl => _avatarUrl;
  String get introduction => _introduction;
  List<VideoList> get videoList => _videoList;

  Person({
      int id, 
      String name, 
      String avatarUrl, 
      String introduction, 
      List<VideoList> videoList}){
    _id = id;
    _name = name;
    _avatarUrl = avatarUrl;
    _introduction = introduction;
    _videoList = videoList;
}

  Person.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _avatarUrl = json["avatarUrl"];
    _introduction = json["introduction"];
    if (json["videoList"] != null) {
      _videoList = [];
      json["videoList"].forEach((v) {
        _videoList.add(VideoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["avatarUrl"] = _avatarUrl;
    map["introduction"] = _introduction;
    if (_videoList != null) {
      map["videoList"] = _videoList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "风声"
/// ratingNum : 8.2
/// coverUrl : "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p1599059779.webp"
/// watchNum : 420220
/// favoriteNum : 3024

class VideoList {
  int _id;
  String _name;
  double _ratingNum;
  String _coverUrl;
  int _watchNum;
  int _favoriteNum;

  int get id => _id;
  String get name => _name;
  double get ratingNum => _ratingNum;
  String get coverUrl => _coverUrl;
  int get watchNum => _watchNum;
  int get favoriteNum => _favoriteNum;

  VideoList({
      int id, 
      String name, 
      double ratingNum, 
      String coverUrl, 
      int watchNum, 
      int favoriteNum}){
    _id = id;
    _name = name;
    _ratingNum = ratingNum;
    _coverUrl = coverUrl;
    _watchNum = watchNum;
    _favoriteNum = favoriteNum;
}

  VideoList.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _ratingNum = json["ratingNum"];
    _coverUrl = json["coverUrl"];
    _watchNum = json["watchNum"];
    _favoriteNum = json["favoriteNum"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["ratingNum"] = _ratingNum;
    map["coverUrl"] = _coverUrl;
    map["watchNum"] = _watchNum;
    map["favoriteNum"] = _favoriteNum;
    return map;
  }

}