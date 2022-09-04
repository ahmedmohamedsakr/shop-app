import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/global/global_widget/global_widget.dart';
import 'package:shop_app/domain/entities/categories/categories_data_data.dart';
import 'package:shop_app/presentation/controllers/home_cubit/home_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildCatItems(cubit.categories!.data!.data![index]),
          separatorBuilder: (context, index) => const SizedBox(
            height: 20.0,
          ),
          itemCount: cubit.categories!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCatItems(CategoriesDataData model) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // Image(
              //   image: NetworkImage('${model.image}'),
              //   width: 90.0,
              //   height: 90.0,
              // ),
              buildCachedNetworkImage(imageUrl: model.image!,width: 90.0,height: 90.0),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                '${model.name}',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
