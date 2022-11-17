Stack(
                  children: [
                    Material(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "My profile",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Material(
                        child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: Color.fromARGB(255, 20, 106, 218),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  thickness: 3,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.grey[300],
                ),
                const SizedBox(
                  height: 20,
                ),