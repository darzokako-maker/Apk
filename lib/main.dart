import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';
import 'dart:io';

void main() => runApp(const SecretApp());

class SecretApp extends StatelessWidget {
  const SecretApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  // Gerekli izinleri ve Root durumunu sorgula
  void _requestPermissions() async {
    await SystemAlertWindow.requestPermissions;
    // Basit bir root kontrolü
    try {
      Process.runSync('su', ['-c', 'whoami']);
      print("Root izni doğrulandı.");
    } catch (e) {
      print("Cihaz rootlu değil veya izin verilmedi!");
    }
  }

  void _showOverlay() {
    SystemWindowHeader header = SystemWindowHeader(
      title: SystemWindowText(text: "Sistem Aracı", fontSize: 14, textColor: Colors.white),
      padding: SystemWindowPadding.setSymmetricPadding(12, 12),
      decoration: SystemWindowDecoration(startColor: Colors.grey[900]),
    );

    SystemWindowBody body = SystemWindowBody(
      rows: [
        EachRow(columns: [
          EachColumn(text: SystemWindowText(text: "Hafıza Taraması Hazır", fontSize: 12, color: Colors.white70))
        ]),
      ],
    );

    SystemAlertWindow.showSystemWindow(
      height: 200,
      width: 150,
      header: header,
      body: body,
      margin: SystemWindowMargin(left: 8, top: 100, right: 8, bottom: 8),
      gravity: SystemWindowGravity.TOP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gelişmiş Denetleyici")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainType.center,
          children: [
            const Icon(Icons.security, size: 80, color: Colors.greenAccent),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showOverlay,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text("Yüzen Menüyü Aç"),
            ),
          ],
        ),
      ),
    );
  }
}
