enum LocalizedText {
  songSearchClipboardNoUrlFound("Your clipboard is empty!"),
  songSearchHintKey("Share a song url :)"),
  songShareText("$valuePlaceholder by ♪ SyncroSong ♪"),
  songSharedUrlInvalidError("The shared URL is invalid."),
  settingsSupport("Support us"),
  settingsSubscribe("Learn More"),
  settingsRate("Rate ♪ SyncroSong ♪"),
  historyScreenTitle("History"),
  settingsScreenTitle("Settings"),
  ;
  
  const LocalizedText(this.englishText);
  
  final String englishText;
  
  static const valuePlaceholder = "{}";
}
