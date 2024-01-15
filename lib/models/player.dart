class Player {
  /*
   late String username;
   late int score;
   late String time;
   late bool hasHighscore;
    */
   String? username;
   int? scoreCapitals;
   int? scoreFlags;
   String? timeCapitals;
   String? timeFlags;
   bool? hasHighscoreCapitals;
   bool? hasHighscoreFlags;

  Player({
    this.username,
    this.scoreCapitals,
    this.scoreFlags,
    this.timeCapitals,
    this.timeFlags,
    this.hasHighscoreCapitals,
    this.hasHighscoreFlags
  });

  void setUsername(String username) {
    this.username = username;
  }

  void setScoreCapitals(int score) {
    this.scoreCapitals = score;
  }

  void setTimeCapitals(String time) {
    this.timeCapitals = time;
  }

  Player copyWith({
    String? username,
    int? scoreCapitals,
    int? scoreFlags,
    String? time,
    bool? hasHighscore
  }) {
    return Player(
      username: username ?? this.username,
      scoreCapitals: scoreCapitals ?? this.scoreCapitals,
      scoreFlags: scoreFlags ?? this.scoreFlags,
      timeCapitals: timeCapitals ?? this.timeCapitals,
      hasHighscoreCapitals: hasHighscore ?? this.hasHighscoreCapitals
    );
  }
}