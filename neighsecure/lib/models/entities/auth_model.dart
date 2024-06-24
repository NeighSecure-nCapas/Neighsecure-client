import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthModel {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  final String _clientId = dotenv.env['CLIENT_ID']!;
  final String _redirectUrl = dotenv.env['REDIRECT_URL']!;
  final String _discoveryUrl = dotenv.env['DISCOVERY_URL']!;
  final List<String> _scopes = dotenv.env['SCOPES']!.split(',');
  final AuthorizationServiceConfiguration _serviceConfiguration =
      AuthorizationServiceConfiguration(
    authorizationEndpoint: dotenv.env['AUTHORIZATION_ENDPOINT']!,
    tokenEndpoint: dotenv.env['TOKEN_ENDPOINT']!,
    endSessionEndpoint: dotenv.env['END_SESSION_ENDPOINT']!,
  );

  Future<AuthorizationResponse?> signInWithNoCodeExchange() async {
    return await _appAuth.authorize(
      AuthorizationRequest(_clientId, _redirectUrl,
          discoveryUrl: _discoveryUrl, scopes: _scopes),
    );
  }

  Future<String?> getAccessToken() async {
    final AuthorizationTokenResponse? result =
        await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        _clientId,
        _redirectUrl,
        discoveryUrl: _discoveryUrl,
        scopes: _scopes,
      ),
    );

    return result?.accessToken;
  }

  Future<AuthorizationTokenResponse?> getAccessTokenResponse() async {
    return await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        _clientId,
        _redirectUrl,
        discoveryUrl: _discoveryUrl,
        scopes: _scopes,
      ),
    );
  }
}
