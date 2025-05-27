// lib/activity_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tambahkan dependency intl: flutter pub add intl
import 'package:fistra_1/home/presentation/screens/aktifitas/transaction_model.dart';
import 'package:fistra_1/home/presentation/screens/aktifitas/detail_transaksi.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1256949725', // Kode Transaksi
      description: 'ke Indomaret',
      date: DateTime(2026, 5, 12, 21, 9, 49), // Tambahkan jam dan menit
      amount: -23000,
      status: 'Berhasil',
      recipientName: 'INDOMARET',
      sourceOfFundsName: 'Ahmad Rafiansyah',
      sourceOfFundsAccount: '082345673214',
      transactionFee: 0,
      paymentStatusMessage: 'Pembayaran berhasil',
      iconBackgroundColor:
          Colors.blue.shade300, // Sedikit beda dari desain, sesuaikan
    ),
    Transaction(
      id: '1256949726',
      description: 'ke Alfamart',
      date: DateTime(2026, 5, 4, 10, 30, 0),
      amount: -43000,
      status: 'Berhasil',
      recipientName: 'ALFAMART',
      sourceOfFundsName: 'Rekening Utama',
      sourceOfFundsAccount: '123-456-7890',
      transactionFee: 0,
      paymentStatusMessage: 'Pembayaran berhasil',
      iconBackgroundColor: Colors.blue.shade300,
    ),
    Transaction(
      id: '1256949727',
      description: 'ke Alfamart',
      date: DateTime(2026, 4, 2, 15, 0, 0),
      amount: -34000,
      status: 'Berhasil',
      recipientName: 'ALFAMART',
      sourceOfFundsName: 'Dompet Digital',
      sourceOfFundsAccount: 'dana@example.com',
      transactionFee: 0,
      paymentStatusMessage: 'Pembayaran berhasil',
      iconBackgroundColor: Colors.blue.shade300,
    ),
    Transaction(
      id: '1256949728',
      description: 'ke Alfamart',
      date: DateTime(2026, 4, 1, 9, 0, 0),
      amount: -12000,
      status: 'Berhasil',
      recipientName: 'ALFAMART',
      sourceOfFundsName: 'Ahmad Rafiansyah',
      sourceOfFundsAccount: '082345673214',
      transactionFee: 0,
      paymentStatusMessage: 'Pembayaran berhasil',
      iconBackgroundColor: Colors.blue.shade300,
    ),
    Transaction(
      id: '1256949729',
      description: 'Transfer ke Budi',
      date: DateTime(2026, 3, 20, 11, 5, 0),
      amount: -50000,
      status: 'Berhasil',
      iconData: Icons.send,
      iconBackgroundColor: Colors.orange.shade300,
      recipientName: 'Budi Santoso',
      sourceOfFundsName: 'Rekening Gaji',
      sourceOfFundsAccount: '987-654-3210',
      transactionFee: 500,
      paymentStatusMessage: 'Transfer berhasil',
    ),
    Transaction(
      id: '1256949730',
      description: 'Top Up Saldo',
      date: DateTime(2026, 3, 15, 17, 20, 0),
      amount: 100000,
      status: 'Berhasil',
      iconData: Icons.account_balance_wallet,
      iconBackgroundColor: Colors.green.shade300,
      statusColor: Colors.blue,
      recipientName: 'Akun Saya', // Atau bisa juga nama akunnya
      paymentStatusMessage: 'Top Up berhasil',
      transactionFee: 0,
      // sourceOfFunds bisa null jika tidak relevan untuk top up dari sumber eksternal
    ),
  ];

  Map<String, List<Transaction>> _groupedTransactions = {};

  @override
  void initState() {
    super.initState();
    _groupTransactions();
  }

  void _groupTransactions() {
    // Sort transactions by date descending first
    _transactions.sort((a, b) => b.date.compareTo(a.date));

    final DateFormat monthYearFormat = DateFormat('MMMM yyyy', 'id_ID');
    for (var tx in _transactions) {
      String monthYear = monthYearFormat.format(tx.date);
      if (_groupedTransactions[monthYear] == null) {
        _groupedTransactions[monthYear] = [];
      }
      _groupedTransactions[monthYear]!.add(tx);
    }
    // Ensure keys (months) are also sorted if needed (Map iteration order is insertion order)
    // For displaying, it's better to convert map keys to a sorted list.
  }

  // Helper untuk format mata uang
  String _formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    // Untuk memastikan urutan bulan benar (terbaru di atas)
    List<String> sortedMonthKeys = _groupedTransactions.keys.toList();
    // Jika kita tidak sort transactions di awal, kita perlu sort keys di sini berdasarkan tanggal pertama di groupnya.
    // Tapi karena _transactions sudah di-sort, _groupedTransactions.keys akan mengikuti urutan bulan terbaru.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Aktifitas',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Mirip dengan desain
      ),
      body: ListView.builder(
        itemCount: sortedMonthKeys.length,
        itemBuilder: (ctx, monthIndex) {
          String monthYear = sortedMonthKeys[monthIndex];
          List<Transaction> monthlyTransactions =
              _groupedTransactions[monthYear]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Text(
                  monthYear,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              ListView.separated(
                physics:
                    const NeverScrollableScrollPhysics(), // Penting untuk nested ListView
                shrinkWrap: true, // Penting untuk nested ListView
                itemCount: monthlyTransactions.length,
                itemBuilder: (ctx, txIndex) {
                  final tx = monthlyTransactions[txIndex];
                  return _buildTransactionItem(context, tx);
                },
                separatorBuilder:
                    (ctx, index) => const Divider(
                      height: 1,
                      indent: 72,
                      endIndent: 16,
                    ), // Indent sesuai icon
              ),
              if (monthIndex <
                  sortedMonthKeys.length -
                      1) // Tambah spasi antar grup bulan, kecuali yg terakhir
                const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction tx) {
    final DateFormat dayMonthYearFormat = DateFormat('d MMMM yyyy', 'id_ID');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailScreen(transaction: tx),
          ),
        );
        // Atau jika menggunakan named routes:
        // Navigator.pushNamed(context, '/transactionDetail', arguments: tx);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: tx.iconBackgroundColor,
              child: Icon(tx.iconData, color: tx.iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.description,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dayMonthYearFormat.format(tx.date),
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatCurrency(tx.amount),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color:
                        tx.amount < 0 ? Colors.black87 : Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tx.status,
                  style: TextStyle(fontSize: 13, color: tx.statusColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
