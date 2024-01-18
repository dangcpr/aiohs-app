import 'history_job_posting.dart';

class PostResult {
  final List<HistoryJobPosting> posts;
  final String next;

  PostResult(this.posts, this.next);
}
