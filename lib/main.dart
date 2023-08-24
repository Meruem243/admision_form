import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_document/open_document.dart';

// import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf_invoice_generator_flutter/model/product.dart';

void main() {
  runApp(const AdmissionFormApp());
}

class AdmissionFormApp extends StatelessWidget {
  const AdmissionFormApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Admission Form App',
      home: const AdmissionFormPage(),
    );
  }
}

class AdmissionFormPage extends StatefulWidget {
  const AdmissionFormPage({Key? key}) : super(key: key);

  @override
  createState() => _AdmissionFormPageState();
}

class _AdmissionFormPageState extends State<AdmissionFormPage> {
  XFile? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        },
      ),
    );

    return pdf.save();
  }

  final List<String> itemsOfGrad = [
    'Matric',
    'Inter-Mediate',
    'O/A Levels',
    'Undergraduate',
  ];
  String? selectedValueGrad = 'Matric';

  final List<String> itemsNationality = [
    'nat1',
    'nat2',
    'nat3',
    'nat4',
  ];
  String? selectedValueNat = 'nat1';

  final List<String> itemsPraf = [
    'praf11',
    'praf12',
    'praf13',
    'praf14',
  ];
  String? selectedValuePraf = 'praf11';

  final List<String> itemsPraf2 = [
    'praf21',
    'praf22',
    'praf23',
    'praf24',
  ];
  String? selectedValuePraf2 = 'praf21';

  final List<String> itemsPraf3 = [
    'praf31',
    'praf32',
    'praf33',
    'praf34',
  ];
  String? selectedValuePraf3 = 'praf31';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admission Form')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Student Information',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Full Name'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Candidate CNIC/B-Form No'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Date of Birth'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      child: Column(
                        children: [
                          const Text('Nationality'),
                          const SizedBox(height: 20),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: itemsNationality
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValueNat,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValueNat = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(11),
                      child: Column(
                        children: [
                          const Text('CNIC back'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text('Pick Image'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(11),
                      child: Column(
                        children: [
                          const Text('CNIC front'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text('Pick Image'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(11),
                      child: Column(
                        children: [
                          const Text('Candidate Photo'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text('Pick Image'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (_image != null)
                  Image.file(
                    File(_image!.path),
                    height: 100,
                    width: 100,
                  ),
                //ADD IMAGE PICKING BUTTON HERE

                const SizedBox(height: 40),

                // adding news
                //new works

                const Text(
                  'Contact details Information',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Mailing address'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Mailing city'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Permanent address'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Permanent city'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                //new up
                //new up

                //new down
                const Text(
                  'Parent/Guardian details',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Father\'s Name'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Father\'s CNIC number'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Father\'s mobile number'),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 20),

                const Text(
                  'Academics',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      child: Column(
                        children: [
                          const Text('Graduation'),
                          const SizedBox(height: 20),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: itemsOfGrad
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValueGrad,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValueGrad = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SwitchCaseWidget(selectedValueGrad!),

                const SizedBox(height: 40),

                const Text(
                  'Preferences',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      child: Column(
                        children: [
                          const Text('Preferences1'),
                          const SizedBox(height: 20),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: itemsPraf
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValuePraf,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValuePraf = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(11),
                      child: Column(
                        children: [
                          const Text('Praf2'),
                          const SizedBox(height: 20),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: itemsPraf2
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValuePraf2,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValuePraf2 = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(11),
                      child: Column(
                        children: [
                          const Text('Praf3'),
                          const SizedBox(height: 20),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: itemsPraf3
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValuePraf3,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValuePraf3 = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    debugPrint(selectedValueGrad);
                    // Add form submission logic here
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SwitchCaseWidget extends StatelessWidget {
//   final String value;
//   const SwitchCaseWidget(this.value, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     switch (value) {
//       case 'Item1':
//         return Container(
//           padding: const EdgeInsets.all(1.0),
//           child: const Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Obtain marks'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Total Marks'),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Starting year'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Ending year'),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         );
//       case 'Item2':
//         return Container(
//           padding: const EdgeInsets.all(1.0),
//           child: const Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Obtain marks'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Total Marks'),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Starting year'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Ending year'),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Obtain marks'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Total Marks'),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Starting year'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Ending year'),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         );
//
//       case 'Item3':
//         return Container(
//           padding: const EdgeInsets.all(1.0),
//           child: const Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Obtain marks'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Total Marks'),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Starting year'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'Ending year'),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         );
//
//       default:
//         return const Text('Default');
//     }
//   }
// }

//
//new widget
class SwitchCaseWidget extends StatefulWidget {
  final String value;
  const SwitchCaseWidget(this.value, {super.key});

  @override
  createState() => _SwitchCaseWidgetState();
}

class _SwitchCaseWidgetState extends State<SwitchCaseWidget> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {});
    }
  }

  final List<String> items = [
    'BS-BA',
    'BSC',
    'BSP',
    'BS-MATHS',
  ];
  String? selectedValue = 'BS-BA';

  @override
  Widget build(BuildContext context) {
    switch (widget.value) {
      case 'Matric':
        return Container(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Obtain marks'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Total Marks'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Starting year'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Ending year'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(11),
                child: Column(
                  children: [
                    const Text('Result Card'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Pick Image'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case 'Inter-Mediate':
        return Container(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Obtain marks'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Total Marks'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Starting year'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Ending year'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Obtain marks'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Total Marks'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Starting year'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Ending year'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(11),
                child: Column(
                  children: [
                    const Text('Result Card'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Pick Image'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'O/A Levels':
        return Container(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Obtain marks'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Total Marks'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Starting year'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Ending year'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(11),
                child: Column(
                  children: [
                    const Text('Result Card'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Pick Image'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      default:
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              child: Column(
                children: [
                  const Text('Under Graduate Programs'),
                  const SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration:
                              InputDecoration(labelText: 'Starting year'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Ending year'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration:
                              InputDecoration(labelText: 'Obtained CGPA'),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      children: [
                        const Text('Result Card'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Pick Image'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }
}
