import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<ArticleData> getArticle({
  required int articleId,
}) async {
  final dio = Dio(BaseOptions(
    baseUrl: '${dotenv.get('BASE_URL')}/api/articles',
  ));

  final storage = FlutterSecureStorage();
  final userId = await storage.read(key: 'userId');

  final response = await dio.get('/$articleId', queryParameters: {
    'userId': userId,
  });

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.toString());
    final articleData = ArticleData.fromJson(jsonData);
    print('게시글 요청 성공');
    return articleData;
  } else {
    print('실패');
    throw Exception('Failed to load articles');
  }
}

class ArticleData {
  final int articleId;
  final int userId;
  final String nickname;
  final String profile;
  final String content;
  final String image;
  final int dailyLikeCount;
  final int totalLikeCount;
  final int commentCount;
  final bool likeYn;
  final bool followYn;
  final String createdAt;
  String? dosi;
  String? sigungu;
  String? dongeupmyeon;

  ArticleData(
      {required this.articleId,
      required this.userId,
      required this.nickname,
      required this.content,
      required this.dailyLikeCount,
      required this.totalLikeCount,
      required this.commentCount,
      required this.likeYn,
      required this.followYn,
      required this.createdAt,
      required this.profile,
      required this.image,
      this.dosi,
      this.sigungu,
      this.dongeupmyeon});

  factory ArticleData.fromJson(Map<String, dynamic> json) {
    return ArticleData(
      articleId: json['articleId'],
      userId: json['userId'],
      nickname: json['nickname'],
      profile: json['profile'],
      content: json['content'],
      image: json['image'],
      dailyLikeCount: json['dailyLikeCount'],
      totalLikeCount: json['totalLikeCount'],
      commentCount: json['commentCount'],
      likeYn: json['likeYn'],
      followYn: json['followYn'],
      createdAt: json['createdAt'],
      dosi: json['dosi'],
      sigungu: json['sigungu'],
      dongeupmyeon: json['dongeupmyeon'],
    );
  }
}
