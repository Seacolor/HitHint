package 
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIButton;
	import com.danielfreeman.madcomponents.UIInput;
	import com.danielfreeman.madcomponents.UILabel;
	import com.danielfreeman.madcomponents.UIList;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import hints.*;
	
	/**
	 * ゲーム「Hint or Hint」のメインクラスです。
	 * @author Kazushi Tominaga
	 */
	public class Main extends Sprite 
	{
		/**
		 * 正解となる数字の配列です。
		 */
		public var correct_number:Vector.<int>;
		/**
		 * 正解となる数字の桁数です。
		 * @default 3
		 */
		public var digit:int;
		/**
		 * 利用可能な低級ヒントの配列です。
		 */
		public var low_hints:Vector.<String>;
		/**
		 * 利用可能な中級ヒントの配列です。
		 */
		public var middle_hints:Vector.<String>;
		/**
		 * 利用可能な上級ヒントの配列です。
		 */
		public var top_hints:Vector.<String>;
		/**
		 * 開示されたヒントの配列です。
		 */
		public var current_hints:Array;
		/**
		 * 現在の総合得点です。
		 * @default 0
		 */
		public var score:int;
		/**
		 * 現在のターン数です。
		 * @default 1
		 */
		public var turn:int;
		/**
		 * 現在のクリア得点です。
		 * @default 1000
		 */
		public var bonus_point:Number;
		/**
		 * ヒントのクラス配列です。
		 */
		public var hint_classes:Vector.<Class> = new <Class>[
			SameHint,
			NumberExistHint,
			EvenOrOddHint,
			IncorrectNumberHint,
			MoreHint,
			LessHint,
			SumHint,
			ProductHint,
			AddingHint,
			MultiplyingHint,
			MultipleHint,
			CompareHint,
			CorrectNumberHint,
		];
		/**
		 * レイアウト定義です。
		 */
		protected static const LAYOUT:XML =
		<horizontal>
			<vertical>
				<horizontal>
					<label id="uiTurn"/>
					<label><b>Turn</b></label>
				</horizontal>
				<label id="uiMessage"/>
				<input id="uiAnswer" background="#777777,#FFFFFF"/>
				<button id="enter">Hit or Hint!</button>
				<vertical alignV="centre">
					<button id="uiRetry">Retry</button>
					<button id="uiNewGame">New game</button>
				</vertical>
				<horizontal alignV="bottom">
					<label><b>Score: </b></label>
					<label id="uiScore">0</label>
				</horizontal>
			</vertical>
			<list id="uiHints" colour="#FFFFFF" background="#777777,#FFFFFF">
				<label id="label"/>
			</list>
		</horizontal>
		
		/**
		 * 画面に表示されるメッセージ
		 */
		protected var uiMessage:UILabel;
		/**
		 * 画面に表示されるヒント
		 */
		protected var uiHints:UIList;
		/**
		 * 画面に表示される解答入力欄
		 */
		protected var uiAnswer:UIInput;
		/**
		 * 画面に表示される総合得点
		 */
		protected var uiScore:UILabel;
		/**
		 * 画面に表示されるターン数
		 */
		protected var uiTurn:UILabel;
		/**
		 * 画面に表示される正解判定ボタン
		 */
		protected var uiEnter:UIButton;
		/**
		 * 画面に表示されるリセットボタン
		 */
		protected var uiRetry:UIButton;
		/**
		 * 画面に表示されるリスタートボタン
		 */
		protected var uiNewGame:UIButton;
		
		/**
		 * ガウス分布の平均です。
		 */
		protected static const STDEVP:Number = 0.4;
		/**
		 * ガウス分布の標準偏差です。
		 */
		protected static const SIGMA:Number = 0.2;
		
		/**
		 * コンストラクタです。
		 * 定義に基いてユーザーインターフェイスを生成し、画面と状態を初期化します。
		 */
		public function Main():void 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			UI.create(this, LAYOUT);
			
			initilaze();
			
			events();
		}
		/**
		 * 画面と状態を初期化します。
		 * @param	event	タップイベントです。
		 */
		protected function initilaze(event:Event = null):void {
			score = 0;
			turn = 0;
			digit = 3;
			
			reset();
		}
		/**
		 * 画面と一部の状態を初期化します。
		 * @param	event	タップイベントです。
		 */
		protected function reset(event:Event = null):void {
			correct_number = createNumber();
			
			createUsableHints();
			
			current_hints = [];
			
			turn++;
			
			bonus_point = 1000;
			
			uiMessage = UILabel(UI.findViewById("uiMessage"));
			uiMessage.text = digit + ' digit number to';
			uiAnswer = UIInput(UI.findViewById("uiAnswer"));
			uiAnswer.text = '000';
			uiHints = UIList(UI.findViewById("uiHints"));
			uiScore = UILabel(UI.findViewById("uiScore"));
			uiScore.text = score.toString();
			uiTurn = UILabel(UI.findViewById("uiTurn"));
			uiTurn.text = turn.toString();
			uiEnter = UIButton(UI.findViewById("enter"));
			uiEnter.mouseEnabled = true;
			uiEnter.mouseChildren = true;
			uiRetry = UIButton(UI.findViewById("uiRetry"));
			uiNewGame = UIButton(UI.findViewById("uiNewGame"));
			
			pushHint();
		}
		/**
		 * 定義に基いて数字を生成します。
		 * @return	定義された桁数の0-9までの数字
		 */
		protected function createNumber():Vector.<int> {
			var values:Vector.<int> = new Vector.<int>(digit, true);
			for (var i:int = 0; i < digit;i++) {
				values[i] = int(Math.random() * 10);
			}
			return values;
		}
		
		/**
		 * 利用可能なヒントを生成します。
		 */
		protected function createUsableHints():void {
			// ヒント配列を初期化
			low_hints = new Vector.<String>();
			middle_hints = new Vector.<String>();
			top_hints = new Vector.<String>();
			// ヒントを生成し、ヒント配列に追加
			for each (var hint_class:Class in hint_classes) {
				var hint:HintTemplate = new hint_class(correct_number);
				switch (hint.hintLevel) {
					case HintLevel.TOP:
						top_hints = top_hints.concat(hint.getHints());
						break;
					case HintLevel.MIDDLE:
						middle_hints = middle_hints.concat(hint.getHints());
						break;
					case HintLevel.LOW:
						low_hints = low_hints.concat(hint.getHints());
						break;
					default:
						throw new Error("ヒントレベルが正しくありません。");
				}
			}
			// ヒント配列の中身をシャッフル
			low_hints.sort(function():int { return int(Math.random() * 3) - 1 } );
			middle_hints.sort(function():int { return int(Math.random() * 3) - 1 } );
			top_hints.sort(function():int { return int(Math.random() * 3) - 1 } );
		}
		
		/**
		 * イベントを登録します。
		 */
		protected function events():void {
			CONFIG::debug {
				uiEnter.addEventListener(MouseEvent.CLICK, check);
				uiRetry.addEventListener(MouseEvent.CLICK, reset);
				uiNewGame.addEventListener(MouseEvent.CLICK, initilaze);
			}
			CONFIG::release {
				uiEnter.addEventListener(TouchEvent.TOUCH_TAP, check);
				uiRetry.addEventListener(TouchEvent.TOUCH_TAP, reset);
				uiNewGame.addEventListener(TouchEvent.TOUCH_TAP, initilaze);
			}
		}
		/**
		 * 利用可能なヒントをシフトし、開示します。
		 * シフトされるヒントは低級、中級、上級の中からガウス分布によって選ばれます。
		 * 開示されているヒントの数が多いほど平均に補正が係り、より上級のヒントが選ばれやすくなります。
		 * @param	e	タッチイベントです。
		 */
		public function pushHint(e:Event = null):void 
		{
			var num:int = Math.min(9, int(nextGaussian(STDEVP + (current_hints.length * 0.025)) * 10));
			shiftUsableHint(num);
			uiHints.data = current_hints;
			
			if (current_hints.length > 1) bonus_point *= 0.9;
		}
		/**
		 * 利用可能なヒントの配列の中からヒントをシフトし、開示します。
		 * @param	num	ヒントの選定の為に判定される乱数値です。
		 */
		protected function shiftUsableHint(num:int):void {
			if (!top_hints.length && !middle_hints.length && !low_hints.length) return;
			
			switch(num) {
				case 9:
				case 8:
					if (top_hints.length > 0) {
						current_hints.unshift( formatHint(top_hints.shift()) );
						break;
					}
				case 7:
				case 6:
				case 5:
				case 4:
					if (middle_hints.length > 0) {
						current_hints.unshift( formatHint(middle_hints.shift()) );
						break;
					}
				case 3:
				case 2:
				case 1:
				case 0:
					if (low_hints.length > 0) {
						current_hints.unshift( formatHint(low_hints.shift()) );
						break;
					}
				default:
					shiftUsableHint(num + 1);
			}
		}
		/**
		 * ガウス分布に基いて乱数を生成し、返却します。
		 * @param	stdevp	平均です。
		 * @param	sigma	標準偏差です。
		 * @return	ガウス分布に基いて生成された乱数です。
		 */
		protected function nextGaussian(stdevp:Number = STDEVP, sigma:Number = SIGMA):Number {
			var r:Number;
			do {
				r = Math.random();
			} while (1.0 / Math.sqrt(2 * Math.PI * sigma) * Math.exp( -Math.pow(r - stdevp, 2) / 2.0 / Math.pow(sigma, 2)) < Math.random());
			
			return r;
		}
		/**
		 * ヒントを表示用に整形します。
		 * @param	element	ヒントです。
		 * @return	表示用に整形されたヒントです。
		 */
		protected function formatHint(element:*):Object {
			return { label: '<font size="10">' + element + '</font>' };
		}
		/**
		 * 正解判定を行います。
		 * 正解の場合はメッセージを表示してゲームを停止し、不正解の場合はメッセージを表示してヒントをさらに開示します。
		 * @param	e	タッチイベントです。
		 */
		protected function check(e:Event = null):void 
		{
			if (trim(uiAnswer.text) == correct_number.join("")) {
				uiMessage.text = "正解！";
				finish();
			} else {
				uiMessage.text = "違います";
				pushHint();
			}
		}
		/**
		 * 文字列の前後の空白を取り除きます。
		 * @param	s	対象となる文字列です。
		 * @return	前後の空白が取り除かれた新しい文字列です。
		 */
		protected function trim(s:String):String {
			// 左側の空白文字を判定
			var i:int = 0;
			while (s.charCodeAt(i) < 33) i++;
			// 右側の空白文字を判定
			var j:int = s.length - 1;
			while (s.charCodeAt(j) < 33) j--;
			// 左右の空白文字を除外した文字列を返却
			return s.substring(i, j + 1);
		}
		/**
		 * ゲームの停止処理です。
		 * 一部操作を無効化し、総合得点にクリア得点を加算します。
		 * @param	e	タッチイベントです。
		 */
		protected function finish(e:Event = null):void {
			uiEnter.mouseEnabled = false;
			uiEnter.mouseChildren = false;
			
			score += int(bonus_point);
			uiScore.text = score.toString();
		}
		
	}
	
}