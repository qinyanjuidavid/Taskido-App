
            
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 7, right: 7, top: 5),
                child: Consumer<TaskService>(
                  builder: (context, value, child) {
                    if (value.categoryLoading == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      controller: value.scrollController,
                      itemCount: value.categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        var clr = value.categories[index].color.toString();
                        var categoryColor = Color(
                            int.parse(clr.substring(1, 7), radix: 16) +
                                0xFF000000);

                        return InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: categoryColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 20,
                              bottom: 12,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        value.categories[index].category
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "2 weeks ago",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // at the bottom of the container
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        //number of tasks completed of all eg 2 of 5
                                        Row(
                                          children: const [
                                            Text(
                                              "3",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              " of ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "4",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // at the end of the row
                                        const Spacer(),
                                        // normal circular progress indicator
                                        const CircularProgressIndicator(
                                          value: 0.45,
                                          backgroundColor: Colors.white70,
                                          strokeWidth: 5,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
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
                      },
                    );
                  },
                ),
              ),
            ),