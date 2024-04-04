part of '../detail_page.dart';

class DetailForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController reviewController;
  final void Function() onSubmitForm;

  const DetailForm({
    Key? key,
    required this.nameController,
    required this.reviewController,
    required this.onSubmitForm,
  }) : super(key: key);

  @override
  _DetailFormState createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Write a Review',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildNameForm(),
          const SizedBox(height: 16),
          _buildReviewForm(),
          const SizedBox(height: 16),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildNameForm() {
    return TextFormField(
      controller: widget.nameController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(16),
        hintText: 'Name',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.name,
    );
  }

  Widget _buildReviewForm() {
    return TextFormField(
      controller: widget.reviewController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(16),
        alignLabelWithHint: true,
        label: Text('Review'),
        hintText: 'Enter Review',
        border: OutlineInputBorder(),
      ),
      minLines: 3,
      maxLines: null,
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.maxFinite,
      child: FilledButton(
        onPressed: () {
          widget.onSubmitForm();
        },
        child: const Text('Submit'),
      ),
    );
  }
}
