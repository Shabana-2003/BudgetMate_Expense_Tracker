import 'dart:io';
import 'package:budgetmate/features/money_management/data/models/finances_data.dart';
import 'package:budgetmate/features/money_management/presentation/pages/settings/settings.dart';
import 'package:budgetmate/features/money_management/presentation/widgets/main_navigation_bar.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _profilePhotoController;
  late TextEditingController _petNameController;

  String? _selectedGender;
  String defaultPhotoPath = 'assets/images/profile.png';
  late ProfileData _profileData;

  bool _isEditing = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _profilePhotoController = TextEditingController();
    _petNameController = TextEditingController();
    _loadProfileData();
    _profileData = ProfileData('', '', '', '');
  }

  Future<void> _loadProfileData() async {
    final profileBox = await Hive.openBox<ProfileData>('profileBox');
    if (profileBox.isNotEmpty) {
      _profileData = profileBox.getAt(0)!;

      setState(() {
        _nameController.text = _profileData.name;
        _selectedGender = _profileData.gender;
        _petNameController.text = _profileData.nickName;
        _profilePhotoController.text = _profileData.profilePhotoPath;
      });
    }
  }

  Future<void> _saveProfile() async {
    final profileBox = await Hive.openBox<ProfileData>('profileBox');

    _profileData.name = _nameController.text;
    _profileData.gender = _selectedGender ?? '';
    _profileData.nickName = _petNameController.text;

    _profileData.profilePhotoPath = _profilePhotoController.text;

    if (profileBox.isEmpty) {
      await profileBox.add(_profileData);
    } else {
      await profileBox.putAt(0, _profileData);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile saved successfully'),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _profileData.profilePhotoPath = pickedFile.path;
          _profilePhotoController.text = pickedFile.path;
        });

        _showBottomDialog();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _showBottomDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              title: const Text('Delete photo',
                  style: TextStyle(color: Color.fromARGB(255, 253, 252, 252))),
              tileColor:const Color.fromARGB(255, 47, 125, 121),
              onTap: () {
                _deleteProfilePhoto();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Add photo',
                  style: TextStyle(color: Color.fromARGB(255, 250, 250, 250))),
              tileColor:const Color.fromARGB(255, 47, 125, 121),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteProfilePhoto() {
    setState(() {
      _profileData.profilePhotoPath = '';
      _profilePhotoController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 700,
                    decoration:const BoxDecoration(
                      color: Color(0xff368983),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(400),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: Stack(
                      children: [
                       const Positioned(
                          top: 50,
                          left: 25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Profile!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 43,
                          right: 5,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsScreen()),
                              );
                            },
                            icon:const Icon(Icons.settings),
                            color:const Color.fromARGB(255, 227, 227, 227),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 30,
                    bottom: 90,
                    right: 30,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        boxShadow:const [
                       BoxShadow(
                            color: Color.fromRGBO(242, 250, 250, 0.294),
                            offset: Offset(0, 6),
                            blurRadius: 12,
                            spreadRadius: 6,
                          ),
                        ],
                        color:const Color.fromARGB(255, 248, 249, 249),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_isEditing) {
                                  _pickImage();
                                }
                              },
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 80,
                                    backgroundColor:
                                      const  Color.fromARGB(255, 47, 125, 121),
                                    child: _profilePhotoController
                                            .text.isNotEmpty
                                        ? ClipOval(
                                            child: Image.file(
                                              File(_profileData
                                                  .profilePhotoPath),
                                              fit: BoxFit.cover,
                                              width: 220.0,
                                              height: 220.0,
                                            ),
                                          )
                                        : ClipOval(
                                            child: Image.asset(
                                              defaultPhotoPath,
                                              fit: BoxFit.cover,
                                              width: 120.0,
                                              height: 120.0,
                                            ),
                                          ),
                                  ),
                                  const Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 252, 253, 253),
                                      radius: 20,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color:
                                            Color.fromARGB(255, 47, 125, 121),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                           const SizedBox(height: 16),
                            TextFormField(
                              controller: _nameController,
                              cursorColor:const Color.fromARGB(255, 47, 125,
                                  121),
                              decoration:const InputDecoration(
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 143, 143, 143),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 47, 125, 121),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                    Color.fromARGB(255, 31, 31, 31),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: ['Female', 'Male', 'Other']
                                  .map(
                                    (String value) => ChoiceChip(
                                      label: Text(value),
                                      selected: _selectedGender == value,
                                      selectedColor:const Color.fromARGB(255, 188, 188, 188),
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _selectedGender =
                                              selected ? value : null;
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 17),
                            TextFormField(
                              controller: _petNameController,
                              cursorColor:const Color.fromARGB(255, 47, 125, 121),
                              decoration:const InputDecoration(
                                labelText: 'Nickname',
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 47, 125, 121)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 47, 125, 121)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              style: _petNameController.text.isNotEmpty
                                  ?const  TextStyle(
                                      color:
                                       Color.fromARGB(255, 6, 5, 5))
                                  : null,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _saveProfile();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>const MainNavigationBar(),
                    ),
                  );
                },
           
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                     const Color.fromARGB(255, 47, 125, 121)),
                  fixedSize: MaterialStateProperty.all<Size>(
                  const  Size(200, 70),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                ),
                     child:const Text('Save Profile', style: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
      ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
