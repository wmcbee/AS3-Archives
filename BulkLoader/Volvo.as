package{
    import br.com.stimuli.loading.BulkLoader;
    import br.com.stimuli.loading.BulkProgressEvent;
    
	import flash.events.*;
    import flash.display.*;
    import flash.media.*;
    import flash.net.*;
	import flash.utils.*;

    public class Volvo extends MovieClip{
        public var loader : BulkLoader;
        public var v:Video;
		public var s:Sprite; 
        public var counter : int = 0;
		
		public var items:Array=["assets/1.swf","assets/2.swf","assets/3.swf","assets/4.swf"];

        public function Volvo() {
            // creates a BulkLoader instance with a name of "main", that can be used to retrieve items without having a reference to this instance
            loader = new BulkLoader("main");
            // set level to verbose, for debugging only
            loader.logLevel = BulkLoader.LOG_INFO;
						
			for(var i:int; i<items.length; i++) loader.add(items[i], {"id":"swf_"+i});

			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.start();

			function onLoadComplete($e:Event):void{
                for(var i:int; i<items.length; i++) loader.getMovieClip("swf_"+i).gotoAndStop(1);
                setTimeout(begin, 3000);
				return;
				}

			function begin():void{
                for(var i:int; i<items.length; i++) loader.getMovieClip("swf_"+i).play();
				}

            // dispatched when ALL the items have been loaded:
            loader.addEventListener(BulkLoader.COMPLETE, onAllItemsLoaded);
            
            // dispatched when any item has progress:
            loader.addEventListener(BulkLoader.PROGRESS, onAllItemsProgress);
            
            // now start the loading
            loader.start();
        }
        
        public function onAllItemsLoaded(evt:Event):void{
            trace("It's all loaded... now run and play!");
            // attach the vídeo:
            //var video : Video = new Video();
            // get the nestream from the bulkloader:
            //var theNetStream : NetStream = loader.getNetStream("the-video");
            //addChild(video);
            //video.attachNetStream(theNetStream);
            //theNetStream.resume();
            //video.y = 300;
            
			// the damn swf movies
            var movies:Sprite = new Sprite();
			addChild(movies);
			movies.y = 0;
        }

        public function onAllItemsProgress(evt:BulkProgressEvent):void{
            trace(evt.loadingStatus());
			trace(items+" happy ending");
        }
    }
}