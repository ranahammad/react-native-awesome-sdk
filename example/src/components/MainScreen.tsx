import { useEffect, useState } from 'react';
import {
  Text,
  TouchableOpacity,
  View,
  NativeEventEmitter,
  NativeModules,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { initialize, present } from 'react-native-awesome-sdk';
import { styles } from './styles';

console.log('NativeModules:', NativeModules);

const { AwesomeSdkModule } = NativeModules;
const sdkEventEmitter = new NativeEventEmitter(AwesomeSdkModule);

export default function MainScreen() {
  const [status, setStatus] = useState<string>('Ready');
  const [events, setEvents] = useState<string[]>([]);

  useEffect(() => {
    const readyListener = sdkEventEmitter.addListener('onReady', (data) => {
      setEvents((prev) => [...prev, `Ready: ${JSON.stringify(data)}`]);
    });

    const errorListener = sdkEventEmitter.addListener('onError', (error) => {
      setEvents((prev) => [...prev, `Error: ${JSON.stringify(error)}`]);
    });

    return () => {
      readyListener.remove();
      errorListener.remove();
    };
  }, []);

  const handleInitialize = async () => {
    try {
      const result = await initialize('TEST_API_KEY');
      setStatus(result);
    } catch (err: any) {
      setStatus(`Init failed: ${err.message}`);
    }
  };

  const handlePresent = async () => {
    try {
      const result = await present();
      setStatus(result);
    } catch (err: any) {
      setStatus(`Present failed: ${err.message}`);
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>React Native Awesome SDK Example</Text>

      <TouchableOpacity style={styles.button} onPress={handleInitialize}>
        <Text style={styles.buttonText}>Initialize SDK</Text>
      </TouchableOpacity>

      <TouchableOpacity style={styles.button} onPress={handlePresent}>
        <Text style={styles.buttonText}>Present SDK</Text>
      </TouchableOpacity>

      <View>
        <Text style={styles.status}>Status: {status}</Text>
        {events.map((event, idx) => (
          <Text key={idx} style={styles.eventText}>
            {event}
          </Text>
        ))}
      </View>
    </SafeAreaView>
  );
}
