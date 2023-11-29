import 'package:flutter/material.dart';

class CreateTweet extends StatefulWidget {
  @override
  State<CreateTweet> createState() => _CreateTweetState();
}

class _CreateTweetState extends State<CreateTweet> {
  final _formKey = GlobalKey<FormState>();
  final userLongNameController = TextEditingController();
  final userShortNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  final imageUrl = "imageURL";
  final userLongName = "userLongName";
  final userShortName = "userShortName";
  final description = "description";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Tweet")),
      body: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
                controller: userLongNameController,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return "Must include value for long name";
                  }
                  return null;
                }),
            TextFormField(
                controller: userShortNameController,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return "Must include value for short name";
                  }
                  return null;
                }),
            TextFormField(
                controller: descriptionController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Must include a body for the tweet";
                  }
                  return null;
                }),
            TextFormField(
              controller: imageUrlController,
              validator: (url) {
                if (url != null) {
                  try {
                    if (Uri.parse(url).isAbsolute) {
                      return null;
                    }
                  } on FormatException catch (_, e) {
                    return "Invalid URL";
                  }
                }
                return null;
              },
              decoration:
                  const InputDecoration(labelText: "Image URL (Optional)"),
            )
          ])),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop({
                userLongName: userLongNameController.text.trim(),
                userShortName: userShortNameController.text.trim(),
                description: descriptionController.text.trim(),
                imageUrl: imageUrlController.text.trim().isEmpty
                    ? null
                    : imageUrlController.text.trim()
              });
            }
          },
          child: const Icon(Icons.save)),
    );
  }
}
