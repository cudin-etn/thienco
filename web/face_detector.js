// MediaPipe Face Landmarker for Flutter web
// Self-initializing module that exposes functions on window
import {
  FaceLandmarker,
  FilesetResolver,
} from 'https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@0.10.35/vision_bundle.mjs';

const WASM_PATH =
  'https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@0.10.35/wasm/';
const MODEL_PATH =
  'https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/latest/face_landmarker.task';

let faceLandmarker = null;

async function init() {
  try {
    const vision = await FilesetResolver.forVisionTasks(WASM_PATH);
    faceLandmarker = await FaceLandmarker.createFromOptions(vision, {
      baseOptions: {
        modelAssetPath: MODEL_PATH,
      },
      runningMode: 'IMAGE',
      outputFaceBlendshapes: false,
      outputFacialTransformationMatrixes: false,
      numFaces: 1,
    });
    window.__mediapipeReady = true;
  } catch (e) {
    window.__mediapipeReady = false;
    window.__mediapipeError = e && e.message ? e.message : 'Init failed';
  }
}

async function detect(dataUrl) {
  try {
    if (!faceLandmarker) {
      return JSON.stringify({ error: 'Not initialized' });
    }

    const img = new Image();
    img.src = dataUrl;
    await img.decode();

    const result = faceLandmarker.detect(img);
    if (!result || !result.faceLandmarks || result.faceLandmarks.length === 0) {
      return JSON.stringify({ error: 'No face detected' });
    }

    const face = result.faceLandmarks[0];
    return JSON.stringify({
      landmarks: face.map((l) => ({
        x: l.x,
        y: l.y,
        z: l.z,
      })),
      imgWidth: img.naturalWidth,
      imgHeight: img.naturalHeight,
    });
  } catch (e) {
    return JSON.stringify({ error: e && e.message ? e.message : 'Detection error' });
  }
}

window.__mediapipeInit = init;
window.__mediapipeDetect = detect;
