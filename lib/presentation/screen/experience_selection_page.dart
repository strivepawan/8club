import 'package:flick_tv_ott/core/service_locator/service_locator.dart';
import 'package:flick_tv_ott/presentation/blocs/experience_selection/experience_selection_bloc.dart';
import 'package:flick_tv_ott/presentation/widget/experience_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExperienceSelectionPage extends StatelessWidget {
  const ExperienceSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Use service_locator (get_it) to create the BLoC
      create: (context) => sl<ExperienceSelectionBloc>()..add(FetchExperiences()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Select Experiences')),
        body: BlocBuilder<ExperienceSelectionBloc, ExperienceSelectionState>(
          builder: (context, state) {
            if (state.status == ExperienceSelectionStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ExperienceSelectionStatus.error) {
              return Center(child: Text(state.errorMessage ?? 'An error occurred'));
            }
            if (state.status == ExperienceSelectionStatus.loaded) {
              return _buildLoadedBody(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLoadedBody(BuildContext context, ExperienceSelectionState state) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // --- List of Experience Cards ---
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 0.75, // Adjust as needed
                ),
                itemCount: state.experiences.length,
                itemBuilder: (context, index) {
                  final experience = state.experiences[index];
                  final isSelected = state.selectedExperienceIds.contains(experience.id);
                  return ExperienceCard(
                    experience: experience,
                    isSelected: isSelected,
                    onTap: () {
                      context
                          .read<ExperienceSelectionBloc>()
                          .add(ToggleExperienceSelection(experience.id));
                    },
                  );
                },
              ),
              const SizedBox(height: 24),

              // --- Description Text Field ---
              TextField(
                maxLength: 250,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Why these experiences?',
                  hintText: 'Tell us more...',
                  border: OutlineInputBorder(),
                  counterText: '', // We'll build our own counter
                ),
                onChanged: (text) {
                  context
                      .read<ExperienceSelectionBloc>()
                      .add(UpdateDescription(text));
                },
              ),
              // Character counter
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${state.description.length}/250',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),

        // --- Next Button ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: (state.selectedExperienceIds.isNotEmpty && state.description.isNotEmpty)
                ? () {
                    // Log the state
                    print('Selected IDs: ${state.selectedExperienceIds}');
                    print('Description: ${state.description}');

                    // TODO: Navigate to next page
                    // Navigator.of(context).pushNamed('/onboarding-question');
                  }
                : null, // Button is disabled if no selection or description
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
}