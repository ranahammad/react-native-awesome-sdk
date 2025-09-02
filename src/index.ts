import { NativeModules, NativeEventEmitter } from 'react-native';

const { AwesomeSdkModule } = NativeModules;

if (!AwesomeSdkModule) {
  throw new Error(
    'AwesomeSdkModule is not linked properly. Did you run pod install?'
  );
}

export const sdkEventEmitter = new NativeEventEmitter(AwesomeSdkModule);

export function initialize(apiKey: string): Promise<string> {
  return AwesomeSdkModule.initialize(apiKey);
}

export function present(): Promise<string> {
  return AwesomeSdkModule.present();
}
