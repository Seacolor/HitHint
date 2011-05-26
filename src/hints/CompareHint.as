package hints 
{
	/**
	 * 数字同士を比較し、ヒントとして利用します。
	 * @author Seacolor
	 */
	public class CompareHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function CompareHint(correct_number:Vector.<int>) 
		{
			super(correct_number);
			
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get hintLevel():HintLevel 
		{
			return HintLevel.MIDDLE;
		}
		
		/**
		 * 数字の比較結果でヒントを生成します。
		 */
		override protected function createHints():void 
		{
			for (var i:int = 0; i < correct_number.length; i++) {
				var showNumber:int = i + 1;
				for (var j:int = i + 1; j < correct_number.length; j++) {
					var showNextNumber:int = j + 1;
					// 比較と一致
					if (correct_number[i] < correct_number[j]) {
						hint_list.push(showNumber + " 番目は " + showNextNumber + " 番目より小さい");
					} else if (correct_number[i] > correct_number[j]) {
						hint_list.push(showNumber + " 番目は " + showNextNumber + " 番目より大きい");
					} else {
						hint_list.push(showNumber + " 番目と " + showNextNumber + " 番目は同じ");
					}
				}
			}
		}
		
	}

}