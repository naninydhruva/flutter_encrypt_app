import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'dart:convert';

class AESEncryption {
  AESEncryption._();

  static String aesSecureKey = "-JaNdRgUkXp2s5v8x/A?D(G+KbPeShVm";

  static String aesSecureIV = "aPdSgVkYp3s6v9y\$";
  static String aesProdSecureKey = "98c477cc101459879b3c728b5410e876";
  static String aesProdSecureIV = "913022c035ab8193";

  static String encrypt(String value, {bool isProd = false}) {
    final key = Key.fromUtf8(isProd ? aesProdSecureKey : aesSecureKey);
    final iv = IV.fromUtf8(isProd ? aesProdSecureIV : aesSecureIV);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(value, iv: iv);
    return encrypted.base64;
  }

  static String decrypt(String encoded, {bool isProd = false}) {
    final key = Key.fromUtf8(isProd ? aesProdSecureKey : aesSecureKey);
    final iv = IV.fromUtf8(isProd ? aesProdSecureIV : aesSecureIV);
    try {
      final encrypted = Encrypted.fromBase64(encoded);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypt = encrypter.decrypt(encrypted, iv: iv);
      return decrypt;
    } catch (exception) {
      return encoded;
    }
  }

  static String getHashValue(String message) {
    String trimmedMessage = message.trim().toLowerCase();
    final bytes = utf8.encode(trimmedMessage);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
