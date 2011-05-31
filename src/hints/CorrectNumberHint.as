package hints 
{
	[ja("{0} 番目は {1}")]
	[en("No.{0} is {1}")]
	/**
	 * 正解となる数字をヒントとして利用します。
	 * @author Seacolor
	 */
	public class CorrectNumberHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function CorrectNumberHint(correct_number:Vector.<int>) 
		{
			super(correct_number);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get hintLevel():HintLevel 
		{
			return HintLevel.TOP;
		}
		/**
		 * 正解となる数字でヒントを生成します。
		 */
		override protected function createHints():void 
		{
			for (var i:int = 0; i < correct_number.length; i++) {
				hint_list.push(getMessage("", i + 1, correct_number[i]));
			}
		}
		
	}

}