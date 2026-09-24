import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../theme/study_buddy_theme.dart';
import '../../widgets/cute_illustration.dart';
import '../../widgets/task_tile.dart';
import '../../widgets/whimsical_background.dart';
import '../../widgets/whimsical_card.dart';
import '../subjects/subjects_screen.dart';
import '../tasks/add_task_screen.dart';
import '../tasks/tasks_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirestoreService();
    return Scaffold(
      body: WhimsicalBackground(
        child: SafeArea(
          child: StreamBuilder<List<StudyTask>>(
            stream: db.watchTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return const _ErrorCard();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: StudyBuddyColors.rose));
              }

              final tasks = snapshot.data ?? <StudyTask>[];
              final completed = tasks.where((t) => t.completed).length;
              final total = tasks.length;
              final progress = total == 0 ? 0.0 : completed / total;

              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 7, 16, 34),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: const _BrandTitle(),
                      ),
                      IconButton(
                        tooltip: 'Sign out',
                        icon: const Icon(Icons.logout_rounded, size: 27),
                        color: StudyBuddyColors.deepRose,
                        onPressed: () async => AuthService().signOut(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _BrushHeading('Welcome back!'),
                            const SizedBox(height: 2),
                            const Text('Let’s make today a productive study day.'),
                          ],
                        ),
                      ),
                      const StudyBunny(size: 103),
                    ],
                  ),
                  const SizedBox(height: 12),
                  WhimsicalCard(
                    tape: true,
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
                    child: _ProgressContent(progress: progress, completed: completed, total: total),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _QuickAction(icon: Icons.add_task_rounded, label: 'Add task', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskScreen())))),
                      const SizedBox(width: 10),
                      Expanded(child: _QuickAction(icon: Icons.checklist_rounded, label: 'View tasks', color: StudyBuddyColors.paleButter, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TasksScreen())))),
                      const SizedBox(width: 10),
                      Expanded(child: _QuickAction(icon: Icons.menu_book_rounded, label: 'Subjects', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubjectsScreen())))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: const [
                      HandDrawnLabel('Your tasks'),
                      SizedBox(width: 8),
                      Text('✦  ♡', style: TextStyle(color: StudyBuddyColors.rose, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (tasks.isEmpty)
                    const WhimsicalCard(child: Text('No pending tasks. Add your first study goal! 🌷'))
                  else
                    ...tasks.take(5).map((task) => Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: TaskTile(task: task),
                        )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProgressContent extends StatelessWidget {
  const _ProgressContent({required this.progress, required this.completed, required this.total});
  final double progress;
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Today’s progress', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 25)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: StudyBuddyColors.paperPink,
                border: Border.all(color: StudyBuddyColors.blush, width: 1.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('$completed / $total', style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
        const SizedBox(height: 13),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 11,
            backgroundColor: StudyBuddyColors.paleButter,
            color: StudyBuddyColors.sage,
          ),
        ),
        const SizedBox(height: 9),
        Text(total == 0 ? '0% complete' : '${(progress * 100).round()}% complete'),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap, this.color = StudyBuddyColors.paper});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: WhimsicalCard(
          color: color,
          padding: const EdgeInsets.fromLTRB(7, 13, 7, 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: StudyBuddyColors.deepRose),
              const SizedBox(height: 6),
              Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(label == 'Add task' ? '♡' : label == 'View tasks' ? '✦' : '♡', style: const TextStyle(color: StudyBuddyColors.rose, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard();
  @override
  Widget build(BuildContext context) => const Center(child: Padding(padding: EdgeInsets.all(24), child: WhimsicalCard(child: Text('Something went wrong. Please try again.'))));
}

class _BrandTitle extends StatelessWidget {
  const _BrandTitle();
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Text('Study Buddy', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 31)),
        Positioned(
          left: 2,
          right: 0,
          bottom: -3,
          child: Container(height: 3, decoration: BoxDecoration(color: StudyBuddyColors.butter, borderRadius: BorderRadius.circular(9))),
        ),
      ],
    );
  }
}

class _BrushHeading extends StatelessWidget {
  const _BrushHeading(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BrushPainter(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
        child: Text(text, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 36)),
      ),
    );
  }
}

class _BrushPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = StudyBuddyColors.blush.withValues(alpha: .48);
    final path = Path()
      ..moveTo(3, size.height * .30)
      ..quadraticBezierTo(size.width * .18, 0, size.width * .40, size.height * .22)
      ..quadraticBezierTo(size.width * .70, 0, size.width - 4, size.height * .25)
      ..lineTo(size.width - 7, size.height * .78)
      ..quadraticBezierTo(size.width * .65, size.height, size.width * .42, size.height * .78)
      ..quadraticBezierTo(size.width * .16, size.height, 5, size.height * .72)
      ..close();
    canvas.drawPath(path, p);
  }
  @override
  bool shouldRepaint(covariant _BrushPainter oldDelegate) => false;
}
