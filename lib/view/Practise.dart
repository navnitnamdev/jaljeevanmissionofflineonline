/* Visibility(
                  visible: isGetGeoLocatonESR,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: double.infinity,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        border: Border.all(
                          color: Appcolor.lightgrey,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ), //                 <--- border radius here
                        ),
                      ),
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add New location of water source esr',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 190,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black54),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Habitation',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: DropdownButton(
                                      // Initial Value
                                      isExpanded: true,
                                      value: dropdownvalue3,
                                      isDense: true,
                                      hint: const Text(
                                        '--Select Scheme--',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      dropdownColor: Colors.white,
                                      //drop down view
                                      underline: const SizedBox(),
                                      // Down Arrow Icon
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      // Array list of items
                                      items: items3.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue3 = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Source Location/landmark',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                                fillColor: Colors.grey.shade100,
                                                filled: true,
                                                // prefixIcon: Icon(Icons.settings,
                                                //   color: Colors.black,),
                                                hintText:
                                                    "Enter Source Location/landmark",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                )),
                                          ),
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
                  ),
                ),*/



//////////////////////

/////// sib camera -----------

/* Visibility(
                  visible: SelectalreadytaggedsourceSIB,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: double.infinity,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        border: Border.all(
                          color: Appcolor.lightgrey,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ), //                 <--- border radius here
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 200,
                              width: 400,
                              padding: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                children: [
                                  imgFile != null
                                      ? Image.file(imgFile!,
                                          width: 500, height: 120)
                                      : InkWell(
                                          onTap: () {},
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.asset(
                                                'images/camera.png',
                                                width: 100.0,
                                                height: 100.0),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Center(
                                    child: Container(
                                      height: 40,
                                      width: 200,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0D3A98),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 50),
                                                  child: AlertDialog(
                                                    title: const Text(
                                                      'Please Take Photo',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    actions: [
                                                      Container(
                                                        height: 35,
                                                        width: 100,
                                                        color:
                                                            Appcolor.btncolor,
                                                        child: TextButton(
                                                            onPressed: () {
                                                              openCamera();
                                                            },
                                                            child: const Text(
                                                              'CAMERA',
                                                              style: TextStyle(
                                                                  color: Appcolor
                                                                      .white),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: const Text(
                                          'Take Photo SIB ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 20),
                              height: 40,
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF0D3A98),
                                  borderRadius: BorderRadius.circular(8)),
                              child: TextButton(
                                onPressed: () {
                                  Get.back();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Saved Successfully"),
                                  ));
                                },
                                child: const Text(
                                  'Save ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/