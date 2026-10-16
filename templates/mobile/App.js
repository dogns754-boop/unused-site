import { StatusBar } from 'expo-status-bar';
import { useState } from 'react';
import { Button, StyleSheet, Text, TextInput, View } from 'react-native';
import { greet } from './src/logic/greet.mjs';

// 화면만 담당한다. 계산·규칙은 src/logic 에 두고 테스트한다.
export default function App() {
  const [name, setName] = useState('');
  const [message, setMessage] = useState('');

  return (
    <View style={styles.container}>
      <Text style={styles.title}>__NAME__</Text>
      <Text style={styles.desc}>__DESC__</Text>
      <TextInput style={styles.input} placeholder="이름" value={name} onChangeText={setName} />
      <Button title="인사" onPress={() => setMessage(greet(name))} />
      <Text style={styles.output}>{message}</Text>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, padding: 24, justifyContent: 'center', backgroundColor: '#fff' },
  title: { fontSize: 24, fontWeight: '700' },
  desc: { color: '#5e6875', marginBottom: 16 },
  input: { borderWidth: 1, borderColor: '#dde3ea', borderRadius: 8, padding: 10, marginBottom: 8 },
  output: { marginTop: 16, fontSize: 16 },
});
