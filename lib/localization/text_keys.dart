enum LocalizedText {
  songSearchClipboardNoUrlFound("Your clipboard is empty!"),
  songSearchHintKey("Add a song or artist URL"),
  songShareText("Check this song out:\n$valuePlaceholder\n\nProvided by ♪ SynncroSong ♪"),
  songSharedUrlInvalidError("The shared URL is invalid.");
  
  const LocalizedText(this.englishText);
  
  final String englishText;
  
  static const valuePlaceholder = "{}";
}
