import 'dart:convert';
import 'dart:math';
import "package:asn1lib/asn1lib.dart";
import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import "package:pointycastle/export.dart";
import 'package:uuid/uuid.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/locator.dart';
import 'package:crypto/crypto.dart' as crypto;

class RsaKeyHelper {
  final cacheHelper = locator<CacheGenAlgorithm>();
  Future<Map<String, String>> generateAlgorithmsForInitApp() async {
    String udid = generateRandomUUID;
    final rnd = generateRandomUUID;
    AsymmetricKeyPair generateRSAKeyPair = CryptoUtils.generateRSAKeyPair();

    RSAPrivateKey privateKey = generateRSAKeyPair.privateKey as RSAPrivateKey;
    RSAPublicKey publicKey = generateRSAKeyPair.publicKey as RSAPublicKey;

    cacheHelper.saveRSAPrivateKey(privateKey);
    cacheHelper.saveRSAPublicKey(publicKey);

    String pmk = CryptoUtils.encodeRSAPublicKeyToPem(publicKey);
    Uint8List hash = generateSHA1Digest(udid + rnd);

    String signature = base64Encode(CryptoUtils.rsaSign(privateKey, hash));
    var token = await FirebaseMessaging.instance.getToken();

    print('The FCM Token: ');
    print(token);
    return {
      ...getDeviceInfo,
      "oper": "init",
      "udid": udid,
      "rnd": rnd,
      "pmk": base64Encode(pmk.codeUnits),
      "signature": signature,
      "fcm_key": token ?? ""
    };
  }

  String buildQueryString(Map<String, String> parameters) {
    var query = '';
    parameters.forEach((k, v) {
      final kt = k;
      final vt = escape(v);
      query += '$kt=$vt&';
    });
    return query;
  }

  String escape(String string) {
    return Uri.encodeQueryComponent(string);
  }

  Future<String> getSignature(String rnd, String udid) async {
    try {
      final d = udid + rnd;
      print(d);
      Uint8List hash = generateSHA1Digest(d);
      RSAPrivateKey? privateKey = await cacheHelper.getSavedRSAPrivateKey();
      if (privateKey != null) {
        String signature = base64Encode(CryptoUtils.rsaSign(privateKey, hash));
        return signature;
      } else {
        return "";
      }
    } catch (e) {
      print("objectdbfbfd$e");
      rethrow;
    }
  }

  Map<String, String> get getDeviceInfo {
    final info = locator<SystemInfoService>();
    return {
      "lang": info.getLang,
      "hard_model": info.getHardModel,
      "hard_os": info.getHardOS,
      "hard_name": info.getHardName,
      "hard_lmodel": info.getHardLModel,
      "hard_fmodel": info.getHardFModel,
    };
  }

  Future<AsymmetricKeyPair<PublicKey, PrivateKey>> computeRSAKeyPair(
      SecureRandom secureRandom) async {
    return await compute(getRsaKeyPair, secureRandom);
  }

  String get generateRandomUUID {
    //Generate random UUID
    return const Uuid().v4();
  }

  SecureRandom getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  Uint8List generateSHA1Digest(String input) {
    final Uint8List data = Uint8List.fromList(utf8.encode(input));
    final Digest sha1 = SHA1Digest();
    return sha1.process(data);
  }

  RSAPublicKey parsePublicKeyFromPem(pemString) {
    List<int> publicKeyDER = decodePEM(pemString);
    Uint8List myUint8List = Uint8List.fromList(publicKeyDER);
    var asn1Parser = ASN1Parser(myUint8List);
    var topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

    ASN1Integer modulus, exponent;
    if (topLevelSeq.elements[0].runtimeType == ASN1Integer) {
      modulus = topLevelSeq.elements[0] as ASN1Integer;
      exponent = topLevelSeq.elements[1] as ASN1Integer;
    } else {
      var publicKeyBitString = topLevelSeq.elements[1];

      var publicKeyAsn = ASN1Parser(publicKeyBitString.contentBytes());
      ASN1Sequence publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;
      modulus = publicKeySeq.elements[0] as ASN1Integer;
      exponent = publicKeySeq.elements[1] as ASN1Integer;
    }

    RSAPublicKey rsaPublicKey =
        RSAPublicKey(modulus.valueAsBigInteger, exponent.valueAsBigInteger);

    return rsaPublicKey;
  }

  String sign(String plainText, RSAPrivateKey privateKey) {
    var signer = RSASigner(SHA1Digest(), "0609608648016503040201");
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    return base64Encode(
        signer.generateSignature(createUint8ListFromString(plainText)).bytes);
  }

  Uint8List createUint8ListFromString(String s) {
    var codec = const Utf8Codec(allowMalformed: true);
    return Uint8List.fromList(codec.encode(s));
  }

  RSAPrivateKey parsePrivateKeyFromPem(pemString) {
    List<int> privateKeyDER = decodePEM(pemString);
    Uint8List myUint8List = Uint8List.fromList(privateKeyDER);
    var asn1Parser = ASN1Parser(myUint8List);
    var topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

    ASN1Integer modulus, privateExponent, p, q;

    if (topLevelSeq.elements.length < 3) {
      var privateKey = topLevelSeq.elements[1];

      asn1Parser = ASN1Parser(privateKey.contentBytes());
      var pkSeq = asn1Parser.nextObject() as ASN1Sequence;
      print('Private Key Seq Length: ${topLevelSeq.elements.length}');
      modulus = pkSeq.elements[1] as ASN1Integer;
      privateExponent = pkSeq.elements[3] as ASN1Integer;
      p = pkSeq.elements[4] as ASN1Integer;
      q = pkSeq.elements[5] as ASN1Integer;
    } else {
      modulus = topLevelSeq.elements[1] as ASN1Integer;
      privateExponent = topLevelSeq.elements[3] as ASN1Integer;
      p = topLevelSeq.elements[4] as ASN1Integer;
      q = topLevelSeq.elements[5] as ASN1Integer;
    }

    RSAPrivateKey rsaPrivateKey = RSAPrivateKey(
        modulus.valueAsBigInteger,
        privateExponent.valueAsBigInteger,
        p.valueAsBigInteger,
        q.valueAsBigInteger);
    return rsaPrivateKey;
  }

  List<int> decodePEM(String pem) {
    return base64.decode(removePemHeaderAndFooter(pem));
  }

  String removePemHeaderAndFooter(String pem) {
    var startsWith = [
      "-----BEGIN PUBLIC KEY-----",
      "-----BEGIN RSA PRIVATE KEY-----",
      "-----BEGIN RSA PUBLIC KEY-----",
      "-----BEGIN PRIVATE KEY-----",
      "-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n",
      "-----BEGIN PGP PRIVATE KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n",
    ];
    var endsWith = [
      "-----END PUBLIC KEY-----",
      "-----END PRIVATE KEY-----",
      "-----END RSA PRIVATE KEY-----",
      "-----END RSA PUBLIC KEY-----",
      "-----END PGP PUBLIC KEY BLOCK-----",
      "-----END PGP PRIVATE KEY BLOCK-----",
    ];
    bool isOpenPgp = pem.contains('BEGIN PGP');

    pem = pem.replaceAll(' ', '');
    pem = pem.replaceAll('\n', '');
    pem = pem.replaceAll('\r', '');

    for (var s in startsWith) {
      s = s.replaceAll(' ', '');
      if (pem.startsWith(s)) {
        pem = pem.substring(s.length);
      }
    }

    for (var s in endsWith) {
      s = s.replaceAll(' ', '');
      if (pem.endsWith(s)) {
        pem = pem.substring(0, pem.length - s.length);
      }
    }

    if (isOpenPgp) {
      var index = pem.indexOf('\r\n');
      pem = pem.substring(0, index);
    }

    return pem;
  }

  String encodePrivateKeyToPemPKCS1(RSAPrivateKey privateKey) {
    var topLevel = ASN1Sequence();

    var version = ASN1Integer(BigInt.from(0));
    var modulus = ASN1Integer(privateKey.n!);
    var publicExponent = ASN1Integer(privateKey.exponent!);
    var privateExponent = ASN1Integer(privateKey.d!);
    var p = ASN1Integer(privateKey.p!);
    var q = ASN1Integer(privateKey.q!);
    var dP = privateKey.d! % ((privateKey.p)! - BigInt.from(1));
    var exp1 = ASN1Integer(dP);
    var dQ = privateKey.d! % (privateKey.q! - BigInt.from(1));
    var exp2 = ASN1Integer(dQ);
    var iQ = privateKey.q!.modInverse(privateKey.p!);
    var co = ASN1Integer(iQ);

    topLevel.add(version);
    topLevel.add(modulus);
    topLevel.add(publicExponent);
    topLevel.add(privateExponent);
    topLevel.add(p);
    topLevel.add(q);
    topLevel.add(exp1);
    topLevel.add(exp2);
    topLevel.add(co);

    var dataBase64 = base64.encode(topLevel.encodedBytes);

    return """-----BEGIN PRIVATE KEY-----\r\n$dataBase64\r\n-----END PRIVATE KEY-----""";
  }

  String encodePublicKeyToPemPKCS1(RSAPublicKey publicKey) {
    var topLevel = ASN1Sequence();

    topLevel.add(ASN1Integer(publicKey.modulus!));
    topLevel.add(ASN1Integer(publicKey.exponent!));

    var dataBase64 = base64.encode(topLevel.encodedBytes);
    return """-----BEGIN PUBLIC KEY-----\r\n$dataBase64\r\n-----END PUBLIC KEY-----""";
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = crypto.sha256.convert(bytes);
    return digest.toString();
  }
}

AsymmetricKeyPair<PublicKey, PrivateKey> getRsaKeyPair(
    SecureRandom secureRandom) {
  var rsapars = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);
  var params = ParametersWithRandom(rsapars, secureRandom);
  var keyGenerator = RSAKeyGenerator();
  keyGenerator.init(params);
  return keyGenerator.generateKeyPair();
}
