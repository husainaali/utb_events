import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';
import 'package:utb_events/utils/size_extensions.dart';

import '../../constant/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../utils/university_data.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _quillController = quill.QuillController.basic();
  List<XFile>? _selectedImages;
  List<EventSchedule> schedules = [EventSchedule()];
  List<String> selectedUniversities = [];
  bool isAllUniversities = false;
  bool isAllMembers = false;
  List<String> selectedMembers = [];
  List<String> selectedOccupations = [];
  bool isAllOccupationsSelected = false;
  bool isAllUniversitiesSelected = false;
  List<String> selectedUniversityNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Create Event'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePicker(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Event Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Event Description'),
                  const SizedBox(height: 8),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: quill.QuillEditor.basic(
                      controller: _quillController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Event Schedule'),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: schedules[index].date != null
                                      ? "${schedules[index].date!.day.toString().padLeft(2, '0')}/${schedules[index].date!.month.toString().padLeft(2, '0')}/${schedules[index].date!.year}"
                                      : 'Select Date'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                );
                                if (date != null) {
                                  setState(() {
                                    schedules[index].date = date;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildOccupationSelection(),
              const SizedBox(height: 16),
              _buildUniversitySelection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Event Images'),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final List<XFile> images = await picker.pickMultiImage();
            if (images.isNotEmpty) {
              setState(() {
                _selectedImages = images;
              });
            }
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _selectedImages?.isEmpty ?? true
                ? const Center(child: Icon(Icons.add_photo_alternate, size: 50))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages!.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        File(_selectedImages![index].path),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildOccupationSelection() {
    final List<String> occupations = [
      'Student',
      'Professor',
      'Lecturer',
      'Dean',
      'Department Head',
      'Administrator',
      'Accountant',
      'Advertiser',
      'Marketing Staff',
      'Alumni',
      'Research Assistant',
      'Teaching Assistant',
      'Library Staff',
      'IT Staff',
      'All',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Target Occupations'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: occupations.map((occupation) {
            final isSelected = occupation == 'All'
                ? isAllOccupationsSelected
                : selectedOccupations.contains(occupation);

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? primaryColor : Colors.white,
                foregroundColor: isSelected ? Colors.white : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (occupation == 'All') {
                    isAllOccupationsSelected = !isAllOccupationsSelected;
                    selectedOccupations = isAllOccupationsSelected
                        ? occupations.where((o) => o != 'All').toList()
                        : [];
                  } else {
                    if (selectedOccupations.contains(occupation)) {
                      selectedOccupations.remove(occupation);
                      isAllOccupationsSelected = false;
                    } else {
                      selectedOccupations.add(occupation);
                      if (selectedOccupations.length ==
                          occupations.length - 1) {
                        isAllOccupationsSelected = true;
                      }
                    }
                  }
                });
              },
              child: Text(occupation),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildUniversitySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Target Universities'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['All', ...bahrainUniversities.map((u) => u.shortName)]
              .map((universityName) {
            final isSelected = universityName == 'All'
                ? isAllUniversitiesSelected
                : selectedUniversityNames.contains(universityName);

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? primaryColor : Colors.white,
                foregroundColor: isSelected ? Colors.white : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (universityName == 'All') {
                    isAllUniversitiesSelected = !isAllUniversitiesSelected;
                    selectedUniversityNames = isAllUniversitiesSelected
                        ? bahrainUniversities.map((u) => u.shortName).toList()
                        : [];
                  } else {
                    if (selectedUniversityNames.contains(universityName)) {
                      selectedUniversityNames.remove(universityName);
                      isAllUniversitiesSelected = false;
                    } else {
                      selectedUniversityNames.add(universityName);
                      if (selectedUniversityNames.length ==
                          bahrainUniversities.length) {
                        isAllUniversitiesSelected = true;
                      }
                    }
                  }
                });
              },
              child: Text(universityName),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Create Event',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(height: 90.h),
      ],
    );
  }

  // Add other widget methods...
}

class EventSchedule {
  DateTime? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
}
