package buttons{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import buttons.*;
	public class ExtendedButton extends buttons.MainButton {
		protected override function doClick(e:MouseEvent):void {
			trace("clickClack");
		}
	}
}