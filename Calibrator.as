﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent
	import flash.events.Event;
	
	
	public class Calibrator extends MovieClip {
		
		private var coordId:int;
		private var loader:GameLoader;
		private var hotkey:String;
		
		public function Calibrator(id:int, loader:GameLoader, hotkey:String="") {
			this.coordId = id;
			this.loader = loader;
			this.gotoAndStop(1);
			this.hotkey = hotkey;
			this.coordTxt.text = hotkey;
		}
		
		public function activate():void{
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
		}
		
		public function deactivate():void{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
		}
		
		public function actuate(){
			this.gotoAndStop(5);
		}
		
		public function deactuate(){
			this.gotoAndStop(1);
		}
		
		public function onMouseDown(e:MouseEvent) : void {
			this.startDrag();
			this.addEventListener(Event.ENTER_FRAME, this.updateCoord);
		}

		
		public function onMouseUp(e:MouseEvent) : void {
			this.stopDrag();			
			this.removeEventListener(Event.ENTER_FRAME, this.updateCoord);
			this.coordTxt.text = this.hotkey;
			this.loader.baobabPositions[this.coordId] = new Coordinate(this.x, this.y);
			this.loader.loadZBuffer();
			this.loader.handler.updateBaobabPositions();
		}
		
		public function updateCoord(e:Event):void{
			this.coordTxt.text = this.x.toString()+";"+this.y.toString();			
		}
		
	}
	
}
