//----------------------------------------------------------------------------------------------------------------------
// Day X, Word: Description.
//----------------------------------------------------------------------------------------------------------------------
// Imports

const q = await Q5.WebGPU()
const FILE_TITLE = "DayXXWord"
const SIZE_WINDOW = 600
const HANDLE_RECORDER = createRecorder()
HANDLE_RECORDER.captureAudio = false
let FRAME_START = null
const FRAME_FPS = 60
const FRAME_END = FRAME_FPS * 5

//----------------------------------------------------------------------------------------------------------------------
// Classes



//----------------------------------------------------------------------------------------------------------------------
// Sketch Functions

q.setup = () => {
    createCanvas(SIZE_WINDOW, SIZE_WINDOW);
}

q.draw = () => {
	background("white");
	if (recording && frameCount - FRAME_START === FRAME_END) {
		saveRecording(FILE_TITLE)
		pauseRecording()
	}
}

q.mousePressed = () => {
	if (!recording) {
		FRAME_START = frameCount
		record()
	}
}

window.quit = function quit() {
	canvas.remove()
}

//----------------------------------------------------------------------------------------------------------------------