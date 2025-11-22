class TransactionException implements Exception {
  final String message;
  final TransactionErrorType type;

  TransactionException(this.message, this.type);

  @override
  String toString() => message;
}

enum TransactionErrorType {
  invalidMerchant,
  insufficientFunds,
  unauthorized,
  serverError,
  networkError,
  unknown
}

class TransactionErrorParser {
  static TransactionException parseError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('404') || errorString.contains('not found') || errorString.contains('marchand')) {
      return TransactionException(
        'Numéro/code marchand incorrect. Vérifiez et réessayez.',
        TransactionErrorType.invalidMerchant,
      );
    }

    if (errorString.contains('400') || errorString.contains('insufficient') || errorString.contains('solde') || errorString.contains('funds')) {
      return TransactionException(
        'Solde insuffisant pour effectuer cette transaction.',
        TransactionErrorType.insufficientFunds,
      );
    }

    if (errorString.contains('401') || errorString.contains('unauthorized') || errorString.contains('token')) {
      return TransactionException(
        'Session expirée. Veuillez vous reconnecter.',
        TransactionErrorType.unauthorized,
      );
    }

    if (errorString.contains('403') || errorString.contains('forbidden')) {
      return TransactionException(
        'Opération non autorisée.',
        TransactionErrorType.unauthorized,
      );
    }

    if (errorString.contains('500') || errorString.contains('server') || errorString.contains('internal')) {
      return TransactionException(
        'Erreur serveur. Veuillez réessayer plus tard.',
        TransactionErrorType.serverError,
      );
    }

    if (errorString.contains('network') || errorString.contains('connection') || errorString.contains('timeout')) {
      return TransactionException(
        'Problème de connexion. Vérifiez votre réseau.',
        TransactionErrorType.networkError,
      );
    }

    return TransactionException(
      'Erreur lors de la transaction. Veuillez réessayer.',
      TransactionErrorType.unknown,
    );
  }
}