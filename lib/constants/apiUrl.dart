const String baseUrl = 'https://backend-ompay-springboot.onrender.com';

const Map<String,String> ApiUrls = {
  'getUser': '$baseUrl/users',
  'createUser': '$baseUrl/users',
  'login': '$baseUrl/auth/login',
  'getComptes': '$baseUrl/comptes',
  'createCompte': '$baseUrl/comptes',
  'getDetailCompte': '$baseUrl/comptes/me',
  'transfert': '$baseUrl/comptes/transfert',
  'paiement': '$baseUrl/comptes/paiement',
  'scheduleTransfer': '$baseUrl/transferts/schedule',
};