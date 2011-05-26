package hints 
{
	/**
	 * 数字同士を加算し、ヒントとして利用します。
	 * @author Seacolor
	 */
	public class AddingHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function AddingHint(correct_number:Vector.<int>) 
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
		 * 数字の加算結果でヒントを生成します。
		 */
		override protected function createHints():void 
		{
			for (var i:int = 0; i < correct_number.length; i++) {
				for (var j:int = i + 1; j < correct_number.length; j++) {
					hint_list.push((i + 1) + " 番目と " + (j + 1) + " 番目を足すと " + (correct_number[i] + correct_number[j]));
				}
			}
		}
		
	}

}