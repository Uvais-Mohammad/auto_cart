import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int activeStep = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EasyStepper(
            activeStep: activeStep,
            lineStyle: const LineStyle(
              lineLength: 120,
              lineType: LineType.normal,
              activeLineColor: Colors.red,
              defaultLineColor: Colors.red,
            ),

            activeStepIconColor: Colors.red,
            unreachedStepIconColor: Colors.red,
            activeStepBackgroundColor: Colors.red,
            finishedStepBackgroundColor: Colors.red,

            // lineLength: 70,
            // lineSpace: 0,
            // lineType: LineType.normal,
            // defaultLineColor: Colors.white,
            // finishedLineColor: Colors.orange,
            activeStepTextColor: Colors.black87,
            finishedStepTextColor: Colors.black87,
            internalPadding: 0,
            showLoadingAnimation: false,
            stepRadius: 8,
            showStepBorder: false,
            steps: const [
              EasyStep(
                customStep: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              ),
              EasyStep(
                customStep: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              ),
              EasyStep(
                customStep: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Choose Payment Method',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
                children: ['Cash on Delivery', 'Online Payment']
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: RadioListTile(
                          title: Text(e),
                          tileColor: Colors.white,
                          value: e,
                          controlAffinity: ListTileControlAffinity.trailing,
                          groupValue: 'Cash on Delivery',
                          onChanged: (value) {},
                        ),
                      ),
                    )
                    .toList()),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: const Text('Place Order'),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
