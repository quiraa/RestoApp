import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}

class ErrorState extends StatelessWidget {
  final String? error;
  final void Function()? onRefresh;
  const ErrorState({Key? key, this.error, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 48,
              color: Colors.redAccent,
            ),
            Text(
              error ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.redAccent.shade700,
              ),
            ),
            TextButton(
              onPressed: () {
                onRefresh!();
              },
              child: Text(
                'Try Again',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.redAccent.shade700),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String? message;
  const EmptyState({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(message ?? ''),
      ),
    );
  }
}
