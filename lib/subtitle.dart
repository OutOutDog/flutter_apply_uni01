import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class WordFlow {
  final String videoUrl;
  final String subtitleUrl;
  final List<Word> words;

  WordFlow({required this.videoUrl, required this.subtitleUrl, required this.words});

  factory WordFlow.fromJson(Map<String, dynamic> json) {
    var list = json['words'] as List;
    List<Word> wordsList = list.map((i) => Word.fromJson(i)).toList();
    return WordFlow(
      videoUrl: json['videoUrl'],
      subtitleUrl: json['subtitleUrl'],
      words: wordsList,
    );
  }
}

class Word {
  final String word;
  final int startTime;
  final int endTime;

  Word({required this.word, required this.startTime, required this.endTime});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}

Future<String> _loadWordFlowAsset() async {
  return await rootBundle.loadString('assets/wordflows.json');
}

Future<WordFlow> loadWordFlow() async {
  String jsonString = await _loadWordFlowAsset();
  final jsonResponse = json.decode(jsonString);
  return WordFlow.fromJson(jsonResponse);
}
