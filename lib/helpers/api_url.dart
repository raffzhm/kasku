class ApiUrl {
  static const String baseUrl = 'http://10.0.2.2/kasku-api/public';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listTransaksi = baseUrl + '/transaksi';
  static const String createTransaksi = baseUrl + '/transaksi';

  static String updateTransaksi(int id) {
    return baseUrl + '/transaksi/' + id.toString() + '/update';
  }

  static String showTransaksi(int id) {
    return baseUrl + '/transaksi/' + id.toString();
  }

  static String deleteTransaksi(int id) {
    return baseUrl + '/transaksi/' + id.toString();
  }
}
