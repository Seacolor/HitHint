package resources 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.Capabilities;
	
	/**
	 * アプリケーションで利用されるリソースの管理を担当するクラスです。
	 * 全てのリソールファイルのアクセスは、このクラスを介して行われます。
	 * @author Seacolor
	 */
	public class ResourceManager
	{
		/**
		 * レイアウト定義です。
		 */
		public function get layout():XML {
			return resource.layout;
		}
		/**
		 * 確認画面のレイアウト定義です。
		 */
		public function get layout_confirm():XML {
			return resource.layout_confirm;
		}
		/**
		 * 警告画面のレイアウト定義です。
		 */
		public function get layout_alert():XML {
			return resource.layout_alert;
		}
		/**
		 * 表示されるメッセージの定義です。
		 */
		public function get messages():XML {
			return resource.messages;
		}
		/**
		 * 表示に使用される言語です。
		 * @default en
		 */
		public function get language():String 
		{
			return _language;
		}
		
		/**
		 * リソース
		 */
		protected static var resource:Resource = new Resource();
		/**
		 * 表示言語
		 */
		protected static var _language:String = "en";
		
		/**
		 * コンストラクタです。
		 * 外部から呼び出した場合、エラーになります。
		 * @see #instance
		 */
		public function ResourceManager(internal:Internal) 
		{
			if (!internal) throw new Error("ModelLocator は Singleton です。getInstance() を使ってインスタンス化してください。");
			
			switch (Capabilities.language) {
				case "ja":
					_language = Capabilities.language;
					break;
			}
			
			loadFile(_language, "layout");
			loadFile(_language, "layout_confirm");
			loadFile(_language, "layout_alert");
			loadFile(_language, "messages");
		}
		
		/**
		 * インスタンスです。
		 */
        public static function get instance():ResourceManager {
            return Internal.instance;
        }
		
		/**
		 * リソースファイルの読み取りを実行します。
		 * @param	language	言語
		 * @param	name	リソースの名前
		 */
		protected function loadFile(language:String, name:String):void {
			var layoutFile:File = File.applicationDirectory.resolvePath(language + '/' + name + '.xml');
			var layoutLoader:FileStream = new FileStream();
			
			layoutLoader.open(layoutFile, FileMode.READ);
			resource[name] = new XML(layoutLoader.readUTFBytes(layoutLoader.bytesAvailable));
		}
		
	}

}
import resources.ResourceManager;
class Internal {
    public static var instance:ResourceManager
        = new ResourceManager(new Internal());
    public function Internal(){}
}