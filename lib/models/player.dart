class Player {
  /*
   late String username;
   late int score;
   late String time;
   late bool hasHighscore;
    */
   String? username;
   int? score;
   String? time;
   bool? hasHighscore;

  Player({this.username, this.score, this.time, this.hasHighscore});
  //Player({ required this.username,  required this.score,  required this.time,  required this.hasHighscore});

  void setUsername(String username) {
    this.username = username;
  }

  void setScore(int score) {
    this.score = score;
  }

  void setTime(String time) {
    this.time = time;
  }

  Player copyWith({
    String? username,
    int? score,
    String? time,
    bool? hasHighscore
  }) {
    return Player(
      username: username ?? this.username,
      score: score ?? this.score,
      time: time ?? this.time,
      hasHighscore: hasHighscore ?? this.hasHighscore
    );
  }
}