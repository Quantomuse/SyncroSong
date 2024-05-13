enum LocalizedText {
  songSearchClipboardNoUrlFound("Your clipboard is empty!"),
  songSearchHintKey("Add a song or artist URL"),
  songShareText("$valuePlaceholder by ♪ SyncroSong ♪"),
  songSharedUrlInvalidError("The shared URL is invalid."),
  settingsSupport("Support us"),
  settingsSubscribe("Hear more from us"),
  settingsRate("Rate ♪ SyncroSong ♪"),
  historyScreenTitle("History"),
  settingsScreenTitle("Settings"),
  ;
  
  const LocalizedText(this.englishText);
  
  final String englishText;
  
  static const valuePlaceholder = "{}";
}
