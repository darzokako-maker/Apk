import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';
import 'dart:io';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainControlPage(),
    );
  }
}

class MainControlPage extends StatefulWidget {
  const MainControlPage({super.key});

  @override
  State<MainControlPage> createState() => _MainControlPageState();
}

class _MainControlPageState extends State<MainControlPage> {
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    await SystemAlertWindow.requestPermissions;
  }

  // Yüzen Menüyü Başlat
  void _openOverlayMenu() {
    SystemWindowHeader header = SystemWindowHeader(
      title: SystemWindowText(text: "Hafıza Denetleyici", fontSize: 14, textColor: Colors.white),
      padding: SystemWindowPadding.setSymmetricPadding(12, 12),
      decoration: SystemWindowDecoration(startColor: Colors.black87),
    );

    SystemWindowBody body = SystemWindowBody(
      rows: [
        EachRow(columns: [
          EachColumn(text: SystemWindowText(text: "Root Durumu: Aktif", fontSize: 12, color: Colors.greenAccent))
        ]),
        EachRow(columns: [
          EachColumn(text: SystemWindowText(text: "Hedef Bekleniyor...", fontSize: 10, color: Colors.white60))
        ]),
      ],
    );

    SystemAlertWindow.showSystemWindow(
      height: 250,
      width: 200,
      header: header,
      body: body,
      gravity: SystemWindowGravity.TOP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sistem Modülü")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.developer_mode, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[800], padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
              onPressed: _openOverlayMenu,
              child: const Text("MENÜYÜ AKTİF ET"),
            ),
          ],
        ),
      ),
    );
  }
}
