import 'package:flutter/material.dart';

abstract class Model {
  // Note: The path follows Drupal's [entity]/[bundle]/[uuid] pattern

  final String baseUrl = "http://127.0.0.1:8888/jsonapi";

  @protected
  Map<String, String> getHeaders({String? csrfToken}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.api+json',
      csrfToken != null ? 'X-CSRF-Token' : '': csrfToken ?? '',
    };
  }
}
