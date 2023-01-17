import 'package:beco/models/wallet.dart';
import 'package:beco/resources/firestore_methods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCubit extends Cubit<List<Wallet>> {
  WalletCubit() : super([]);

  void addMoney(double amount, String currency) {
    List<Wallet> result = state.map((wallet) {
      if (wallet.currency == currency) {
        wallet.amount += amount;
      }
      return wallet;
    }).toList();
    emit(result);
  }

  void minusMoney(double amount, String currency) {
    List<Wallet> result = state.map((wallet) {
      if (wallet.currency == currency) {
        wallet.amount -= amount;
      }
      return wallet;
    }).toList();
    emit(result);
  }

  String addWallet(Wallet wallet) {
    List<Wallet> result = state;
    for (Wallet w in result) {
      if (w.currency == wallet.currency) {
        return 'already exists';
      }
    }
    FirestoreMethods().addWallet(wallet);
    result.add(wallet);
    emit(result);
    return 'success';
  }

  void refreshWallet() async {
    List<Wallet> result = await FirestoreMethods().getWallets();
    emit(result);
  }
}
