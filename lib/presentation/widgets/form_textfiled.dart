import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/imports.dart';

class FormTextfiledWidget extends StatelessWidget {
  FormTextfiledWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.isMaxLine = false,
    this.isPrefix = false,
    this.prefix = const SizedBox(),
    this.isMaxLength = false,
    this.isKeyboardNumber = false,
    this.isSuffix = false,
    this.suffix = const SizedBox(),
    this.isobsecure = false,
    this.isDarkMode = false,
  });

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool isMaxLine;
  final bool isPrefix;
  final Widget prefix;
  final bool isMaxLength;
  final isKeyboardNumber;
  final bool isSuffix;
  final bool isobsecure;
  final Widget suffix;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: labelText,
          fontFamily: FontFamily.calSans,
          fontWeight: FontWeight.w400,
        ),

        SizedBox(height: 5),
        TextFormField(
          obscureText: isobsecure,
          keyboardType:
              isKeyboardNumber ? TextInputType.number : TextInputType.name,
          maxLines: isMaxLine ? 5 : 1,
          maxLength: isMaxLength ? 10 : null,

          controller: controller,
          decoration: InputDecoration(
            counterText: "",
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 12,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            prefixIcon:
                isPrefix
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          prefix,
                          const SizedBox(
                            width: 8,
                          ), // Space between prefix and hintText
                        ],
                      ),
                    )
                    : null,
            suffixIcon:
                isSuffix
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          suffix,
                          const SizedBox(
                            width: 8,
                          ), // Space between prefix and hintText
                        ],
                      ),
                    )
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.darkerGreyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.darkerGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkerGreyColor),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.redColor),
              borderRadius: BorderRadius.circular(10),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkerGreyColor),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,

            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(),
          ),
        ),
      ],
    );
  }
}
