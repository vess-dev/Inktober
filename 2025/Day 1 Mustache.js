//----------------------------------------------------------------------------------------------------------------------
// Day 1, Mustache: I mustache you a question.
//----------------------------------------------------------------------------------------------------------------------
// Imports

const q = await Q5.WebGPU()
const FILE_TITLE = "Day 1 Mustache"
const SIZE_WINDOW = 600
const HANDLE_RECORDER = createRecorder()
HANDLE_RECORDER.captureAudio = false
let FRAME_START = null
const FRAME_FPS = 60
const FRAME_END = FRAME_FPS * 5

const SIZE_COUNT = 200
const SIZE_INC = 2
const SIZE_MAX = 100
const SIZE_MIN = -SIZE_MAX
let SIZE_ROTATION = 0

//----------------------------------------------------------------------------------------------------------------------
// Classes

class Question {
	constructor() {
		this.posX = (random() - 0.5) * SIZE_WINDOW
		this.posY = (random() - 0.5) * SIZE_WINDOW
		this.size = random(SIZE_MIN, SIZE_MAX)
		this.sizeInc = SIZE_INC
		this.sizeFlip = 1
	}
	draw() {
		textSize(this.size)
		text("?", this.posX, this.posY)
		rotate(SIZE_ROTATION)
		SIZE_ROTATION += 0.000001
		this.step()
	}
	flip() {
		this.sizeFlip = -this.sizeFlip
		this.sizeInc = SIZE_INC
	}
	step() {
		if (this.size >= SIZE_MAX && this.sizeFlip > 0) {
			this.flip()
		} else if (this.size <= SIZE_MIN && this.sizeFlip < 0) {
			this.flip()
		}
		this.size += this.sizeFlip * this.sizeInc
		this.sizeInc *= 1.0000000001
	}
}

let QUESTION_ARRAY = new Array(SIZE_COUNT).fill().map(_ => new Question())

//----------------------------------------------------------------------------------------------------------------------
// Sketch Functions

q.setup = () => {
    createCanvas(SIZE_WINDOW, SIZE_WINDOW);
}

q.draw = () => {
	background("aqua");
	QUESTION_ARRAY.forEach(q => q.draw())
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