// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import '../classifier/classifier.dart';
import '../styles.dart';
import 'fish_photo_view.dart';

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model_unquant.tflite';

const _labelsFileName_dieseses = 'assets/dieseses_labels.txt';
const _modelFileName_dieseses = 'dieseses_model_unquant.tflite';

const _labelsFileName_gb = 'assets/Gbandulalabels.txt';
const _modelFileName_gb = 'gbandulamodel_unquant.tflite';

const _labelsFileName_gg = 'assets/Ggouramilabels.txt';
const _modelFileName_gg = 'Ggouramimodel_unquant.tflite';

const _labelsFileName_gm = 'assets/Gmosqutiolabels.txt';
const _modelFileName_gm = 'Gmosqutiomodel_unquant.tflite';

const _labelsFileName_gp = 'assets/Gpathiranalabels.txt';
const _modelFileName_gp = 'Gpathiranamodel_unquant.tflite';

const _labelsFileName_gt = 'assets/GThilapiyalabels.txt';
const _modelFileName_gt = 'GThilapiyamodel_unquant.tflite';

class PlantRecogniser extends StatefulWidget {
  const PlantRecogniser({super.key});

  @override
  State<PlantRecogniser> createState() => _PlantRecogniserState();
}

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

enum _ResultStatus2 {
  notStarted,
  notFound,
  found,
}

enum _ResultStatusGB {
  notStarted,
  notFound,
  found,
}

enum _ResultStatusGG {
  notStarted,
  notFound,
  found,
}

enum _ResultStatusGP {
  notStarted,
  notFound,
  found,
}

enum _ResultStatusGM {
  notStarted,
  notFound,
  found,
}

enum _ResultStatusGT {
  notStarted,
  notFound,
  found,
}

class _PlantRecogniserState extends State<PlantRecogniser> {
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;

  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  _ResultStatus2 _resultStatus2 = _ResultStatus2.notStarted;

  _ResultStatusGB _resultStatusGB = _ResultStatusGB.notStarted;
  _ResultStatusGG _resultStatusGG = _ResultStatusGG.notStarted;
  _ResultStatusGP _resultStatusGP = _ResultStatusGP.notStarted;
  _ResultStatusGM _resultStatusGM = _ResultStatusGM.notStarted;
  _ResultStatusGT _resultStatusGT = _ResultStatusGT.notStarted;

  String _plantLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  // for dieseses
  String _diesesesLabel = ''; // Name of Error Message
  double _diesesesaccuracy = 0.0;

  // for bandula gemder
  String _GBLabel = ''; // Name of Error Message
  double _GBaccuracy = 0.0;

  String _GGLabel = ''; // Name of Error Message
  double _GGaccuracy = 0.0;

  String _GPLabel = ''; // Name of Error Message
  double _GPaccuracy = 0.0;

  String _GMLabel = ''; // Name of Error Message
  double _GMaccuracy = 0.0;

  String _GTLabel = ''; // Name of Error Message
  double _GTaccuracy = 0.0;

  late Classifier? _classifier;

  late Classifier? _classifier_dieseses;

  late Classifier? _classifier_GB;
  late Classifier? _classifier_GG;
  late Classifier? _classifier_GP;
  late Classifier? _classifier_GM;
  late Classifier? _classifier_GT;

  @override
  void initState() {
    super.initState();
    _loadClassifier();
    _loadClassifier_dieseses();
    _loadClassifier_GB();
    _loadClassifier_GG();
    _loadClassifier_GP();
    _loadClassifier_GM();
    _loadClassifier_GT();
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at $_labelsFileName, '
      'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier;
  }

  Future<void> _loadClassifier_dieseses() async {
    debugPrint(
      'Start loading of dieseses Classifier with '
      'labels at $_labelsFileName_dieseses, '
      'model at $_modelFileName_dieseses',
    );

    final classifier2 = await Classifier.loadWith(
      labelsFileName: _labelsFileName_dieseses,
      modelFileName: _modelFileName_dieseses,
    );
    _classifier_dieseses = classifier2;
  }

  Future<void> _loadClassifier_GB() async {
    debugPrint(
      'Start loading of bandula Classifier with '
      'labels at $_labelsFileName_gb, '
      'model at $_modelFileName_gb',
    );

    final classifier3 = await Classifier.loadWith(
      labelsFileName: _labelsFileName_gb,
      modelFileName: _modelFileName_gb,
    );
    _classifier_GB = classifier3;
  }

  Future<void> _loadClassifier_GG() async {
    debugPrint(
      'Start loading of gurami Classifier with '
      'labels at $_labelsFileName_gg, '
      'model at $_modelFileName_gg',
    );

    final classifier3 = await Classifier.loadWith(
      labelsFileName: _labelsFileName_gg,
      modelFileName: _modelFileName_gg,
    );
    _classifier_GG = classifier3;
  }

  Future<void> _loadClassifier_GP() async {
    debugPrint(
      'Start loading of pathirana Classifier with '
      'labels at $_labelsFileName_gp, '
      'model at $_modelFileName_gp',
    );

    final classifier3 = await Classifier.loadWith(
      labelsFileName: _labelsFileName_gp,
      modelFileName: _modelFileName_gp,
    );
    _classifier_GP = classifier3;
  }

  Future<void> _loadClassifier_GM() async {
    debugPrint(
      'Start loading of mosquito Classifier with '
      'labels at $_labelsFileName_gm, '
      'model at $_modelFileName_gm',
    );

    final classifier3 = await Classifier.loadWith(
      labelsFileName: _labelsFileName_gm,
      modelFileName: _modelFileName_gm,
    );
    _classifier_GM = classifier3;
  }

  Future<void> _loadClassifier_GT() async {
    debugPrint(
      'Start loading of tilapi Classifier with '
      'labels at $_labelsFileName_gt, '
      'model at $_modelFileName_gt',
    );

    final classifier3 = await Classifier.loadWith(
      labelsFileName: _labelsFileName_gt,
      modelFileName: _modelFileName_gt,
    );
    _classifier_GT = classifier3;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromARGB(255, 230, 245, 255),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.white12,
            automaticallyImplyLeading: false,
            actions: [],
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 14),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: _buildTitle(),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              expandedTitleScale: 1.0,
            ),
            elevation: 0,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x2B202529),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: _buildPhotolView(),
                        )
                      ],
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        _buildResultView(),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 230, 245, 255),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20), // set the margin value here
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildPickPhotoButton(
                                title: 'Camera',
                                source: ImageSource.camera,
                                icon: Icons.camera_alt,
                              ),
                              const SizedBox(width: 20),
                              _buildPickPhotoButton(
                                title: 'Gallery',
                                source: ImageSource.gallery,
                                icon: Icons.collections,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   color: Colors.white,
    //   width: 400,
    //   child: Column(
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       const Spacer(),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 30),
    //         child: _buildTitle(),
    //       ),
    //       const SizedBox(height: 80),
    //       _buildPhotolView(),
    //       const SizedBox(height: 20),
    //       _buildResultView(),
    //       const Spacer(flex: 5),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           _buildPickPhotoButton(
    //             title: 'Camera',
    //             source: ImageSource.camera,
    //             icon: Icons.camera_alt,
    //           ),
    //           const SizedBox(width: 20),
    //           _buildPickPhotoButton(
    //             title: 'Gallery',
    //             source: ImageSource.gallery,
    //             icon: Icons.collections,
    //           ),
    //         ],
    //       ),
    //       const Spacer(),
    //     ],
    //   ),
    // );
  }

  Widget _buildPhotolView() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        PlantPhotoView(file: _selectedImageFile),
        _buildAnalyzingText(),
      ],
    );
  }

  Widget _buildAnalyzingText() {
    if (!_isAnalyzing) {
      return const SizedBox.shrink();
    }
    return const Text('Analyzing...', style: kAnalyzingTextStyle);
  }

  Widget _buildTitle() {
    return const Text(
      'Fish Recogniser',
      style: kTitleTextStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPickPhotoButton({
    required ImageSource source,
    required String title,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      color: kColorBrown,
      child: TextButton(
        onPressed: () => _onPickPhoto(source),
        child: Container(
          width: 120,
          // height: 30,
          color: kColorBrown,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: kColorLightYellow,
                  size: 20,
                ),
                SizedBox(width: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: kButtonFont,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: kColorLightYellow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  void _onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
    });

    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) {
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier!.predict(imageInput);

    final resultCategory2 = _classifier_dieseses!.predict(imageInput);

    final resultCategoryGB = _classifier_GB!.predict(imageInput);
    final resultCategoryGG = _classifier_GG!.predict(imageInput);
    final resultCategoryGP = _classifier_GP!.predict(imageInput);
    final resultCategoryGM = _classifier_GM!.predict(imageInput);
    final resultCategoryGT = _classifier_GT!.predict(imageInput);

    final result = resultCategory.score >= 0.8
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final plantLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    // for dieseses
    final result_dieseses = resultCategory2.score >= 0.8
        ? _ResultStatus2.found
        : _ResultStatus2.notFound;
    final dieseses_Label = resultCategory2.label;
    final dieseses_accuracy = resultCategory2.score;

    // for Bandula gender
    final result_gb = resultCategoryGB.score >= 0.8
        ? _ResultStatusGB.found
        : _ResultStatusGB.notFound;
    final gb_Label = resultCategoryGB.label;
    final gb_accuracy = resultCategoryGB.score;

    // for gurami gender
    final result_gg = resultCategoryGG.score >= 0.8
        ? _ResultStatusGG.found
        : _ResultStatusGG.notFound;
    final gg_Label = resultCategoryGG.label;
    final gg_accuracy = resultCategoryGG.score;

    // for pathirana gender
    final result_gp = resultCategoryGP.score >= 0.8
        ? _ResultStatusGP.found
        : _ResultStatusGP.notFound;
    final gp_Label = resultCategoryGP.label;
    final gp_accuracy = resultCategoryGP.score;

    // for Bandula gender
    final result_gm = resultCategoryGM.score >= 0.8
        ? _ResultStatusGM.found
        : _ResultStatusGM.notFound;
    final gm_Label = resultCategoryGM.label;
    final gm_accuracy = resultCategoryGM.score;

    // for tilapiya gender
    final result_gt = resultCategoryGT.score >= 0.8
        ? _ResultStatusGT.found
        : _ResultStatusGT.notFound;
    final gt_Label = resultCategoryGT.label;
    final gt_accuracy = resultCategoryGT.score;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      _plantLabel = plantLabel;
      _accuracy = accuracy;

      _resultStatus2 = result_dieseses;
      _diesesesLabel = dieseses_Label;
      _diesesesaccuracy = dieseses_accuracy;

      _resultStatusGB = result_gb;
      _GBLabel = gb_Label;
      _GBaccuracy = gb_accuracy;

      _resultStatusGG = result_gg;
      _GGLabel = gg_Label;
      _GGaccuracy = gg_accuracy;

      _resultStatusGP = result_gp;
      _GPLabel = gp_Label;
      _GPaccuracy = gp_accuracy;

      _resultStatusGM = result_gm;
      _GMLabel = gm_Label;
      _GMaccuracy = gm_accuracy;

      _resultStatusGT = result_gt;
      _GTLabel = gt_Label;
      _GTaccuracy = gt_accuracy;
    });
  }

  Widget _buildResultView() {
    var title = '';
    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Healthy';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _plantLabel;
    } else {
      title = '';
    }

    var Harmful = '';
    if (title == '') {
      Harmful = '';
    } else if (title == 'Catfish' ||
        title == 'Snakehead' ||
        title == 'Thilapia') {
      Harmful = 'yes';
    } else {
      Harmful = 'No';
    }

    var gender = '';
    if (title == '') {
      gender = '';
    } else if (title == 'Bandula Pethiya') {
      print('this is bandula');
      gender = _GBLabel;
    } else if (title == 'Gourami') {
      print('this is Gourami');
      gender = _GBLabel;
    } else if (title == 'Mosqito Fish') {
      print('this is Mosqito');
      gender = _GBLabel;
    } else if (title == 'Pathirana Salaya') {
      print('this is Pathirana');
      gender = _GBLabel;
    } else if (title == 'Thilapia') {
      print('this is Thilapia');
      gender = _GBLabel;
    } else {
      gender = 'male';
      print('else part');
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }

    var dieseses = '';
    if (_resultStatus2 == _ResultStatus2.notFound) {
      dieseses = 'Fail to recognise any dieseses';
    } else if (_resultStatus2 == _ResultStatus2.found) {
      dieseses = _diesesesLabel;
    } else {
      dieseses = '';
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 245, 255),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                child: Icon(
                                  Icons.category,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 15, 0, 0),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Endemic Species:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.4),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                        letterSpacing: 0.4,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 245, 255),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                child: Icon(
                                  Icons.coronavirus,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 15, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Dieseses:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.4),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    dieseses,
                                    style: TextStyle(
                                      letterSpacing: 0.4,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 245, 255),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                child: Icon(
                                  Icons.gpp_maybe_sharp,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 15, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Harmful:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.4),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    Harmful,
                                    style: TextStyle(
                                      letterSpacing: 0.4,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 245, 255),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                child: Icon(
                                  Icons.face,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                              width: 4,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 15, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Gender:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    gender,
                                    style: TextStyle(
                                      letterSpacing: 0.4,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
