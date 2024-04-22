import 'package:client_app/expert_system_Provider.dart';
import 'package:client_app/models/answer_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainView extends HookConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(expertSystemControllerProvider).questions;
    final results = ref.watch(expertSystemControllerProvider).symptoms;
    final questionIndex =
        ref.watch(expertSystemControllerProvider).questionIndex;
    final expertSystemController =
        ref.read(expertSystemControllerProvider.notifier);
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.grey.withOpacity(0.7), BlendMode.dstATop),

              image: const AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    results.isNotEmpty
                        ? Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text('The diagnosis is: ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const SizedBox(height: 20),
                              ...results.map((e) => Text(e.diagnosisName,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),

                              // button to reset the app
                              const SizedBox(height: 50),

                              // the solution to the diagnosis
                              const Align(
                                alignment: Alignment.center,
                                child: Text('Solution is: ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),

                              const SizedBox(height: 20),

                              Container(
                                height: 200,
                                width: 200,
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(results[0].solutions,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ),

                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {
                                    expertSystemController.reset();
                                  },
                                  child: const Text('Reset The Diagnosis',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ),
                              ),
                            ],
                          )
                        : questions.when(
                            data: (data) {
                              if (questionIndex >= data.length) {
                                // submit button to see the result
                                return Column(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        expertSystemController.submitAnswers();
                                      },
                                      icon: const Icon(Icons.send),
                                      label: const Text('Submit'),
                                    ),

                                    const SizedBox(height: 20),

                                    // reset button to start over
                                    ElevatedButton(
                                      onPressed: () {
                                        expertSystemController.reset();
                                      },
                                      child: const Text('Reset'),
                                    ),
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  Text(
                                    'Please answer the following question',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(data[questionIndex].question,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                            
                                      ElevatedButton(
                                        onPressed: () {
                                          expertSystemController.addAnswer(
                                              AnswerModel(
                                                  symptom: data[questionIndex]
                                                      .symptom));
                                          expertSystemController.nextQuestion();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.green,
                                        ),
                                        child: const Text('Yes'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          expertSystemController.nextQuestion();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text('No'),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            loading: () => const CircularProgressIndicator(),
                            error: (error, _) => Text('Error: $error'),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
