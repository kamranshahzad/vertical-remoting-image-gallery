package home_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import gs.*;
    import gs.easing.*;
    import ml.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var weddingContainerMC:Sprite;
        public var remoteConnectionPath:String;
        public var padding:int;
        public var pointer:Number;
        public var largeImagesPath:String;
        public var cmsArr:Array;
        public var targetThumbs:int;
        public var p:int;
        public var scrollHeading:MovieClip;
        public var startPreloaderPath:String;
        public var dontRepeat:Boolean;
        public var tid:Number;
        public var weddingBG:MovieClip;
        public var firstImage:Boolean;
        public var weddingBorder:MovieClip;
        public var siteURL:String;
        public var noRepeat:Boolean;
        public var imagesArr:Array;
        public var changey:int;
        public var mLoader:Loader;
        public var homeImageLoader:Loader;
        public var scrollPaneWidth:int;
        public var homeImagesPath:String;
        public var holder_mc:Sprite;
        public var pictureValue:int;
        public var thumbMask_mc:Sprite;
        public var child:KamMC;
        public var scrollPaneX:int;
        public var timerInterval:Object;
        public var scrollPaneY:int;
        public var isRunning:Boolean;
        public var scrollTrackHeight:int;
        public var loadBar:Sprite;
        public var weddingImageLoader:Loader;
        public var scrollPaneHeight:int;
        public var homeBG:MovieClip;
        public var scrollSpeed:int;
        public var homeContainerMC:Sprite;
        public var imagesThumbPath:String;
        public var thumbLoader:Loader;
        public var visThumbs:int;
        public var thumbTrackBg_mc:Sprite;
        public var box:MovieClip;
        public var bigHomeMC:MovieClip;
        public var soundtrackPath:String;
        public var homeBorder:MovieClip;
        public var weddingMC:MovieClip;
        public var _ptimer:PerfectTimer;

        public function MainTimeline()
        {
            addFrameScript(0, frame1, 1, frame2);
            return;
        }// end function

        public function startTIMER()
        {
            if (!isRunning)
            {
                isRunning = true;
                _ptimer = new PerfectTimer(timerInterval);
                _ptimer.timer.addEventListener(TimerEvent.TIMER, executeAndRepeat);
                _ptimer.start();
            }// end if
            return;
        }// end function

        public function cleanOutThumbs() : void
        {
            if (thumbLoader != null)
            {
                thumbLoader.contentLoaderInfo.removeEventListener(Event.INIT, thumbLoaded);
                thumbLoader.unload();
            }// end if
            if (weddingImageLoader != null)
            {
                weddingImageLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, weddingImageLoading);
                weddingImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, weddingImageLoaded);
                weddingImageLoader.unload();
            }// end if
            if (holder_mc.numChildren > 0)
            {
                while (holder_mc.numChildren > 0)
                {
                    // label
                    if (holder_mc.getChildAt(0) as MovieClip)
                    {
                        MovieClip(holder_mc.getChildAt(0)).pictureValue = null;
                        holder_mc.getChildAt(0).removeEventListener(MouseEvent.MOUSE_OVER, overThumb);
                        holder_mc.getChildAt(0).removeEventListener(MouseEvent.MOUSE_OUT, offThumb);
                    }// end if
                    holder_mc.removeChildAt(0);
                }// end while
                if (weddingContainerMC.numChildren > 0)
                {
                    while (weddingContainerMC.numChildren > 0)
                    {
                        // label
                        weddingContainerMC.removeChildAt(0);
                    }// end while
                }// end if
                p = 0;
                pictureValue = 0;
                changey = 0;
                holder_mc.removeEventListener(MouseEvent.ROLL_OVER, startScroll);
                holder_mc.removeEventListener(MouseEvent.ROLL_OUT, stopScroll);
            }// end if
            weddingBorder.visible = false;
            return;
        }// end function

        public function cleanPreloader()
        {
            if (mLoader != null)
            {
                trace("Called");
                mLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);
            }// end if
            if (box.numChildren > 0)
            {
                while (box.numChildren > 0)
                {
                    // label
                    box.removeChildAt(0);
                }// end while
            }// end if
            return;
        }// end function

        public function startWeddingPage(param1:Number)
        {
            loadWeddingImages(largeImagesPath + imagesArr[param1]);
            return;
        }// end function

        public function executeAndRepeat(param1:TimerEvent) : void
        {
            _ptimer.repeat(timerInterval);
            if (pointer < imagesArr.length)
            {
                if (tid == 1)
                {
                    startHomePage(pointer);
                }
                else
                {
                    startWeddingPage(pointer);
                }// end else if
                pointer++;
            }
            else
            {
                pointer = 0;
            }// end else if
            return;
        }// end function

        public function stopTIMER()
        {
            if (isRunning)
            {
                isRunning = false;
                _ptimer.timer.removeEventListener(TimerEvent.TIMER, executeAndRepeat);
            }// end if
            return;
        }// end function

        function frame2()
        {
            stop();
            remoteConnectionPath = "http://localhost/project/amfphp/gateway.php";
            imagesThumbPath = "http://localhost/project/uploads/images/thumbs/";
            largeImagesPath = "http://localhost/project/uploads/images/large/";
            homeImagesPath = "http://localhost/project/uploads/images/home/";
            soundtrackPath = "http://localhost/project/uploads/soundtracks/";
            cmsArr = new Array("menu.html", "about-us.html", "directions.html");
            imagesArr = new Array();
            tid = 0;
            noRepeat = false;
            scrollHeading.visible = false;
            homeBorder.visible = false;
            weddingBorder.visible = false;
            pointer = 1;
            isRunning = false;
            timerInterval = 5000;
            bigImagePreLoader();
            OverwriteManager.init();
            OverwriteManager.mode = OverwriteManager.AUTO;
            tid = 1;
            loadRemoting(tid);
            homeContainerMC = new Sprite();
            addChild(homeContainerMC);
            firstImage = false;
            dontRepeat = false;
            p = 0;
            changey = 0;
            padding = 6;
            pictureValue = 0;
            thumbLoader = new Loader();
            visThumbs = 5;
            scrollSpeed = 15;
            holder_mc = new Sprite();
            addChild(holder_mc);
            thumbMask_mc = new Sprite();
            thumbTrackBg_mc = new Sprite();
            weddingContainerMC = new Sprite();
            addChild(weddingContainerMC);
            return;
        }// end function

        public function startLoad()
        {
            var _loc_1:URLRequest;
            mLoader = new Loader();
            _loc_1 = new URLRequest(startPreloaderPath + "preloader.swf");
            mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
            mLoader.load(_loc_1);
            return;
        }// end function

        function frame1()
        {
            stop();
            startPreloaderPath = "http://localhost/project/fl";
            this.addEventListener(Event.ENTER_FRAME, loading);
            startLoad();
            return;
        }// end function

        public function loadRemoting(param1:Number)
        {
            var _loc_2:*;
            var _loc_3:*;
            _loc_2 = new NetConnection();
            _loc_2.connect(remoteConnectionPath);
            _loc_3 = new Responder(getPerson_Result, onFault);
            _loc_2.call("PineGrove.getImages", _loc_3, param1);
            return;
        }// end function

        public function scrollThumbs(param1:Event) : void
        {
            holder_mc.y = holder_mc.y + Math.cos((-thumbMask_mc.mouseY) / scrollPaneHeight * Math.PI) * scrollSpeed;
            if (holder_mc.y > scrollPaneY)
            {
                holder_mc.y = scrollPaneY;
            }// end if
            if (-holder_mc.y > holder_mc.height - scrollPaneHeight - scrollPaneY)
            {
                holder_mc.y = -(holder_mc.height - scrollPaneHeight - scrollPaneY);
            }// end if
            return;
        }// end function

        public function startHomePage(param1:Number)
        {
            loadHomeImages(homeImagesPath + imagesArr[param1]);
            return;
        }// end function

        public function bigImagePreLoader() : void
        {
            loadBar = new Sprite();
            loadBar.graphics.beginFill(10747905);
            loadBar.graphics.drawRect(0, 0, 1, 2);
            loadBar.graphics.endFill();
            loadBar.x = 6;
            loadBar.y = 5;
            loadBar.width = 0;
            addChild(loadBar);
            return;
        }// end function

        public function getPerson_Result(param1:Object)
        {
            var _loc_2:Number;
            var _loc_3:*;
            _loc_2 = param1.serverInfo.totalCount;
            if (imagesArr.length > 0)
            {
                emptyImageArray();
            }// end if
            _loc_3 = 0;
            while (_loc_3++ < _loc_2)
            {
                // label
                imagesArr[_loc_3] = param1.serverInfo.initialData[_loc_3][2];
            }// end while
            switch(tid)
            {
                case 1:
                {
                    scrollHeading.visible = false;
                    cleanHomePage();
                    cleanOutThumbs();
                    startHomePage(0);
                    break;
                }// end case
                case 2:
                {
                    scrollHeading.visible = true;
                    scrollHeading.heading_txt.text = "Wedding & Cermanies";
                    cleanHomePage();
                    cleanOutThumbs();
                    loadThumbs();
                    break;
                }// end case
                case 3:
                {
                    scrollHeading.visible = true;
                    scrollHeading.heading_txt.text = "Receptions";
                    cleanOutThumbs();
                    cleanHomePage();
                    loadThumbs();
                    break;
                }// end case
                default:
                {
                    trace("Problem in Button Pointer");
                    break;
                }// end default
            }// end switch
            return;
        }// end function

        public function weddingImageLoading(param1:ProgressEvent) : void
        {
            var _loc_2:Number;
            _loc_2 = param1.bytesLoaded / param1.bytesTotal;
            loadBar.width = _loc_2 * 900;
            stopTIMER();
            return;
        }// end function

        public function homeImageLoaded(param1:Event) : void
        {
            while (homeContainerMC.numChildren > 0)
            {
                // label
                homeContainerMC.removeChildAt(0);
            }// end while
            bigHomeMC = new MovieClip();
            homeContainerMC.addChild(bigHomeMC);
            bigHomeMC.addChild(homeImageLoader);
            bigHomeMC.x = 14;
            bigHomeMC.y = 125;
            bigHomeMC.x = homeBG.width / 2 - homeImageLoader.content.width / 2 + 6;
            bigHomeMC.y = homeBG.height / 2 - homeImageLoader.content.height / 2 + 10;
            homeBorder.visible = true;
            homeBorder.width = homeImageLoader.content.width + 12;
            homeBorder.height = homeImageLoader.content.height + 12;
            TweenLite.from(bigHomeMC, 3, {alpha:0, overwrite:false, ease:Circ.easeIn});
            loadBar.width = 0;
            startTIMER();
            return;
        }// end function

        public function emptyImageArray()
        {
            imagesArr.splice(0, imagesArr.length);
            return;
        }// end function

        public function addScrollListeners() : void
        {
            holder_mc.addEventListener(MouseEvent.ROLL_OVER, startScroll);
            holder_mc.addEventListener(MouseEvent.ROLL_OUT, stopScroll);
            return;
        }// end function

        public function constructScroller() : void
        {
            holder_mc.x = scrollPaneX;
            holder_mc.y = scrollPaneY;
            thumbMask_mc.graphics.beginFill(16777215);
            thumbMask_mc.graphics.drawRect(0, 0, scrollPaneWidth, scrollPaneHeight);
            thumbMask_mc.graphics.endFill();
            thumbMask_mc.x = scrollPaneX - 5;
            thumbMask_mc.y = scrollPaneY - 5;
            addChild(thumbMask_mc);
            holder_mc.mask = thumbMask_mc;
            thumbTrackBg_mc.graphics.beginFill(16777215);
            thumbTrackBg_mc.graphics.drawRect(0, 0, scrollPaneWidth, scrollPaneHeight);
            thumbTrackBg_mc.graphics.endFill();
            thumbTrackBg_mc.alpha = 0;
            thumbTrackBg_mc.x = 0;
            thumbTrackBg_mc.y = 0;
            thumbTrackBg_mc.width = scrollPaneWidth;
            thumbTrackBg_mc.height = scrollTrackHeight;
            holder_mc.addChildAt(thumbTrackBg_mc, 0);
            return;
        }// end function

        public function showActiveThumb(param1:int) : void
        {
            var _loc_2:int;
            _loc_2 = 0;
            while (_loc_2 < holder_mc.numChildren--)
            {
                // label
                if (holder_mc.getChildAt(_loc_2) is MovieClip)
                {
                    if (MovieClip(holder_mc.getChildAt(_loc_2)).pictureValue == param1)
                    {
                        holder_mc.getChildAt(_loc_2).alpha = 0.5;
                    }
                    else
                    {
                        holder_mc.getChildAt(_loc_2).alpha = 1;
                    }// end if
                }// end else if
                _loc_2++;
            }// end while
            return;
        }// end function

        public function loading(param1:Event) : void
        {
            var _loc_2:Number;
            var _loc_3:Number;
            _loc_2 = this.stage.loaderInfo.bytesTotal;
            _loc_3 = this.stage.loaderInfo.bytesLoaded;
            if (_loc_2 == _loc_3)
            {
                play();
                this.removeEventListener(Event.ENTER_FRAME, loading);
            }// end if
            return;
        }// end function

        public function loadBigImage(param1:MouseEvent = null, param2:int = ) : void
        {
            if (param1 != null)
            {
                targetThumbs = param1.currentTarget.pictureValue;
            }
            else
            {
                targetThumbs = param2;
            }// end else if
            stopTIMER();
            startWeddingPage(targetThumbs);
            return;
        }// end function

        public function weddingImageLoaded(param1:Event) : void
        {
            while (weddingContainerMC.numChildren > 0)
            {
                // label
                weddingContainerMC.removeChildAt(0);
            }// end while
            weddingMC = new MovieClip();
            weddingContainerMC.addChild(weddingMC);
            weddingMC.addChild(weddingImageLoader);
            weddingMC.x = weddingBG.width / 2 - weddingImageLoader.content.width / 2 + 6;
            weddingMC.y = weddingBG.height / 2 - weddingImageLoader.content.height / 2 + 10;
            weddingBorder.visible = true;
            weddingBorder.width = weddingImageLoader.content.width + 12;
            weddingBorder.height = weddingImageLoader.content.height + 12;
            TweenLite.from(weddingMC, 3, {alpha:0, overwrite:false});
            startTIMER();
            loadBar.width = 0;
            return;
        }// end function

        public function overThumb(param1:MouseEvent) : void
        {
            TweenLite.to(param1.target, 0.3, {alpha:0.7});
            stopTIMER();
            return;
        }// end function

        public function stopScroll(param1:MouseEvent) : void
        {
            thumbMask_mc.removeEventListener(Event.ENTER_FRAME, scrollThumbs);
            return;
        }// end function

        public function cleanHomePage() : void
        {
            if (homeImageLoader != null)
            {
                homeImageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, homeImageLoading);
                homeImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, homeImageLoaded);
                homeImageLoader.unload();
            }// end if
            if (homeContainerMC.numChildren > 0)
            {
                while (homeContainerMC.numChildren > 0)
                {
                    // label
                    homeContainerMC.removeChildAt(0);
                }// end while
            }// end if
            homeBorder.visible = false;
            return;
        }// end function

        public function thumbLoaded(param1:Event) : void
        {
            var _loc_2:DisplayObject;
            if (pictureValue == 0)
            {
                scrollPaneX = 754;
                scrollPaneY = 55;
                scrollPaneWidth = thumbLoader.content.width + 12;
                scrollPaneHeight = thumbLoader.content.height * visThumbs + padding * visThumbs-- + 55;
                scrollTrackHeight = thumbLoader.content.height * imagesArr.length + padding * imagesArr.length--;
                constructScroller();
            }// end if
            child = new KamMC();
            child.pictureValue = pictureValue++;
            _loc_2 = param1.target.content;
            thumbLoader.unload();
            child.addChild(_loc_2);
            child.addEventListener(MouseEvent.MOUSE_OVER, overThumb);
            child.addEventListener(MouseEvent.MOUSE_OUT, offThumb);
            child.addEventListener(MouseEvent.CLICK, loadBigImage);
            holder_mc.addChild(child);
            TweenLite.from(child, 3, {alpha:0});
            child.y = changey;
            changey = changey + child.height + padding;
            child.buttonMode = true;
            if (p < imagesArr.length)
            {
                loadThumbs();
            }// end if
            if (p == imagesArr.length)
            {
                if (child.width * p + padding * p-- > scrollPaneWidth)
                {
                    addScrollListeners();
                }// end if
                if (noRepeat == false)
                {
                    noRepeat = true;
                    startWeddingPage(0);
                }// end if
            }// end if
            return;
        }// end function

        public function onFault(param1:Event)
        {
            trace("There was a problem");
            return;
        }// end function

        public function resetSlide()
        {
            if (isRunning)
            {
                isRunning = false;
                pointer = 1;
                _ptimer.timer.removeEventListener(TimerEvent.TIMER, executeAndRepeat);
            }// end if
            return;
        }// end function

        public function loadWeddingImages(param1:String) : void
        {
            weddingImageLoader = new Loader();
            weddingImageLoader.load(new URLRequest(param1));
            weddingImageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, weddingImageLoading);
            weddingImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, weddingImageLoaded);
            return;
        }// end function

        public function offThumb(param1:MouseEvent) : void
        {
            TweenLite.to(param1.target, 2, {alpha:1});
            startTIMER();
            return;
        }// end function

        public function loadHomeImages(param1:String) : void
        {
            homeImageLoader = new Loader();
            homeImageLoader.load(new URLRequest(param1));
            homeImageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, homeImageLoading);
            homeImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, homeImageLoaded);
            return;
        }// end function

        public function startScroll(param1:MouseEvent) : void
        {
            thumbMask_mc.addEventListener(Event.ENTER_FRAME, scrollThumbs);
            return;
        }// end function

        public function homeImageLoading(param1:ProgressEvent) : void
        {
            var _loc_2:Number;
            _loc_2 = param1.bytesLoaded / param1.bytesTotal;
            if (_loc_2 == 1)
            {
                firstImage = true;
            }// end if
            if (!firstImage)
            {
                if (_loc_2 > 0.95)
                {
                    if (!dontRepeat)
                    {
                        dontRepeat = true;
                        cleanPreloader();
                    }// end if
                }// end if
            }
            else
            {
                loadBar.width = _loc_2 * 900;
            }// end else if
            stopTIMER();
            return;
        }// end function

        public function loadThumbs() : void
        {
            thumbLoader.contentLoaderInfo.addEventListener(Event.INIT, thumbLoaded);
            thumbLoader.load(new URLRequest(imagesThumbPath + imagesArr[p]));
            p++;
            return;
        }// end function

        public function onCompleteHandler(param1:Event)
        {
            box = new MovieClip();
            addChild(box);
            box.x = 200;
            box.y = 100;
            box.addChild(param1.currentTarget.content);
            return;
        }// end function

    }
}
