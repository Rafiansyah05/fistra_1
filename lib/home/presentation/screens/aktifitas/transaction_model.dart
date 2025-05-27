// lib/transaction_model.dart
import 'package:flutter/material.dart';

enum TransactionType { payment, topUp, transfer }

class Transaction {
  final String id; // Digunakan sebagai Kode Transaksi
  final String description; // Deskripsi umum untuk daftar
  final DateTime date;
  final double amount; // Nominal pembayaran (sebelum biaya jika ada)
  final String status;
  final Color statusColor;
  final IconData iconData;
  final Color iconColor;
  final Color iconBackgroundColor;

  // Detail tambahan untuk halaman detail
  final String paymentStatusMessage; // e.g., "Pembayaran berhasil"
  final String recipientName; // e.g., "INDOMARET"
  final String? sourceOfFundsName; // e.g., "Ahmad Rafiansyah"
  final String? sourceOfFundsAccount; // e.g., "082345673214"
  final double transactionFee; // Biaya transaksi

  Transaction({
    required this.id,
    required this.description,
    required this.date,
    required this.amount,
    required this.status,
    this.statusColor = Colors.green,
    this.iconData = Icons.file_present_outlined,
    this.iconColor = Colors.white,
    this.iconBackgroundColor = Colors.blue,
    // Default untuk detail
    this.paymentStatusMessage = 'Pembayaran berhasil',
    required this.recipientName,
    this.sourceOfFundsName,
    this.sourceOfFundsAccount,
    this.transactionFee = 0.0,
  });

  // Helper untuk total amount
  double get totalAmount =>
      amount.abs() + transactionFee.abs(); // amount bisa negatif
}
