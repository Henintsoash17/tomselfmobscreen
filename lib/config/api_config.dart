import 'dart:io';

class ApiConfig {
  static const String _localhostUrl = 'http://localhost:2022';
  static const String _androidEmulatorUrl = 'http://10.0.2.2:2022';
  static const String _iosSimulatorUrl = 'http://127.0.0.1:2022';
  
  // Pour les appareils physiques, remplace par l'IP de ton PC
  static const String _physicalDeviceUrl = 'http://10.0.2.2:2022'; // À adapter selon ton réseau
  
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Détecte si c'est un émulateur ou un appareil physique
      return _isEmulator() ? _androidEmulatorUrl : _physicalDeviceUrl;
    } else if (Platform.isIOS) {
      return _isEmulator() ? _iosSimulatorUrl : _physicalDeviceUrl;
    }
    return _localhostUrl;
  }
  
  static bool _isEmulator() {
    // Méthode améliorée pour détecter l'émulateur Android
    if (Platform.isAndroid) {
      return _isAndroidEmulator();
    } else if (Platform.isIOS) {
      return _isIOSSimulator();
    }
    return false;
  }
  
  static bool _isAndroidEmulator() {
    // Vérifications multiples pour détecter l'émulateur Android
    final env = Platform.environment;
    
    // Vérification 1: Variables d'environnement
    if (env['FLUTTER_TEST'] == 'true') return false; // Tests unitaires
    if (env['ANDROID_EMULATOR'] == 'true') return true;
    
    // Vérification 2: Propriétés système Android courantes
    final brand = env['ro.product.brand']?.toLowerCase();
    final model = env['ro.product.model']?.toLowerCase();
    final device = env['ro.product.device']?.toLowerCase();
    final hardware = env['ro.hardware']?.toLowerCase();
    
    // Indicateurs d'émulateur
    final emulatorIndicators = [
      'generic', 'emulator', 'simulator', 'android sdk built for x86',
      'sdk_gphone', 'google_sdk', 'goldfish', 'ranchu'
    ];
    
    for (final indicator in emulatorIndicators) {
      if (brand?.contains(indicator) == true ||
          model?.contains(indicator) == true ||
          device?.contains(indicator) == true ||
          hardware?.contains(indicator) == true) {
        return true;
      }
    }
    
    // Vérification 3: Tentative de lecture des fichiers système (Android spécifique)
    try {
      // Ces fichiers existent généralement sur les émulateurs
      final emulatorFiles = [
        '/system/bin/qemu-props',
        '/sys/qemu_trace',
        '/system/lib/libc_malloc_debug_qemu.so'
      ];
      
      for (final file in emulatorFiles) {
        if (File(file).existsSync()) {
          return true;
        }
      }
    } catch (e) {
      // Ignore les erreurs de permission
    }
    
    // Par défaut, considère comme appareil physique
    return false;
  }
  
  static bool _isIOSSimulator() {
    final env = Platform.environment;
    return env['SIMULATOR_DEVICE_NAME'] != null ||
           env['SIMULATOR_ROOT'] != null ||
           env['IPHONE_SIMULATOR_ROOT'] != null;
  }
  
  // Méthode pour debug - à utiliser temporairement
  static Map<String, String> getDebugInfo() {
    final env = Platform.environment;
    return {
      'Platform': Platform.operatingSystem,
      'isEmulator': _isEmulator().toString(),
      'baseUrl': baseUrl,
      'ANDROID_EMULATOR': env['ANDROID_EMULATOR'] ?? 'null',
      'ro.product.brand': env['ro.product.brand'] ?? 'null',
      'ro.product.model': env['ro.product.model'] ?? 'null',
      'ro.product.device': env['ro.product.device'] ?? 'null',
      'ro.hardware': env['ro.hardware'] ?? 'null',
    };
  }
  
  // Endpoints API
  static String get apiUrl => '$baseUrl/api';
  static String get authUrl => '$apiUrl/auth';
  static String get usersUrl => '$apiUrl/users';
  static String get profileUrl => '$apiUrl/profile';
}