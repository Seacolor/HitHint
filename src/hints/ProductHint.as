package hints 
{
	[ja("全ての数字の積は {0}")]
	[en("product is {0}.")]
	/**
	 * 数字の積を求め、ヒントとして利用します。
	 * @author Seacolor
	 */
	public class ProductHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function ProductHint(correct_number:Vector.<int>) 
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
		 * 数字の積をヒントとして生成します。
		 */
		override protected function createHints():void 
		{
			var product:int = 1;
			
			for each (var n:int in correct_number) {
				product *= n;
			}
			
			hint_list.push(getMessage("", product));
		}
		
	}

}