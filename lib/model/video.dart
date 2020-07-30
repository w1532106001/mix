import 'package:mix/model/cast_member.dart';
import 'package:mix/model/tag.dart';
import 'package:mix/model/video_episode.dart';

class Video {
  int id;

  //名称
  String name;

  //介绍
  String introduction;

  //评分
  double ratingNum;

  //封面
  String coverUrl;

  //观看数
  int watchNum;

  //收藏数
  int favoriteNum;

  //标签
  List<Tag> tagList;

  //导演
  List<CastMember> directorList;

  //编剧
  List<CastMember> writerList;

  //演员
  List<CastMember> starList;

  //剧集
  List<VideoEpisode> episodeList;

  Video(
      {this.id,
      this.name,
      this.introduction,
      this.ratingNum,
      this.coverUrl,
      this.watchNum,
      this.favoriteNum,
      this.tagList,
      this.directorList,
      this.writerList,
      this.starList,
      this.episodeList});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    introduction = json['introduction'];
    ratingNum = json['ratingNum'];
    coverUrl = json['coverUrl'];
    watchNum = json['watchNum'];
    favoriteNum = json['favoriteNum'];
    if (json['tagList'] != null) {
      tagList = new List<Tag>();
      json['tagList'].forEach((v) {
        tagList.add(new Tag.fromJson(v));
      });
    }
    if (json['directorList'] != null) {
      directorList = new List<CastMember>();
      json['directorList'].forEach((v) {
        directorList.add(new CastMember.fromJson(v));
      });
    }
    if (json['writerList'] != null) {
      writerList = new List<CastMember>();
      json['writerList'].forEach((v) {
        writerList.add(new CastMember.fromJson(v));
      });
    }
    if (json['starList'] != null) {
      starList = new List<CastMember>();
      json['starList'].forEach((v) {
        starList.add(new CastMember.fromJson(v));
      });
    }
    if (json['episodeList'] != null) {
      episodeList = new List<VideoEpisode>();
      json['episodeList'].forEach((v) {
        episodeList.add(new VideoEpisode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['introduction'] = this.introduction;
    data['ratingNum'] = this.ratingNum;
    data['coverUrl'] = this.coverUrl;
    data['watchNum'] = this.watchNum;
    data['favoriteNum'] = this.favoriteNum;
    if (this.tagList != null) {
      data['tagList'] = this.tagList.map((v) => v.toJson()).toList();
    }
    if (this.directorList != null) {
      data['directorList'] = this.directorList.map((v) => v.toJson()).toList();
    }
    if (this.writerList != null) {
      data['writerList'] = this.writerList.map((v) => v.toJson()).toList();
    }
    if (this.starList != null) {
      data['starList'] = this.starList.map((v) => v.toJson()).toList();
    }
    if (this.episodeList != null) {
      data['episodeList'] = this.episodeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
