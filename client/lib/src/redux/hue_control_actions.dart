class SetBrightnessAction {
  double brightness;

  bool shouldSyncWithServer;

  SetBrightnessAction(this.brightness, {this.shouldSyncWithServer = true});
}

class SetStateAction {
  bool isOn;

  bool shouldSyncWithServer;
  
  SetStateAction(this.isOn, {this.shouldSyncWithServer = true});
}