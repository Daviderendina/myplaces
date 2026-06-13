enum SettingsKeys {
  autoBackupEnabled(bool),
  autoBackupPath(String);

  final Type type;

  const SettingsKeys(this.type);
}
