import 'package:dart_ml/src/data_splitter/k_fold.dart';
import 'package:dart_ml/src/data_splitter/leave_p_out.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart';

void main() {
  group('Splitters test:\n', () {
    KFoldSplitter kfoldSplitter;
    LeavePOutSplitter leavePOutSplitter;

    test('K fold splitter test', () {
      expect(() => new KFoldSplitter(0), throwsRangeError);
      expect(() => new KFoldSplitter(1), throwsRangeError);

      kfoldSplitter = new KFoldSplitter(5);

      expect(kfoldSplitter.split(12), equals([[0,1,2],[3,4,5],[6,7],[8,9],[10,11]]));

      kfoldSplitter = new KFoldSplitter(4);
      expect(kfoldSplitter.split(12), equals([[0,1,2],[3,4,5],[6,7,8],[9,10,11]]));

      kfoldSplitter = new KFoldSplitter(3);
      expect(kfoldSplitter.split(12), equals([[0,1,2,3],[4,5,6,7],[8,9,10,11]]));

      kfoldSplitter = new KFoldSplitter(12);
      expect(kfoldSplitter.split(12), equals([[0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11]]));

      kfoldSplitter = new KFoldSplitter(5);
      expect(kfoldSplitter.split(37), equals([[0,1,2,3,4,5,6,7],[8,9,10,11,12,13,14,15],[16,17,18,19,20,21,22],
        [23,24,25,26,27,28,29],[30,31,32,33,34,35,36]]));

      kfoldSplitter = new KFoldSplitter(3);
      expect(() => kfoldSplitter.split(0), throwsRangeError);

      kfoldSplitter = new KFoldSplitter(9);
      expect(() => kfoldSplitter.split(8), throwsRangeError);
    });

    test('Leave P out splitter test... ', () {
      leavePOutSplitter = new LeavePOutSplitter(2);

      expect(leavePOutSplitter.split(4).toSet(), equals([[0,1], [0,2], [0,3], [1,2], [1,3], [2,3]].toSet()));
      expect(leavePOutSplitter.split(5).toSet(), equals([[0,1], [0,2], [0,3], [0,4], [1,2], [1,3], [1,4], [2,3], [2,4],
        [3,4]].toSet()));

      leavePOutSplitter = new LeavePOutSplitter(1);
      expect(leavePOutSplitter.split(5).toSet(), equals([[0],[1],[2],[3],[4]]));

      leavePOutSplitter = new LeavePOutSplitter(3);
      expect(leavePOutSplitter.split(4).toSet(), equals([[0,1,2], [0,1,3], [0,2,3], [1,2,3]].toSet()));
      expect(leavePOutSplitter.split(5).toSet(), equals([[0,1,2], [0,1,3], [0,1,4], [0,2,3], [0,2,4], [0,3,4], [1,2,3], [1,2,4],
        [1,3,4], [2,3,4]].toSet()));

      expect(() => leavePOutSplitter = new LeavePOutSplitter(0), throwsUnsupportedError);
    });
  });
}