import 'dart:convert';
import 'dart:io';
import 'package:dashboard_manga_easy/core/services/apis/api_response_parse/api_erros/api_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Helps {
  static String formetDateFromTimestap(int time) {
    if (time.toString().length == 10) {
      time *= 1000;
    }
    return DateFormat(null, 'pt_Br').format(
      DateTime.fromMillisecondsSinceEpoch(
        time,
      ),
    );
  }

  static Future<bool> verificarConexao() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  // Função responsável por converter um título de manga em um identificador único
  // Removemos termos específicos, convertemos para letras minúsculas e removemos caracteres especiais
  static String convertUniqueid(String titleManga) {
    // Lista de termos a serem removidos do título do manga
    final termos = [
      '(br)',
      '(color)',
      'pt-br',
    ];

    // Converter o título do manga para letras minúsculas
    titleManga = titleManga.toLowerCase();

    // Remover termos específicos do título do manga
    for (var item in termos) {
      titleManga = titleManga.replaceAll(item, '');
    }

    // Remover caracteres especiais do título do manga
    return titleManga.replaceAll(RegExp('[^A-Za-z0-9]'), '');
  }

  static dynamic decode(value) {
    if (value is String) {
      return json.decode(value.replaceAll('\n', ''));
    }
    return value;
  }

  static String capitalize(String string) {
    return '${string[0].toUpperCase()}${string.substring(1).toLowerCase()}';
  }

  static void log(error) {
    final logger = Logger();
    try {
      if (error is ApiError) {
        logger.e(
          error.message,
          time: DateTime.now(),
          error: error,
        );
        return;
      }
      logger.e(
        error.toString(),
        time: DateTime.now(),
        error: error,
        stackTrace: error.stackTrace,
      );
    } catch (e) {
      logger.w(
        error,
        time: DateTime.now(),
      );
    }
  }

  static List<String> convertStringToList(data) {
    if (data is String) {
      data = data.replaceFirst('[', '');
      data = data.replaceFirst(']', '');
      data = data.replaceAll('"', '');
      return data.split(',').map((e) => e.toString().trim()).toList();
    }
    if (data == null) {
      return [];
    }
    if (data.runtimeType.toString() == 'Blob') {
      return data.toString().split(',');
    }
    return data.map<String>((e) => e.toString().trim()).toList();
  }

  static String formatDateAccountCreated(int timestamp) {
    final DateTime data = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final String dataFormatada = DateFormat('d MMMM, y', 'pt_BR').format(data);
    return 'Conta criada em $dataFormatada';
  }

  static void copyText(String? text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text ?? ''));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Texto $text copiado'),
      ),
    );
  }

  static bool get isProd =>
      const String.fromEnvironment('ENVIRONMENT', defaultValue: 'test') ==
      'production';
}
