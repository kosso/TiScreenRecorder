
TiScreenRecorder
===========================================

A simple Appcelerator Titanium module for iOS screen recording. (in progress) 



IDEAS:

- Hide recording button when starting. Add a shake gesture to stop recording.

- Add audio recording.

- Allow specifying an area of screen to record.

- Generate a GIF ;) 

- Show location of touches.

  ​


#### Usage

Example app.js

```javascript


// TiScreenRecorder : example app. 
// @kosso : November 2016


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});

var label = Ti.UI.createLabel({
	text: 'ready',
	backgroundColor: '#99ffffff',
	color: '#333',
	width: Ti.UI.SIZE,
	borderRadius: 6,
	bottom: 5,
	left: 5,
	zIndex: 10
});

win.add(label);

var screenrecorder = require('com.kosso.tiscreenrecorder');

var isRecording = false;


var btn_rec = Ti.UI.createButton({
	  title: ' o ',
	  width: 30,
	  bottom: 5,
	  zIndex: 10,
	  height: 30,
	  borderRadius: 15,
	  color: 'white',
	  tintColor: 'white',
	  textAlign: 'center',
	  backgroundColor: '#990000'
});



btn_rec.addEventListener('click', function(){

	if(isRecording){
		screenrecorder.stopRecording();
		label.text = 'stopped';
	  	setTimeout(function(){
	  		label.text = 'ready';
	  	}, 3000);

	} else {

		var d = new Date();
		var filename = 'recording_'+d.getTime()+'.mp4';
		var file = Titanium.Filesystem.getFile(Titanium.Filesystem.applicationDataDirectory, filename);
		if ( file.exists() ) {
		     file.deleteFile();
		}
		var video_url = file.nativePath; // eg: file:///etc/etc...
		file = null;
		console.log('video_url : ', video_url);

			
	 	screenrecorder.startRecording(video_url);
	 	// To just automatically save the video to the Camera Roll, leave out the video url 
	 	// eg: screenrecorder.startRecording();

	 	label.text = 'recording';
		
	}
	isRecording = !isRecording;
});


screenrecorder.addEventListener('success', function(e){
	console.log('screen recording done! : ', e);
	// Saved video is at e.nativePath (if a video_url was set)

});

// Just something to record... 

var wv = Ti.UI.createWebView({
	url : 'http://nextnext.com',
	width: Ti.UI.FILL,
	height: Ti.UI.FILL,
	backgroundColor: '#eee',
	zIndex: 1
});

win.add(wv);
win.add(btn_rec);

win.open();

```



-------

**Credit** : 

- ASScreenRecorder : https://github.com/alskipp/ASScreenRecorder
- For the inspiration in an unrelated test app by @mattbierner - https://github.com/mattbierner/tenome-app
- For the instructions to show how to enable ARC only on selected (required) files in Titanium modules. - http://www.itexico.com/blog/bid/100221/Mobile-App-Development-Advanced-Tricks-For-iOS-Modules-In-Appcelerator-Titanium

------

**Author** : @kosso - November 2016

