package buttons{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class MainButton extends MovieClip {
		function MainButton() {
			this.buttonMode=true;
			this.addEventListener(MouseEvent.CLICK, this.doClick);
			this.addEventListener(MouseEvent.MOUSE_OUT, this.doOut);
			this.addEventListener(MouseEvent.MOUSE_OVER, this.doOver);
		}
		protected function doClick(e:MouseEvent):void {
			trace("clickClack");
		}
		protected function doOut(e:MouseEvent):void {
			trace('out');
			this.gotoAndPlay('out');
		}
		protected function doOver(e:MouseEvent):void {
			trace('in');
			this.gotoAndPlay('in');
		}
	}
}